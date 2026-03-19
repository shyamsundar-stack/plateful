import { createClient } from "@/lib/supabase/client";
import type {
  Recipe,
  Ingredient,
  RecipeIngredientWithName,
  RecipeStep,
  IngredientRow,
  StepRow,
} from "@/lib/types/database";

// ──────────────────────────────────────────
// READ operations
// ──────────────────────────────────────────

// Fetch a single recipe with its ingredients (joined with names) and steps
export async function fetchRecipeWithDetails(recipeId: string) {
  const supabase = createClient();

  // Run all three queries in parallel
  const [recipeResult, ingredientsResult, stepsResult] = await Promise.all([
    supabase.from("recipes").select("*").eq("id", recipeId).single(),
    supabase
      .from("recipe_ingredients")
      .select("*, ingredients(name, category)")
      .eq("recipe_id", recipeId)
      .order("sort_order"),
    supabase
      .from("recipe_steps")
      .select("*")
      .eq("recipe_id", recipeId)
      .order("step_number"),
  ]);

  if (recipeResult.error) {
    throw new Error(recipeResult.error.message);
  }

  return {
    recipe: recipeResult.data as Recipe,
    ingredients: (ingredientsResult.data ??
      []) as RecipeIngredientWithName[],
    steps: (stepsResult.data ?? []) as RecipeStep[],
  };
}

// Fetch all non-archived ingredients for the household (for autocomplete)
export async function fetchHouseholdIngredients() {
  const supabase = createClient();

  const { data, error } = await supabase
    .from("ingredients")
    .select("*")
    .eq("is_archived", false)
    .order("name");

  if (error) {
    throw new Error(error.message);
  }

  return (data ?? []) as Ingredient[];
}

// ──────────────────────────────────────────
// CREATE operations
// ──────────────────────────────────────────

// Create a new recipe with ingredients and steps
export async function createRecipe(
  householdId: string,
  recipeData: {
    title: string;
    description: string | null;
    cuisine: string | null;
    meal_types: string[];
    servings: number;
    prep_time_min: number | null;
    cook_time_min: number | null;
    difficulty: string | null;
    tags: string[];
    source_type: "manual" | "paste_import" | "url_import";
    is_vegetarian: boolean;
    is_vegan: boolean;
    is_batch_friendly: boolean;
    leftover_days: number | null;
  },
  ingredients: IngredientRow[],
  steps: StepRow[]
) {
  const supabase = createClient();

  // 1. Insert recipe
  const { data: recipe, error: recipeError } = await supabase
    .from("recipes")
    .insert({
      household_id: householdId,
      title: recipeData.title,
      description: recipeData.description || null,
      cuisine: recipeData.cuisine || null,
      meal_types: recipeData.meal_types.length > 0 ? recipeData.meal_types : null,
      servings: recipeData.servings,
      prep_time_min: recipeData.prep_time_min,
      cook_time_min: recipeData.cook_time_min,
      difficulty: recipeData.difficulty || null,
      tags: recipeData.tags.length > 0 ? recipeData.tags : null,
      source_type: recipeData.source_type,
      status: "draft",
      is_vegetarian: recipeData.is_vegetarian,
      is_vegan: recipeData.is_vegan,
      is_batch_friendly: recipeData.is_batch_friendly,
      leftover_days: recipeData.leftover_days,
    })
    .select()
    .single();

  if (recipeError) {
    throw new Error(`Failed to create recipe: ${recipeError.message}`);
  }

  // 2. Insert ingredients (if any)
  if (ingredients.length > 0) {
    const ingredientRows = ingredients.map((ing, index) => ({
      recipe_id: recipe.id,
      ingredient_id: ing.ingredient_id,
      quantity: ing.quantity,
      unit: ing.unit || null,
      preparation: ing.preparation || null,
      is_optional: ing.is_optional,
      group_name: ing.group_name || null,
      sort_order: index + 1,
    }));

    const { error: ingError } = await supabase
      .from("recipe_ingredients")
      .insert(ingredientRows);

    if (ingError) {
      throw new Error(`Recipe created but failed to save ingredients: ${ingError.message}`);
    }
  }

  // 3. Insert steps (if any)
  if (steps.length > 0) {
    const stepRows = steps.map((step, index) => ({
      recipe_id: recipe.id,
      step_number: index + 1,
      instruction: step.instruction,
      duration_min: step.duration_min,
    }));

    const { error: stepError } = await supabase
      .from("recipe_steps")
      .insert(stepRows);

    if (stepError) {
      throw new Error(`Recipe created but failed to save steps: ${stepError.message}`);
    }
  }

  return recipe as Recipe;
}

// ──────────────────────────────────────────
// UPDATE operations
// ──────────────────────────────────────────

// Update recipe basic fields (not ingredients/steps)
export async function updateRecipe(
  recipeId: string,
  data: {
    title: string;
    description: string | null;
    cuisine: string | null;
    meal_types: string[];
    servings: number;
    prep_time_min: number | null;
    cook_time_min: number | null;
    difficulty: string | null;
    tags: string[];
    is_vegetarian: boolean;
    is_vegan: boolean;
    is_batch_friendly: boolean;
    leftover_days: number | null;
  }
) {
  const supabase = createClient();

  const { error } = await supabase
    .from("recipes")
    .update({
      title: data.title,
      description: data.description || null,
      cuisine: data.cuisine || null,
      meal_types: data.meal_types.length > 0 ? data.meal_types : null,
      servings: data.servings,
      prep_time_min: data.prep_time_min,
      cook_time_min: data.cook_time_min,
      difficulty: data.difficulty || null,
      tags: data.tags.length > 0 ? data.tags : null,
      is_vegetarian: data.is_vegetarian,
      is_vegan: data.is_vegan,
      is_batch_friendly: data.is_batch_friendly,
      leftover_days: data.leftover_days,
    })
    .eq("id", recipeId);

  if (error) {
    throw new Error(`Failed to update recipe: ${error.message}`);
  }
}

// Replace all ingredients for a recipe (delete + re-insert)
export async function updateRecipeIngredients(
  recipeId: string,
  ingredients: IngredientRow[]
) {
  const supabase = createClient();

  // Delete existing ingredients
  const { error: deleteError } = await supabase
    .from("recipe_ingredients")
    .delete()
    .eq("recipe_id", recipeId);

  if (deleteError) {
    throw new Error(`Failed to update ingredients: ${deleteError.message}`);
  }

  // Insert new set
  if (ingredients.length > 0) {
    const rows = ingredients.map((ing, index) => ({
      recipe_id: recipeId,
      ingredient_id: ing.ingredient_id,
      quantity: ing.quantity,
      unit: ing.unit || null,
      preparation: ing.preparation || null,
      is_optional: ing.is_optional,
      group_name: ing.group_name || null,
      sort_order: index + 1,
    }));

    const { error: insertError } = await supabase
      .from("recipe_ingredients")
      .insert(rows);

    if (insertError) {
      throw new Error(`Failed to save ingredients: ${insertError.message}`);
    }
  }
}

// Replace all steps for a recipe (delete + re-insert)
export async function updateRecipeSteps(
  recipeId: string,
  steps: StepRow[]
) {
  const supabase = createClient();

  // Delete existing steps
  const { error: deleteError } = await supabase
    .from("recipe_steps")
    .delete()
    .eq("recipe_id", recipeId);

  if (deleteError) {
    throw new Error(`Failed to update steps: ${deleteError.message}`);
  }

  // Insert new set
  if (steps.length > 0) {
    const rows = steps.map((step, index) => ({
      recipe_id: recipeId,
      step_number: index + 1,
      instruction: step.instruction,
      duration_min: step.duration_min,
    }));

    const { error: insertError } = await supabase
      .from("recipe_steps")
      .insert(rows);

    if (insertError) {
      throw new Error(`Failed to save steps: ${insertError.message}`);
    }
  }
}

// Update just the recipe status
export async function updateRecipeStatus(
  recipeId: string,
  status: "draft" | "active" | "archived"
) {
  const supabase = createClient();

  const { error } = await supabase
    .from("recipes")
    .update({ status })
    .eq("id", recipeId);

  if (error) {
    throw new Error(`Failed to update status: ${error.message}`);
  }
}

// ──────────────────────────────────────────
// INGREDIENT HELPERS
// ──────────────────────────────────────────

// ──────────────────────────────────────────
// RATING + FAVORITE operations
// ──────────────────────────────────────────

// Update recipe star rating (1-5 or null to clear)
export async function updateRecipeRating(
  recipeId: string,
  rating: number | null
) {
  const supabase = createClient();

  if (rating !== null && (rating < 1 || rating > 5)) {
    throw new Error("Rating must be between 1 and 5");
  }

  const { error } = await supabase
    .from("recipes")
    .update({ rating, updated_at: new Date().toISOString() })
    .eq("id", recipeId);

  if (error) {
    throw new Error(`Failed to update rating: ${error.message}`);
  }
}

// Toggle recipe favorite status
export async function toggleRecipeFavorite(
  recipeId: string,
  isFavorite: boolean
) {
  const supabase = createClient();

  const { error } = await supabase
    .from("recipes")
    .update({ is_favorite: isFavorite, updated_at: new Date().toISOString() })
    .eq("id", recipeId);

  if (error) {
    throw new Error(`Failed to toggle favorite: ${error.message}`);
  }
}

// ──────────────────────────────────────────
// INGREDIENT HELPERS
// ──────────────────────────────────────────

// Create a new ingredient in the household library (for "add new" in autocomplete)
export async function createIngredient(
  householdId: string,
  name: string
) {
  const supabase = createClient();

  const { data, error } = await supabase
    .from("ingredients")
    .insert({
      household_id: householdId,
      name: name.trim(),
      category: "other",
      default_unit: "g",
    })
    .select()
    .single();

  if (error) {
    throw new Error(`Failed to create ingredient: ${error.message}`);
  }

  return data as Ingredient;
}
