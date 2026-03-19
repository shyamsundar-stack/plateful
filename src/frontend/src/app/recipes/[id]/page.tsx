import { createClient } from "@/lib/supabase/server";
import type {
  Recipe,
  RecipeIngredientWithName,
  RecipeStep,
  RecipeNutrition,
  RecipeIngredientWithDetails,
  UnitConversion,
} from "@/lib/types/database";
import {
  buildConversionMap,
  calculateRecipeNutrition,
} from "@/lib/nutrition";
import Header from "@/components/header";
import BackButton from "@/components/back-button";
import RecipeDetail from "@/components/recipe-detail";

type Props = {
  params: Promise<{ id: string }>;
};

export default async function RecipeDetailPage({ params }: Props) {
  const { id } = await params;
  let recipe: Recipe | null = null;
  let ingredients: RecipeIngredientWithName[] = [];
  let steps: RecipeStep[] = [];
  let nutrition: RecipeNutrition | null = null;
  let error: string | null = null;

  try {
    const supabase = await createClient();

    // Fetch recipe, ingredients (with names), steps, and full ingredient details in parallel
    const [recipeResult, ingredientsResult, stepsResult, fullIngredientsResult, conversionsResult] =
      await Promise.all([
        supabase.from("recipes").select("*").eq("id", id).single(),
        supabase
          .from("recipe_ingredients")
          .select("*, ingredients(name, category)")
          .eq("recipe_id", id)
          .order("sort_order"),
        supabase
          .from("recipe_steps")
          .select("*")
          .eq("recipe_id", id)
          .order("step_number"),
        // Full ingredient details for nutrition calculation
        supabase
          .from("recipe_ingredients")
          .select("*, ingredients(*)")
          .eq("recipe_id", id),
        // Unit conversions
        supabase.from("unit_conversions").select("*"),
      ]);

    if (recipeResult.error) {
      error = "Recipe not found.";
    } else {
      recipe = recipeResult.data as Recipe;
      ingredients = (ingredientsResult.data ?? []) as RecipeIngredientWithName[];
      steps = (stepsResult.data ?? []) as RecipeStep[];

      // Calculate nutrition
      const fullIngredients = (fullIngredientsResult.data ?? []) as RecipeIngredientWithDetails[];
      const conversions = buildConversionMap(
        (conversionsResult.data ?? []) as UnitConversion[]
      );

      if (fullIngredients.length > 0) {
        nutrition = calculateRecipeNutrition(
          recipe.id,
          recipe.servings,
          fullIngredients,
          conversions
        );
      }
    }
  } catch {
    error = "Failed to load recipe. Please try again.";
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-3xl mx-auto px-4 py-6">
        <BackButton href="/recipes" label="Back to Recipes" />

        {error || !recipe ? (
          <div className="text-center py-16">
            <span className="text-5xl">😕</span>
            <h3 className="text-lg font-semibold text-ink mt-4">
              {error || "Recipe not found"}
            </h3>
          </div>
        ) : (
          <RecipeDetail
            recipe={recipe}
            ingredients={ingredients}
            steps={steps}
            nutrition={nutrition}
          />
        )}
      </main>
    </div>
  );
}
