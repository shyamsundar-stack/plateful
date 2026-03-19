"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { trackEvent } from "@/lib/actions/analytics-actions";
import type {
  GlobalRecipe,
  GlobalRecipeIngredient,
  GlobalRecipeStep,
  Recipe,
} from "@/lib/types/database";

// ---------------------------------------------------------------------------
// Fetch global recipes (with optional filters)
// ---------------------------------------------------------------------------

export async function fetchGlobalRecipes(filters?: {
  cuisine?: string;
  mealType?: string;
  dietaryToggle?: "veg" | "non-veg" | "all";
  searchQuery?: string;
}) {
  const supabase = await createClient();

  let query = supabase
    .from("global_recipes")
    .select("*")
    .order("import_count", { ascending: false });

  if (filters?.cuisine) {
    query = query.eq("cuisine", filters.cuisine);
  }
  if (filters?.mealType) {
    query = query.contains("meal_types", [filters.mealType]);
  }
  if (filters?.dietaryToggle === "veg") {
    query = query.eq("is_vegetarian", true);
  } else if (filters?.dietaryToggle === "non-veg") {
    query = query.eq("is_vegetarian", false);
  }
  if (filters?.searchQuery) {
    query = query.ilike("title", `%${filters.searchQuery}%`);
  }

  const { data, error } = await query;

  if (error) throw new Error(`Failed to fetch global recipes: ${error.message}`);
  return (data ?? []) as GlobalRecipe[];
}

// ---------------------------------------------------------------------------
// Fetch global recipe details (ingredients + steps)
// ---------------------------------------------------------------------------

export async function fetchGlobalRecipeDetails(globalRecipeId: string) {
  const supabase = await createClient();

  const [recipeResult, ingredientsResult, stepsResult] = await Promise.all([
    supabase
      .from("global_recipes")
      .select("*")
      .eq("id", globalRecipeId)
      .single(),
    supabase
      .from("global_recipe_ingredients")
      .select("*")
      .eq("global_recipe_id", globalRecipeId)
      .order("sort_order"),
    supabase
      .from("global_recipe_steps")
      .select("*")
      .eq("global_recipe_id", globalRecipeId)
      .order("step_number"),
  ]);

  if (recipeResult.error) {
    throw new Error(`Failed to fetch global recipe: ${recipeResult.error.message}`);
  }

  return {
    recipe: recipeResult.data as GlobalRecipe,
    ingredients: (ingredientsResult.data ?? []) as GlobalRecipeIngredient[],
    steps: (stepsResult.data ?? []) as GlobalRecipeStep[],
  };
}

// ---------------------------------------------------------------------------
// Import a global recipe into the household library
// ---------------------------------------------------------------------------

/**
 * Import a global recipe into the user's household recipe library.
 *
 * 1. Fetch global recipe + ingredients + steps
 * 2. For each ingredient: match household ingredient by global_ingredient_id → name → create new
 * 3. Insert recipe (status='active', source_type='library_import')
 * 4. Insert recipe_ingredients + recipe_steps
 * 5. Increment import_count on global recipe
 * 6. Track analytics event
 */
export async function importGlobalRecipeToHousehold(
  globalRecipeId: string
): Promise<Recipe> {
  const supabase = await createClient();

  // Get household_id
  const { data: householdId } = await supabase.rpc("get_my_household_id");
  if (!householdId) throw new Error("Not authenticated");

  // 1. Fetch global recipe details
  const { recipe: globalRecipe, ingredients: globalIngredients, steps: globalSteps } =
    await fetchGlobalRecipeDetails(globalRecipeId);

  // 2. Fetch household ingredients for matching
  const { data: householdIngredients } = await supabase
    .from("ingredients")
    .select("id, name, global_ingredient_id")
    .eq("household_id", householdId)
    .eq("is_archived", false);

  const hhIngredients = householdIngredients ?? [];

  // Build lookup maps
  const ingredientByGlobalId = new Map<string, { id: string; name: string }>();
  const ingredientByName = new Map<string, { id: string; name: string }>();
  for (const ing of hhIngredients) {
    if (ing.global_ingredient_id) {
      ingredientByGlobalId.set(ing.global_ingredient_id, { id: ing.id, name: ing.name });
    }
    ingredientByName.set(ing.name.toLowerCase(), { id: ing.id, name: ing.name });
  }

  // 3. Insert the recipe
  const { data: newRecipe, error: recipeError } = await supabase
    .from("recipes")
    .insert({
      household_id: householdId,
      title: globalRecipe.title,
      description: globalRecipe.description,
      cuisine: globalRecipe.cuisine,
      cuisine_category: globalRecipe.cuisine_category,
      meal_types: globalRecipe.meal_types,
      servings: globalRecipe.servings,
      prep_time_min: globalRecipe.prep_time_min,
      cook_time_min: globalRecipe.cook_time_min,
      difficulty: globalRecipe.difficulty,
      tags: globalRecipe.tags,
      cooking_style: globalRecipe.cooking_style,
      dietary_tags: globalRecipe.dietary_tags,
      image_url: globalRecipe.image_url,
      source_url: globalRecipe.source_url,
      source_type: "library_import" as const,
      status: "active" as const,
      is_vegetarian: globalRecipe.is_vegetarian,
      is_vegan: globalRecipe.is_vegan,
      is_batch_friendly: globalRecipe.is_batch_friendly,
      leftover_days: globalRecipe.leftover_days,
    })
    .select()
    .single();

  if (recipeError || !newRecipe) {
    throw new Error(`Failed to import recipe: ${recipeError?.message ?? "Unknown error"}`);
  }

  // 4. Match and insert ingredients
  if (globalIngredients.length > 0) {
    const ingredientRows = [];

    for (const gi of globalIngredients) {
      // Try to match: global_ingredient_id → name → create new
      let matchedIngredientId: string | null = null;

      // First: match by global_ingredient_id
      if (gi.global_ingredient_id) {
        const match = ingredientByGlobalId.get(gi.global_ingredient_id);
        if (match) matchedIngredientId = match.id;
      }

      // Second: match by name (case-insensitive)
      if (!matchedIngredientId) {
        const match = ingredientByName.get(gi.ingredient_name.toLowerCase());
        if (match) matchedIngredientId = match.id;
      }

      // Third: create new ingredient in household library
      if (!matchedIngredientId) {
        const { data: newIng, error: ingError } = await supabase
          .from("ingredients")
          .insert({
            household_id: householdId,
            name: gi.ingredient_name,
            global_ingredient_id: gi.global_ingredient_id,
            category: "other",
            default_unit: gi.unit || "g",
          })
          .select("id")
          .single();

        if (!ingError && newIng) {
          matchedIngredientId = newIng.id;
          // Add to maps for subsequent ingredients
          ingredientByName.set(gi.ingredient_name.toLowerCase(), {
            id: newIng.id,
            name: gi.ingredient_name,
          });
          if (gi.global_ingredient_id) {
            ingredientByGlobalId.set(gi.global_ingredient_id, {
              id: newIng.id,
              name: gi.ingredient_name,
            });
          }
        }
      }

      if (matchedIngredientId) {
        ingredientRows.push({
          recipe_id: newRecipe.id,
          ingredient_id: matchedIngredientId,
          quantity: gi.quantity,
          unit: gi.unit,
          preparation: gi.preparation,
          is_optional: gi.is_optional,
          group_name: gi.group_name,
          sort_order: gi.sort_order,
        });
      }
    }

    if (ingredientRows.length > 0) {
      await supabase.from("recipe_ingredients").insert(ingredientRows);
    }
  }

  // 5. Insert steps
  if (globalSteps.length > 0) {
    const stepRows = globalSteps.map((s) => ({
      recipe_id: newRecipe.id,
      step_number: s.step_number,
      instruction: s.instruction,
      duration_min: s.duration_min,
    }));

    await supabase.from("recipe_steps").insert(stepRows);
  }

  // 6. Increment import_count on global recipe (best-effort)
  // Non-critical — silently ignore if the RPC doesn't exist yet
  try {
    await supabase.rpc("increment_global_recipe_import_count", {
      recipe_id: globalRecipeId,
    });
  } catch {
    // Silently ignore
  }

  // 7. Track event + revalidate
  trackEvent("recipe_imported_global", {
    global_recipe_id: globalRecipeId,
    recipe_id: newRecipe.id,
    title: globalRecipe.title,
  }).catch(() => {});

  revalidatePath("/recipes");
  revalidatePath("/planner");

  return newRecipe as Recipe;
}

// ---------------------------------------------------------------------------
// Batch import (for onboarding)
// ---------------------------------------------------------------------------

/**
 * Import multiple global recipes at once (used in onboarding step 3).
 * Returns count of successfully imported recipes.
 */
export async function batchImportGlobalRecipes(
  globalRecipeIds: string[]
): Promise<{ importedCount: number; errors: string[] }> {
  const errors: string[] = [];
  let importedCount = 0;

  for (const id of globalRecipeIds) {
    try {
      await importGlobalRecipeToHousehold(id);
      importedCount++;
    } catch (err) {
      errors.push(
        `Failed to import recipe ${id}: ${err instanceof Error ? err.message : "Unknown error"}`
      );
    }
  }

  trackEvent("batch_import_global", {
    total_requested: globalRecipeIds.length,
    imported_count: importedCount,
    error_count: errors.length,
  }).catch(() => {});

  revalidatePath("/recipes");

  return { importedCount, errors };
}

// ---------------------------------------------------------------------------
// Check which global recipes are already imported
// ---------------------------------------------------------------------------

/**
 * Returns a set of global recipe titles that are already in the household.
 * Used to show "Already imported" badges in the browse UI.
 */
export async function getImportedRecipeTitles(): Promise<Set<string>> {
  const supabase = await createClient();

  const { data: householdId } = await supabase.rpc("get_my_household_id");
  if (!householdId) return new Set();

  const { data } = await supabase
    .from("recipes")
    .select("title")
    .eq("household_id", householdId)
    .eq("source_type", "library_import")
    .eq("is_archived", false);

  return new Set((data ?? []).map((r) => r.title));
}
