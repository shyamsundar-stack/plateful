/**
 * Multi-dish meal utilities — shared helpers for Phase 6.
 *
 * Pure functions, no Supabase imports. Used by nutrition.ts, grocery.ts,
 * variety.ts, dietary.ts to handle multi-dish slots uniformly.
 */

import type {
  MealSlotWithRecipe,
  MealSlotDishWithRecipe,
} from "@/lib/types/database";

// We use a looser type so callers can pass MealSlotWithDishes or any slot
// that may or may not have the dishes array.
type SlotLike = MealSlotWithRecipe & {
  meal_slot_dishes?: MealSlotDishWithRecipe[];
};

// ---------------------------------------------------------------------------
// Core helpers
// ---------------------------------------------------------------------------

/**
 * Get all recipe IDs for a meal slot.
 * If the slot has multi-dish entries, returns those recipe IDs.
 * Otherwise falls back to the single recipe_id field.
 */
export function getSlotRecipeIds(slot: SlotLike): string[] {
  // Check for multi-dish entries first
  if (slot.meal_slot_dishes && slot.meal_slot_dishes.length > 0) {
    return slot.meal_slot_dishes
      .sort((a, b) => a.sort_order - b.sort_order)
      .map((d) => d.recipe_id);
  }

  // Fallback to single recipe_id
  if (slot.recipe_id) {
    return [slot.recipe_id];
  }

  return [];
}

/**
 * Get the recipe ID of the 'main' dish in a slot.
 * For multi-dish: returns the recipe with dish_role='main'.
 * For single-dish: returns recipe_id.
 */
export function getSlotMainDish(slot: SlotLike): string | null {
  if (slot.meal_slot_dishes && slot.meal_slot_dishes.length > 0) {
    const main = slot.meal_slot_dishes.find((d) => d.dish_role === "main");
    return main?.recipe_id ?? slot.meal_slot_dishes[0]?.recipe_id ?? null;
  }
  return slot.recipe_id ?? null;
}

/**
 * Check if a slot uses multi-dish (has junction table entries).
 */
export function isMultiDishSlot(slot: SlotLike): boolean {
  return (slot.meal_slot_dishes?.length ?? 0) > 1;
}

/**
 * Get dishes with their portion factors.
 * Returns array of { recipeId, dishRole, portionFactor } for multi-dish,
 * or a single entry with portion_factor=1.0 for legacy slots.
 */
export function getSlotDishes(
  slot: SlotLike
): Array<{
  recipeId: string;
  dishRole: string;
  portionFactor: number;
}> {
  if (slot.meal_slot_dishes && slot.meal_slot_dishes.length > 0) {
    return slot.meal_slot_dishes
      .sort((a, b) => a.sort_order - b.sort_order)
      .map((d) => ({
        recipeId: d.recipe_id,
        dishRole: d.dish_role,
        portionFactor: d.portion_factor,
      }));
  }

  if (slot.recipe_id) {
    return [{ recipeId: slot.recipe_id, dishRole: "main", portionFactor: 1.0 }];
  }

  return [];
}

/**
 * Get recipe IDs that should be checked for variety warnings.
 * Only 'main' dishes trigger variety warnings — staples (rice, roti)
 * eaten daily are normal in Indian cuisine.
 */
export function getSlotMainRecipeIds(slot: SlotLike): string[] {
  if (slot.meal_slot_dishes && slot.meal_slot_dishes.length > 0) {
    return slot.meal_slot_dishes
      .filter((d) => d.dish_role === "main")
      .map((d) => d.recipe_id);
  }

  // Single recipe = treat as main
  if (slot.recipe_id) {
    return [slot.recipe_id];
  }

  return [];
}

// ---------------------------------------------------------------------------
// Display helpers
// ---------------------------------------------------------------------------

/** Human-readable label for a dish role */
export function getDishRoleLabel(role: string): string {
  switch (role) {
    case "main": return "Main";
    case "staple": return "Staple";
    case "side": return "Side";
    case "accompaniment": return "Extra";
    default: return role;
  }
}

/** Emoji for a dish role */
export function getDishRoleEmoji(role: string): string {
  switch (role) {
    case "main": return "🍛";
    case "staple": return "🫓";
    case "side": return "🥗";
    case "accompaniment": return "🫙";
    default: return "🍽️";
  }
}

/** Tailwind color class for a dish role badge */
export function getDishRoleColor(role: string): string {
  switch (role) {
    case "main": return "bg-primary/10 text-primary";
    case "staple": return "bg-accent/10 text-accent-dark";
    case "side": return "bg-secondary/10 text-secondary-dark";
    case "accompaniment": return "bg-ink-light/10 text-ink-muted";
    default: return "bg-ink-light/10 text-ink-muted";
  }
}
