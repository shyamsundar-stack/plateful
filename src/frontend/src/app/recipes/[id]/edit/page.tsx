import { createClient } from "@/lib/supabase/server";
import type {
  Recipe,
  Ingredient,
  RecipeIngredientWithName,
  RecipeStep,
} from "@/lib/types/database";
import Header from "@/components/header";
import BackButton from "@/components/back-button";
import RecipeForm from "@/components/recipe-form";

type Props = {
  params: Promise<{ id: string }>;
};

export default async function EditRecipePage({ params }: Props) {
  const { id } = await params;
  let recipe: Recipe | null = null;
  let ingredients: RecipeIngredientWithName[] = [];
  let steps: RecipeStep[] = [];
  let householdIngredients: Ingredient[] = [];
  let householdId: string = "";
  let error: string | null = null;

  try {
    const supabase = await createClient();

    // Fetch everything in parallel
    const [recipeResult, ingredientsResult, stepsResult, householdIngredientsResult, householdResult] =
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
        supabase
          .from("ingredients")
          .select("*")
          .eq("is_archived", false)
          .order("name"),
        supabase.rpc("get_my_household_id"),
      ]);

    if (recipeResult.error) {
      error = "Recipe not found.";
    } else {
      recipe = recipeResult.data as Recipe;
      ingredients = (ingredientsResult.data ?? []) as RecipeIngredientWithName[];
      steps = (stepsResult.data ?? []) as RecipeStep[];
      householdIngredients = (householdIngredientsResult.data ?? []) as Ingredient[];
      householdId = householdResult.data ?? "";
    }
  } catch {
    error = "Failed to load recipe. Please try again.";
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-3xl mx-auto px-4 py-6">
        <BackButton href={`/recipes/${id}`} label="Back to Recipe" />

        {error || !recipe ? (
          <div className="text-center py-16">
            <span className="text-5xl">😕</span>
            <h3 className="text-lg font-semibold text-ink mt-4">
              {error || "Recipe not found"}
            </h3>
          </div>
        ) : (
          <>
            <h2 className="text-2xl font-bold text-ink mb-6">
              Edit Recipe
            </h2>
            <RecipeForm
              mode="edit"
              householdId={householdId}
              householdIngredients={householdIngredients}
              initialRecipe={recipe}
              initialIngredients={ingredients}
              initialSteps={steps}
            />
          </>
        )}
      </main>
    </div>
  );
}
