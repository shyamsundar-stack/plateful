import { createClient } from "@/lib/supabase/server";
import Header from "@/components/header";
import WeekNavigator from "@/components/week-navigator";
import PrepBlockCard from "@/components/prep-block-card";
import PrepComponentManager from "@/components/prep-component-manager";
import type {
  MealSlotWithRecipe,
  RecipeIngredientWithDetails,
  UnitConversion,
  PrepComponentWithRecipes,
  Recipe,
} from "@/lib/types/database";
import { detectSharedPrep, organizeIntoPrepBlocks, getTotalPrepTime } from "@/lib/prep";

function getMonday(date: Date = new Date()): string {
  const d = new Date(date);
  const day = d.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  d.setDate(d.getDate() + diff);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
}

export default async function PrepPage({
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

  // Fetch manual prep components
  const { data: prepComponentsData } = await supabase
    .from("prep_components")
    .select("*, recipe_prep_components(recipe_id, recipes(title))")
    .eq("is_archived", false)
    .order("name");

  const manualComponents = (prepComponentsData ?? []) as PrepComponentWithRecipes[];

  // Fetch all recipes (for linking prep components)
  const { data: recipesData } = await supabase
    .from("recipes")
    .select("*")
    .eq("status", "active")
    .order("title");

  const recipes = (recipesData ?? []) as Recipe[];

  if (!weekPlan) {
    return (
      <div className="min-h-screen bg-cream">
        <Header />
        <main className="max-w-3xl mx-auto px-4 py-6">
          <WeekNavigator currentMonday={monday} basePath="/prep" />
          <div className="mt-12 text-center">
            <p className="text-5xl mb-4">🔪</p>
            <h2 className="text-lg font-semibold text-ink mb-2">
              No meal plan for this week
            </h2>
            <p className="text-sm text-ink-muted mb-8">
              Plan your week first to see prep suggestions.
            </p>
          </div>

          {/* Still show manual prep components */}
          <PrepComponentManager
            components={manualComponents}
            recipes={recipes}
          />
        </main>
      </div>
    );
  }

  // Fetch cook slots with recipes
  const { data: slotData } = await supabase
    .from("meal_slots")
    .select("*, recipes(title, cuisine, total_time_min, is_vegetarian)")
    .eq("week_plan_id", weekPlan.id)
    .eq("meal_mode", "cook")
    .in("meal_type", ["breakfast", "lunch", "dinner"])
    .order("slot_date");

  const slots = (slotData ?? []) as MealSlotWithRecipe[];

  // Get recipe IDs
  const recipeIds = Array.from(
    new Set(
      slots
        .filter((s) => s.recipe_id != null)
        .map((s) => s.recipe_id as string)
    )
  );

  // Fetch recipe ingredients
  const ingredientsByRecipe = new Map<string, RecipeIngredientWithDetails[]>();
  if (recipeIds.length > 0) {
    const { data: riData } = await supabase
      .from("recipe_ingredients")
      .select("*, ingredients(*)")
      .in("recipe_id", recipeIds);

    const recipeIngredients = (riData ?? []) as RecipeIngredientWithDetails[];
    for (const ri of recipeIngredients) {
      const existing = ingredientsByRecipe.get(ri.recipe_id) ?? [];
      existing.push(ri);
      ingredientsByRecipe.set(ri.recipe_id, existing);
    }
  }

  // Fetch unit conversions
  const { data: ucData } = await supabase
    .from("unit_conversions")
    .select("*");
  const conversions = (ucData ?? []) as UnitConversion[];

  // Auto-detect shared prep
  const autoSuggestions = detectSharedPrep(
    slots,
    ingredientsByRecipe,
    conversions
  );

  // Filter manual components to ones linked to this week's recipes
  const weekRecipeIds = new Set(recipeIds);
  const relevantManual = manualComponents.filter((c) =>
    c.recipe_prep_components.some((rpc) => weekRecipeIds.has(rpc.recipe_id))
  );

  // Organize into prep blocks
  const prepBlocks = organizeIntoPrepBlocks(autoSuggestions, relevantManual);
  const totalTime = getTotalPrepTime(prepBlocks);

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-3xl mx-auto px-4 py-6">
        <WeekNavigator currentMonday={monday} basePath="/prep" />

        {/* Prep summary header */}
        {prepBlocks.length > 0 ? (
          <>
            <div className="bg-surface rounded-xl border border-ink-light/10 p-4 mt-4 mb-4">
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-lg font-semibold text-ink">
                    Weekend Prep Plan
                  </h2>
                  <p className="text-xs text-ink-muted mt-0.5">
                    {autoSuggestions.length} ingredients shared across meals ·{" "}
                    {relevantManual.length} custom prep items
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-2xl font-bold text-primary">
                    {totalTime}
                    <span className="text-sm font-normal text-ink-muted ml-1">
                      min
                    </span>
                  </p>
                  <p className="text-[10px] text-ink-muted">estimated total</p>
                </div>
              </div>
            </div>

            {/* Prep blocks */}
            <div className="space-y-4 mb-8">
              {prepBlocks.map((block, idx) => (
                <PrepBlockCard key={idx} block={block} />
              ))}
            </div>
          </>
        ) : (
          <div className="mt-8 mb-8 text-center">
            <p className="text-5xl mb-4">✨</p>
            <h2 className="text-lg font-semibold text-ink mb-2">
              No shared prep this week
            </h2>
            <p className="text-sm text-ink-muted">
              {slots.length === 0
                ? "Assign recipes to your meals to see prep suggestions."
                : "Each recipe this week uses different ingredients — no batch-prep opportunities detected."}
            </p>
          </div>
        )}

        {/* Manual prep components manager */}
        <PrepComponentManager
          components={manualComponents}
          recipes={recipes}
        />
      </main>
    </div>
  );
}
