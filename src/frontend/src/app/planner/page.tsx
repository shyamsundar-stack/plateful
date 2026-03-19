import { createClient } from "@/lib/supabase/server";
import Header from "@/components/header";
import WeekNavigator from "@/components/week-navigator";
import PlannerGrid from "@/components/planner-grid";
import type {
  WeekPlan,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  HouseholdMember,
  Recipe,
  UnitConversion,
  RecipeIngredientWithDetails,
  RecipeNutrition,
  WeekNutrition,
  PregnancyAlert,
  MemberDietaryPref,
  DietaryConflictMap,
  RecipePreference,
} from "@/lib/types/database";
import { getSlotRecipeIds } from "@/lib/meal-utils";
import {
  buildConversionMap,
  calculateRecipeNutrition,
  calculateWeekNutrition,
  checkPregnancyAlerts,
} from "@/lib/nutrition";
import { computeDietaryConflictMap } from "@/lib/dietary";
import { detectRepeatedRecipes } from "@/lib/variety";

// Compute current Monday (local timezone safe — no UTC shift)
function getMonday(date: Date = new Date()): string {
  const d = new Date(date);
  const day = d.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  d.setDate(d.getDate() + diff);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, "0");
  const dd = String(d.getDate()).padStart(2, "0");
  return `${year}-${month}-${dd}`;
}

export default async function PlannerPage({
  searchParams,
}: {
  searchParams: Promise<{ week?: string }>;
}) {
  const params = await searchParams;
  const monday = params.week || getMonday();

  const supabase = await createClient();

  // Fetch week plan for this Monday
  const { data: weekPlan } = await supabase
    .from("week_plans")
    .select("*")
    .eq("start_date", monday)
    .eq("is_archived", false)
    .maybeSingle();

  let slots: MealSlotWithDishes[] = [];
  let participants: MealSlotParticipantWithMember[] = [];
  let weekNutrition: WeekNutrition | null = null;
  const pregnancyAlertsBySlot: Record<string, PregnancyAlert[]> = {};
  let dietaryConflictMap: DietaryConflictMap = {};
  let dietaryPrefs: MemberDietaryPref[] = [];
  let recipePreferences: RecipePreference[] = [];
  if (weekPlan) {
    // Fetch all slots (B/L/D/S) with recipe info + multi-dish data
    const { data: slotData } = await supabase
      .from("meal_slots")
      .select("*, recipes(title, cuisine, total_time_min, is_vegetarian), meal_slot_dishes(*, recipes(title, cuisine, total_time_min, is_vegetarian))")
      .eq("week_plan_id", weekPlan.id)
      .order("slot_date")
      .order("meal_type");

    slots = (slotData ?? []) as MealSlotWithDishes[];

    // Fetch participants for all slots
    if (slots.length > 0) {
      const slotIds = slots.map((s) => s.id);
      const { data: partData } = await supabase
        .from("meal_slot_participants")
        .select("*, household_members(name)")
        .in("meal_slot_id", slotIds);

      participants = (partData ?? []) as MealSlotParticipantWithMember[];
    }

    // --- Nutrition data fetch (Session 10) ---
    // Get distinct recipe IDs used this week (multi-dish aware)
    const recipeIdSet = new Set<string>();
    for (const slot of slots) {
      // Collect from multi-dish junction table AND legacy recipe_id
      const slotRecipeIds = getSlotRecipeIds(slot);
      for (const id of slotRecipeIds) recipeIdSet.add(id);

      // Also resolve leftover source recipes
      if (slot.meal_mode === "leftover" && slot.leftover_source_id) {
        const sourceSlot = slots.find(
          (s) => s.id === slot.leftover_source_id
        );
        if (sourceSlot) {
          const sourceIds = getSlotRecipeIds(sourceSlot);
          for (const id of sourceIds) recipeIdSet.add(id);
        }
      }
    }
    const recipeIds = Array.from(recipeIdSet);

    if (recipeIds.length > 0) {
      // Batch fetch recipe_ingredients with ingredient details
      const { data: riData } = await supabase
        .from("recipe_ingredients")
        .select("*, ingredients(*)")
        .in("recipe_id", recipeIds);

      const recipeIngredients = (riData ?? []) as RecipeIngredientWithDetails[];

      // Fetch unit conversions
      const { data: ucData } = await supabase
        .from("unit_conversions")
        .select("*");

      const unitConversions = (ucData ?? []) as UnitConversion[];
      const conversionMap = buildConversionMap(unitConversions);

      // Group ingredients by recipe_id
      const ingredientsByRecipe = new Map<
        string,
        RecipeIngredientWithDetails[]
      >();
      for (const ri of recipeIngredients) {
        const existing = ingredientsByRecipe.get(ri.recipe_id) ?? [];
        existing.push(ri);
        ingredientsByRecipe.set(ri.recipe_id, existing);
      }

      // Calculate nutrition per recipe
      const recipeNutritionMap = new Map<string, RecipeNutrition>();
      for (const recipeId of recipeIds) {
        const ingredients = ingredientsByRecipe.get(recipeId) ?? [];
        // Find servings from slot recipe data or default to 1
        const slotWithRecipe = slots.find((s) => s.recipe_id === recipeId);
        const servings = slotWithRecipe?.servings_override ?? 2; // Default 2 servings
        const nutrition = calculateRecipeNutrition(
          recipeId,
          servings,
          ingredients,
          conversionMap
        );
        recipeNutritionMap.set(recipeId, nutrition);
      }

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

      // Fetch members for TDEE + pregnancy checks
      const { data: membersForNutrition } = await supabase
        .from("household_members")
        .select("*")
        .eq("is_archived", false)
        .order("name");

      const allMembers = (membersForNutrition ?? []) as HouseholdMember[];

      // Calculate week nutrition
      weekNutrition = calculateWeekNutrition(
        slots,
        recipeNutritionMap,
        participantsBySlot,
        allMembers,
        ingredientsByRecipe,
        slots
      );

      // Pre-compute pregnancy alerts per slot (for ⚠️ badges on cards)
      const memberMap = new Map<string, HouseholdMember>();
      for (const m of allMembers) memberMap.set(m.id, m);

      for (const slot of slots) {
        const slotParts = participantsBySlot.get(slot.id) ?? [];
        const activeMembers = slotParts
          .filter((p) => p.is_participating)
          .map((p) => memberMap.get(p.member_id))
          .filter((m): m is HouseholdMember => m != null);

        // Collect ingredients from ALL dishes in the slot (multi-dish aware)
        const slotIngredients: RecipeIngredientWithDetails[] = [];
        if (slot.meal_mode === "cook") {
          const slotRecipeIds = getSlotRecipeIds(slot);
          for (const rid of slotRecipeIds) {
            const ri = ingredientsByRecipe.get(rid) ?? [];
            slotIngredients.push(...ri);
          }
        } else if (slot.meal_mode === "leftover" && slot.leftover_source_id) {
          const sourceSlot = slots.find(
            (s) => s.id === slot.leftover_source_id
          );
          if (sourceSlot) {
            const sourceRecipeIds = getSlotRecipeIds(sourceSlot);
            for (const rid of sourceRecipeIds) {
              const ri = ingredientsByRecipe.get(rid) ?? [];
              slotIngredients.push(...ri);
            }
          }
        }

        const alerts = checkPregnancyAlerts(slot, activeMembers, slotIngredients);
        if (alerts.length > 0) {
          pregnancyAlertsBySlot[slot.id] = alerts;
        }
      }

      // Fetch dietary preferences for conflict checking
      const { data: dpData } = await supabase
        .from("member_dietary_prefs")
        .select("*")
        .order("created_at");

      dietaryPrefs = (dpData ?? []) as MemberDietaryPref[];

      // Pre-compute dietary conflict map for all recipes
      if (dietaryPrefs.length > 0) {
        dietaryConflictMap = computeDietaryConflictMap(
          ingredientsByRecipe,
          allMembers,
          dietaryPrefs
        );
      }
    }
  }

  // Also fetch dietary prefs even if no recipes have ingredients loaded
  // (needed for slot editor warnings on new recipe assignments)
  if (dietaryPrefs.length === 0) {
    const { data: dpData } = await supabase
      .from("member_dietary_prefs")
      .select("*")
      .order("created_at");
    dietaryPrefs = (dpData ?? []) as MemberDietaryPref[];
  }

  // Fetch recipe preferences for scoring
  const cutoff = new Date();
  cutoff.setDate(cutoff.getDate() - 56); // 8 weeks
  const { data: rpData } = await supabase
    .from("recipe_preferences")
    .select("*")
    .gte("created_at", cutoff.toISOString())
    .order("created_at", { ascending: false });

  recipePreferences = (rpData ?? []) as RecipePreference[];

  // Always fetch members and recipes (needed for the editor modal)
  const [membersResult, recipesResult] = await Promise.all([
    supabase
      .from("household_members")
      .select("*")
      .eq("is_archived", false)
      .order("name"),
    supabase
      .from("recipes")
      .select("*")
      .neq("status", "archived")
      .order("title"),
  ]);

  if (recipesResult.error) {
    console.error("Recipes fetch error:", recipesResult.error);
  }

  const members = (membersResult.data ?? []) as HouseholdMember[];
  const recipes = (recipesResult.data ?? []) as Recipe[];

  // Compute variety warnings
  const repeatedSlotIds = detectRepeatedRecipes(slots);

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-6xl mx-auto px-4 py-6">
        <WeekNavigator currentMonday={monday} />

        {weekPlan ? (
          <PlannerGrid
            weekPlan={weekPlan as WeekPlan}
            slots={slots}
            participants={participants}
            members={members}
            recipes={recipes}
            weekNutrition={weekNutrition}
            pregnancyAlertsBySlot={pregnancyAlertsBySlot}
            dietaryConflictMap={dietaryConflictMap}
            dietaryPrefs={dietaryPrefs}
            recipePreferences={recipePreferences}
            repeatedSlotIds={Array.from(repeatedSlotIds)}
          />
        ) : (
          <EmptyPlanState monday={monday} />
        )}
      </main>
    </div>
  );
}

function EmptyPlanState({ monday }: { monday: string }) {
  return (
    <div className="mt-12 text-center">
      <p className="text-5xl mb-4">📅</p>
      <h2 className="text-lg font-semibold text-ink mb-2">
        No meal plan for this week
      </h2>
      <p className="text-sm text-ink-muted mb-6">
        Create a plan to start assigning recipes to your meals.
      </p>
      <CreatePlanButton monday={monday} />
    </div>
  );
}

// Client component for the create button (needs interactivity)
import CreatePlanButton from "@/components/create-plan-button";
