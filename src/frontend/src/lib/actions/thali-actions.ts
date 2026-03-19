"use server";

import { createClient } from "@/lib/supabase/server";
import type {
  ThaliTemplate,
  ThaliTemplateWithDishes,
  Recipe,
} from "@/lib/types/database";

// ---------------------------------------------------------------------------
// READ operations
// ---------------------------------------------------------------------------

/**
 * Fetch all thali templates accessible to the current household.
 * Includes global templates (household_id=NULL) and household-specific ones.
 */
export async function fetchThaliTemplates(): Promise<ThaliTemplateWithDishes[]> {
  const supabase = await createClient();
  const { data: householdId } = await supabase.rpc("get_my_household_id");

  const { data, error } = await supabase
    .from("thali_templates")
    .select("*, thali_template_dishes(*)")
    .or(`household_id.is.null,household_id.eq.${householdId}`)
    .eq("is_archived", false)
    .order("name");

  if (error) throw new Error(error.message);
  return (data ?? []) as ThaliTemplateWithDishes[];
}

/**
 * Fetch a single thali template with its dishes.
 */
export async function fetchThaliTemplateDetails(
  templateId: string
): Promise<ThaliTemplateWithDishes | null> {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("thali_templates")
    .select("*, thali_template_dishes(*)")
    .eq("id", templateId)
    .maybeSingle();

  if (error) throw new Error(error.message);
  return data as ThaliTemplateWithDishes | null;
}

// ---------------------------------------------------------------------------
// WRITE operations (household-scoped)
// ---------------------------------------------------------------------------

/**
 * Create a new household-specific thali template.
 */
export async function createThaliTemplate(input: {
  name: string;
  description?: string;
  cuisine?: string;
  mealTypes?: string[];
  isVegetarian?: boolean;
  dishes: Array<{
    dishRole: "main" | "staple" | "side" | "accompaniment";
    dishLabel: string;
    recipeFilter: Record<string, unknown>;
  }>;
}): Promise<ThaliTemplate> {
  const supabase = await createClient();
  const { data: householdId } = await supabase.rpc("get_my_household_id");
  if (!householdId) throw new Error("Not authenticated");

  // Insert the template
  const { data: template, error: templateError } = await supabase
    .from("thali_templates")
    .insert({
      household_id: householdId,
      name: input.name,
      description: input.description ?? null,
      cuisine: input.cuisine ?? null,
      meal_types: input.mealTypes ?? [],
      is_vegetarian: input.isVegetarian ?? false,
    })
    .select()
    .single();

  if (templateError) throw new Error(templateError.message);

  // Insert the dishes
  if (input.dishes.length > 0) {
    const dishRows = input.dishes.map((d, i) => ({
      template_id: template.id,
      dish_role: d.dishRole,
      dish_label: d.dishLabel,
      recipe_filter: d.recipeFilter,
      sort_order: i,
    }));

    const { error: dishError } = await supabase
      .from("thali_template_dishes")
      .insert(dishRows);

    if (dishError) throw new Error(dishError.message);
  }

  return template as ThaliTemplate;
}

/**
 * Update an existing household thali template.
 */
export async function updateThaliTemplate(
  templateId: string,
  input: {
    name?: string;
    description?: string;
    cuisine?: string;
    mealTypes?: string[];
    isVegetarian?: boolean;
    dishes?: Array<{
      dishRole: "main" | "staple" | "side" | "accompaniment";
      dishLabel: string;
      recipeFilter: Record<string, unknown>;
    }>;
  }
): Promise<void> {
  const supabase = await createClient();

  // Update template fields
  const updates: Record<string, unknown> = {};
  if (input.name !== undefined) updates.name = input.name;
  if (input.description !== undefined) updates.description = input.description;
  if (input.cuisine !== undefined) updates.cuisine = input.cuisine;
  if (input.mealTypes !== undefined) updates.meal_types = input.mealTypes;
  if (input.isVegetarian !== undefined) updates.is_vegetarian = input.isVegetarian;

  if (Object.keys(updates).length > 0) {
    const { error } = await supabase
      .from("thali_templates")
      .update(updates)
      .eq("id", templateId);

    if (error) throw new Error(error.message);
  }

  // Replace dishes if provided
  if (input.dishes) {
    // Delete existing dishes
    const { error: deleteError } = await supabase
      .from("thali_template_dishes")
      .delete()
      .eq("template_id", templateId);

    if (deleteError) throw new Error(deleteError.message);

    // Insert new dishes
    if (input.dishes.length > 0) {
      const dishRows = input.dishes.map((d, i) => ({
        template_id: templateId,
        dish_role: d.dishRole,
        dish_label: d.dishLabel,
        recipe_filter: d.recipeFilter,
        sort_order: i,
      }));

      const { error: insertError } = await supabase
        .from("thali_template_dishes")
        .insert(dishRows);

      if (insertError) throw new Error(insertError.message);
    }
  }
}

/**
 * Soft-delete (archive) a household thali template.
 */
export async function deleteThaliTemplate(templateId: string): Promise<void> {
  const supabase = await createClient();

  const { error } = await supabase
    .from("thali_templates")
    .update({ is_archived: true })
    .eq("id", templateId);

  if (error) throw new Error(error.message);
}

// ---------------------------------------------------------------------------
// Template resolution
// ---------------------------------------------------------------------------

/**
 * Resolve a template's dish filters to actual household recipes.
 * For each template dish, finds the best matching recipe from the household library.
 *
 * Returns an array of resolved dishes (with recipeId) or null for unresolvable ones.
 */
export async function resolveTemplateDishes(
  templateId: string
): Promise<
  Array<{
    dishRole: "main" | "staple" | "side" | "accompaniment";
    dishLabel: string;
    recipeId: string | null;
    recipeTitle: string | null;
  }>
> {
  const supabase = await createClient();
  const { data: householdId } = await supabase.rpc("get_my_household_id");
  if (!householdId) throw new Error("Not authenticated");

  // Fetch template with dishes
  const template = await fetchThaliTemplateDetails(templateId);
  if (!template) throw new Error("Template not found");

  // Fetch all active household recipes
  const { data: recipeData } = await supabase
    .from("recipes")
    .select("*")
    .eq("household_id", householdId)
    .eq("status", "active")
    .eq("is_archived", false);

  const recipes = (recipeData ?? []) as Recipe[];

  // Resolve each template dish
  const resolved = template.thali_template_dishes
    .sort((a, b) => a.sort_order - b.sort_order)
    .map((dish) => {
      const filter = dish.recipe_filter as Record<string, unknown>;
      let bestMatch: Recipe | null = null;

      // If filter specifies a specific recipe_id, use it directly
      if (filter.recipe_id && typeof filter.recipe_id === "string") {
        bestMatch = recipes.find((r) => r.id === filter.recipe_id) ?? null;
      } else {
        // Score each recipe against the filter criteria
        let bestScore = -1;
        for (const recipe of recipes) {
          let score = 0;

          // Cuisine match
          if (filter.cuisine && typeof filter.cuisine === "string") {
            if (recipe.cuisine?.toLowerCase() === filter.cuisine.toLowerCase()) {
              score += 3;
            }
          }

          // Tag match (check if any recipe tag matches any filter tag)
          if (filter.tags && Array.isArray(filter.tags)) {
            const filterTags = filter.tags as string[];
            const recipeTags = [
              ...(recipe.tags ?? []),
              ...(recipe.dietary_tags ?? []),
              recipe.title.toLowerCase(),
            ].map((t) => t.toLowerCase());

            for (const ft of filterTags) {
              if (recipeTags.some((rt) => rt.includes(ft.toLowerCase()))) {
                score += 2;
              }
            }
          }

          // Meal type match
          if (filter.meal_types && Array.isArray(filter.meal_types)) {
            const filterMealTypes = filter.meal_types as string[];
            if (recipe.meal_types?.some((mt) => filterMealTypes.includes(mt))) {
              score += 1;
            }
          }

          // Vegetarian match
          if (filter.is_vegetarian === true && recipe.is_vegetarian) {
            score += 1;
          }

          // Favorite + rating boost
          if (recipe.is_favorite) score += 1;
          if (recipe.rating && recipe.rating >= 4) score += 1;

          if (score > bestScore) {
            bestScore = score;
            bestMatch = recipe;
          }
        }
      }

      return {
        dishRole: dish.dish_role as "main" | "staple" | "side" | "accompaniment",
        dishLabel: dish.dish_label,
        recipeId: bestMatch?.id ?? null,
        recipeTitle: bestMatch?.title ?? null,
      };
    });

  return resolved;
}
