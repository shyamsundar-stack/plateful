import { createClient } from "@/lib/supabase/server";
import Header from "@/components/header";
import WeekNavigator from "@/components/week-navigator";
import NutritionDayCard from "@/components/nutrition-day-card";
import type {
  MealSlotWithRecipe,
  MealSlotParticipantWithMember,
  HouseholdMember,
  Recipe,
  UnitConversion,
  RecipeIngredientWithDetails,
  RecipeNutrition,
  MemberTargets,
  SwapSuggestion,
} from "@/lib/types/database";
import {
  buildConversionMap,
  calculateRecipeNutrition,
  calculateWeekNutrition,
  calculateMemberTargets,
  getSwapSuggestion,
  getImbalanceFlags,
} from "@/lib/nutrition";

// Compute current Monday (local timezone safe)
function getMonday(date: Date = new Date()): string {
  const d = new Date(date);
  const day = d.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  d.setDate(d.getDate() + diff);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
}

export default async function NutritionPage({
  searchParams,
}: {
  searchParams: Promise<{ week?: string }>;
}) {
  const params = await searchParams;
  const monday = params.week || getMonday();

  const supabase = await createClient();

  // Fetch week plan
  const { data: weekPlan } = await supabase
    .from("week_plans")
    .select("*")
    .eq("start_date", monday)
    .eq("is_archived", false)
    .maybeSingle();

  if (!weekPlan) {
    return (
      <div className="min-h-screen bg-cream">
        <Header />
        <main className="max-w-4xl mx-auto px-4 py-6">
          <WeekNavigator currentMonday={monday} basePath="/nutrition" />
          <div className="mt-12 text-center">
            <p className="text-5xl mb-4">📊</p>
            <h2 className="text-lg font-semibold text-ink mb-2">
              No meal plan for this week
            </h2>
            <p className="text-sm text-ink-muted">
              Plan your week first to see nutrition data.
            </p>
          </div>
        </main>
      </div>
    );
  }

  // Fetch all data in parallel
  const [slotsResult, membersResult, recipesResult, ucResult] =
    await Promise.all([
      supabase
        .from("meal_slots")
        .select("*, recipes(title, cuisine, total_time_min, is_vegetarian)")
        .eq("week_plan_id", weekPlan.id)
        .in("meal_type", ["breakfast", "lunch", "dinner"])
        .order("slot_date")
        .order("meal_type"),
      supabase
        .from("household_members")
        .select("*")
        .eq("is_archived", false)
        .order("name"),
      supabase
        .from("recipes")
        .select("*")
        .eq("status", "active")
        .order("title"),
      supabase.from("unit_conversions").select("*"),
    ]);

  const slots = (slotsResult.data ?? []) as MealSlotWithRecipe[];
  const members = (membersResult.data ?? []) as HouseholdMember[];
  const recipes = (recipesResult.data ?? []) as Recipe[];
  const unitConversions = (ucResult.data ?? []) as UnitConversion[];
  const conversionMap = buildConversionMap(unitConversions);

  // Fetch participants
  let participants: MealSlotParticipantWithMember[] = [];
  if (slots.length > 0) {
    const slotIds = slots.map((s) => s.id);
    const { data: partData } = await supabase
      .from("meal_slot_participants")
      .select("*, household_members(name)")
      .in("meal_slot_id", slotIds);
    participants = (partData ?? []) as MealSlotParticipantWithMember[];
  }

  // Get distinct recipe IDs (including leftover sources)
  const recipeIds = Array.from(
    new Set(
      slots
        .filter((s) => s.recipe_id != null)
        .map((s) => s.recipe_id as string)
    )
  );
  for (const slot of slots) {
    if (slot.meal_mode === "leftover" && slot.leftover_source_id) {
      const source = slots.find((s) => s.id === slot.leftover_source_id);
      if (source?.recipe_id && !recipeIds.includes(source.recipe_id)) {
        recipeIds.push(source.recipe_id);
      }
    }
  }

  // Fetch recipe ingredients
  let recipeIngredients: RecipeIngredientWithDetails[] = [];
  if (recipeIds.length > 0) {
    const { data: riData } = await supabase
      .from("recipe_ingredients")
      .select("*, ingredients(*)")
      .in("recipe_id", recipeIds);
    recipeIngredients = (riData ?? []) as RecipeIngredientWithDetails[];
  }

  // Group ingredients by recipe_id
  const ingredientsByRecipe = new Map<string, RecipeIngredientWithDetails[]>();
  for (const ri of recipeIngredients) {
    const existing = ingredientsByRecipe.get(ri.recipe_id) ?? [];
    existing.push(ri);
    ingredientsByRecipe.set(ri.recipe_id, existing);
  }

  // Calculate nutrition per recipe
  const recipeNutritionMap = new Map<string, RecipeNutrition>();
  for (const recipeId of recipeIds) {
    const ingredients = ingredientsByRecipe.get(recipeId) ?? [];
    const slotWithRecipe = slots.find((s) => s.recipe_id === recipeId);
    const servings = slotWithRecipe?.servings_override ?? 2;
    recipeNutritionMap.set(
      recipeId,
      calculateRecipeNutrition(recipeId, servings, ingredients, conversionMap)
    );
  }

  // Also build nutrition map for ALL active recipes (for swap suggestions)
  const allRecipeNutrition = new Map<string, RecipeNutrition>(
    recipeNutritionMap
  );
  // For recipes not already computed — we'd need their ingredients too.
  // For now, swap suggestions only work with recipes whose ingredients we've fetched.

  // Group participants by slot
  const participantsBySlot = new Map<
    string,
    MealSlotParticipantWithMember[]
  >();
  for (const p of participants) {
    const existing = participantsBySlot.get(p.meal_slot_id) ?? [];
    existing.push(p);
    participantsBySlot.set(p.meal_slot_id, existing);
  }

  // Calculate week nutrition
  const weekNutrition = calculateWeekNutrition(
    slots,
    recipeNutritionMap,
    participantsBySlot,
    members,
    ingredientsByRecipe,
    slots
  );

  // Calculate member targets
  const memberTargetsMap = new Map<string, MemberTargets>();
  for (const m of members) {
    memberTargetsMap.set(m.id, calculateMemberTargets(m));
  }

  // Calculate swap suggestions for flagged days
  const swapSuggestions = new Map<string, SwapSuggestion>();
  for (const day of weekNutrition.days) {
    if (day.isPartial) continue;

    // Find the most deficient macro across all members on this day
    let worstMacro: "protein" | "carbs" | "fat" | null = null;
    let worstRatio = 1;

    for (const mn of day.perMember) {
      const targets = memberTargetsMap.get(mn.memberId);
      if (!targets) continue;
      const flags = getImbalanceFlags(
        { protein: mn.protein, carbs: mn.carbs, fat: mn.fat },
        targets
      );
      for (const f of flags) {
        if (f.level === "red" || f.level === "yellow") {
          const ratio = f.target > 0 ? f.actual / f.target : 1;
          if (ratio < worstRatio) {
            worstRatio = ratio;
            worstMacro = f.macro;
          }
        }
      }
    }

    if (worstMacro) {
      const daySlots = slots.filter((s) => s.slot_date === day.date);
      const suggestion = getSwapSuggestion(
        daySlots,
        recipeNutritionMap,
        worstMacro,
        recipes,
        allRecipeNutrition
      );
      if (suggestion) {
        swapSuggestions.set(day.date, suggestion);
      }
    }
  }

  // Check if any member has incomplete profile
  const membersWithoutTDEE = members.filter(
    (m) =>
      m.weight_kg == null || m.height_cm == null || m.age == null
  );

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-4xl mx-auto px-4 py-6">
        <WeekNavigator currentMonday={monday} basePath="/nutrition" />

        {/* Week summary header */}
        <div className="bg-surface rounded-xl border border-ink-light/10 p-4 mt-4 mb-4">
          <h2 className="text-lg font-semibold text-ink mb-3">
            Weekly Nutrition Overview
          </h2>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
            <SummaryCard
              label="Avg Calories"
              value={weekNutrition.avgCalories}
              unit="kcal"
            />
            <SummaryCard
              label="Avg Protein"
              value={weekNutrition.avgProtein}
              unit="g"
              color="text-blue-600"
            />
            <SummaryCard
              label="Avg Carbs"
              value={weekNutrition.avgCarbs}
              unit="g"
              color="text-amber-600"
            />
            <SummaryCard
              label="Avg Fat"
              value={weekNutrition.avgFat}
              unit="g"
              color="text-orange-600"
            />
          </div>

          {/* Status badges */}
          <div className="flex flex-wrap gap-2">
            {weekNutrition.imbalancedDayCount > 0 && (
              <span className="text-xs px-2.5 py-1 rounded-full bg-red-50 text-red-700 font-medium">
                📉 {weekNutrition.imbalancedDayCount}{" "}
                {weekNutrition.imbalancedDayCount === 1 ? "day" : "days"}{" "}
                below target
              </span>
            )}
            {weekNutrition.pregnancyAlertCount > 0 && (
              <span className="text-xs px-2.5 py-1 rounded-full bg-amber-50 text-amber-700 font-medium">
                ⚠️ {weekNutrition.pregnancyAlertCount} pregnancy{" "}
                {weekNutrition.pregnancyAlertCount === 1 ? "alert" : "alerts"}
              </span>
            )}
            {weekNutrition.imbalancedDayCount === 0 &&
              weekNutrition.pregnancyAlertCount === 0 && (
                <span className="text-xs px-2.5 py-1 rounded-full bg-green-50 text-green-700 font-medium">
                  🟢 All days on target
                </span>
              )}
          </div>
        </div>

        {/* Incomplete profile warning */}
        {membersWithoutTDEE.length > 0 && (
          <div className="bg-blue-50 border border-blue-200 rounded-xl px-4 py-3 mb-4">
            <p className="text-xs text-blue-800">
              ℹ️ Complete profile for{" "}
              <span className="font-semibold">
                {membersWithoutTDEE.map((m) => m.name).join(", ")}
              </span>{" "}
              (age, height, weight) to see personalized targets and imbalance
              flags.
            </p>
          </div>
        )}

        {/* Member TDEE targets */}
        <div className="bg-surface rounded-xl border border-ink-light/10 p-4 mb-4">
          <h3 className="text-sm font-semibold text-ink mb-2">
            Daily Targets (per member)
          </h3>
          <div className="space-y-2">
            {members.map((m) => {
              const targets = memberTargetsMap.get(m.id);
              if (!targets) return null;
              return (
                <div
                  key={m.id}
                  className="flex items-center justify-between bg-cream/50 rounded-lg px-3 py-2"
                >
                  <span className="text-xs font-semibold text-ink">
                    {m.name}
                    {m.pregnancy_trimester > 0 && (
                      <span className="ml-1 text-amber-600 font-normal">
                        (T{m.pregnancy_trimester})
                      </span>
                    )}
                  </span>
                  {targets.tdee != null ? (
                    <div className="flex gap-3 text-xs text-ink-muted">
                      <span>
                        <span className="font-medium text-ink">
                          {targets.tdee}
                        </span>{" "}
                        kcal
                      </span>
                      <span>
                        P{" "}
                        <span className="font-medium text-blue-600">
                          {targets.proteinTarget}g
                        </span>
                      </span>
                      <span>
                        C{" "}
                        <span className="font-medium text-amber-600">
                          {targets.carbsTarget}g
                        </span>
                      </span>
                      <span>
                        F{" "}
                        <span className="font-medium text-orange-600">
                          {targets.fatTarget}g
                        </span>
                      </span>
                    </div>
                  ) : (
                    <span className="text-xs text-ink-muted italic">
                      Complete profile to see targets
                    </span>
                  )}
                </div>
              );
            })}
          </div>
        </div>

        {/* Daily breakdown */}
        <h3 className="text-sm font-semibold text-ink mb-3">
          Daily Breakdown
        </h3>
        <div className="space-y-3">
          {weekNutrition.days.map((day) => (
            <NutritionDayCard
              key={day.date}
              day={day}
              memberTargets={memberTargetsMap}
              swapSuggestion={swapSuggestions.get(day.date) ?? null}
            />
          ))}
        </div>

        {weekNutrition.days.length === 0 && (
          <div className="mt-8 text-center">
            <p className="text-5xl mb-4">🥗</p>
            <p className="text-sm text-ink-muted">
              Assign recipes to your meals to see nutrition data.
            </p>
          </div>
        )}
      </main>
    </div>
  );
}

function SummaryCard({
  label,
  value,
  unit,
  color,
}: {
  label: string;
  value: number;
  unit: string;
  color?: string;
}) {
  return (
    <div className="text-center bg-cream/50 rounded-lg px-3 py-2">
      <p className={`text-lg font-bold ${color ?? "text-ink"}`}>
        {Math.round(value)}
        <span className="text-xs font-normal text-ink-muted ml-0.5">
          {unit}
        </span>
      </p>
      <p className="text-[11px] text-ink-muted">{label}</p>
    </div>
  );
}
