/**
 * Dietary conflict checking — pure functions, no Supabase imports.
 *
 * Compares recipe ingredients against household members' dietary preferences
 * to surface warnings (allergy, hard_no, dislike) in the planner.
 */

import type {
  MemberDietaryPref,
  HouseholdMember,
  RecipeIngredientWithDetails,
  DietaryConflict,
  DietaryConflictMap,
  MealSlotWithRecipe,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
} from "@/lib/types/database";
import { getSlotRecipeIds } from "@/lib/meal-utils";

// ---------------------------------------------------------------------------
// Core: check a single recipe against a set of members' dietary prefs
// ---------------------------------------------------------------------------

/**
 * Check one recipe's ingredients against dietary prefs of participating members.
 * Returns an array of conflicts (empty if none).
 */
export function checkDietaryConflicts(
  recipeIngredients: RecipeIngredientWithDetails[],
  participatingMembers: HouseholdMember[],
  dietaryPrefs: MemberDietaryPref[]
): DietaryConflict[] {
  const conflicts: DietaryConflict[] = [];

  for (const member of participatingMembers) {
    // Get this member's prefs that are warnings (allergy, hard_no, dislike)
    const memberPrefs = dietaryPrefs.filter(
      (p) =>
        p.member_id === member.id &&
        (p.pref_type === "allergy" || p.pref_type === "hard_no" || p.pref_type === "dislike")
    );

    if (memberPrefs.length === 0) continue;

    for (const ingredient of recipeIngredients) {
      const ingredientName = ingredient.ingredients?.name?.toLowerCase() ?? "";
      if (!ingredientName) continue;

      for (const pref of memberPrefs) {
        // Match by ingredient_id (exact) or by name (fuzzy — contains check)
        const prefIngredientName = (pref.ingredient_name ?? "").toLowerCase();
        const matchById =
          pref.ingredient_id && ingredient.ingredient_id === pref.ingredient_id;
        const matchByName =
          prefIngredientName &&
          (ingredientName.includes(prefIngredientName) ||
            prefIngredientName.includes(ingredientName));

        if (matchById || matchByName) {
          conflicts.push({
            memberId: member.id,
            memberName: member.name,
            ingredientName: ingredient.ingredients?.name ?? pref.ingredient_name ?? "Unknown",
            prefType: pref.pref_type as "allergy" | "hard_no" | "dislike",
          });
        }
      }
    }
  }

  return conflicts;
}

// ---------------------------------------------------------------------------
// Batch: compute conflicts for ALL recipes (for the planner page)
// ---------------------------------------------------------------------------

/**
 * Pre-compute dietary conflicts for every recipe used in the week plan.
 * Returns a map of recipeId → DietaryConflict[].
 *
 * Only checks against ACTIVE participants (is_participating = true).
 */
export function computeDietaryConflictMap(
  ingredientsByRecipe: Map<string, RecipeIngredientWithDetails[]>,
  allMembers: HouseholdMember[],
  dietaryPrefs: MemberDietaryPref[]
): DietaryConflictMap {
  const result: DietaryConflictMap = {};

  // Check all recipes against ALL members (not slot-specific).
  // Slot-specific filtering happens in the UI when we know who's participating.
  ingredientsByRecipe.forEach((ingredients, recipeId) => {
    const conflicts = checkDietaryConflicts(ingredients, allMembers, dietaryPrefs);
    if (conflicts.length > 0) {
      result[recipeId] = conflicts;
    }
  });

  return result;
}

// ---------------------------------------------------------------------------
// Slot-level: check conflicts for a specific meal slot
// ---------------------------------------------------------------------------

/**
 * Get dietary conflicts for a specific slot, considering only active participants.
 * Multi-dish aware: checks ALL recipes in the slot and merges conflicts.
 */
export function getSlotDietaryConflicts(
  slot: MealSlotWithRecipe | MealSlotWithDishes,
  allSlots: (MealSlotWithRecipe | MealSlotWithDishes)[],
  slotParticipants: MealSlotParticipantWithMember[],
  allMembers: HouseholdMember[],
  ingredientsByRecipe: Map<string, RecipeIngredientWithDetails[]>,
  dietaryPrefs: MemberDietaryPref[]
): DietaryConflict[] {
  // Determine which recipe(s) to check
  let recipeIds: string[] = [];
  if (slot.meal_mode === "cook") {
    recipeIds = getSlotRecipeIds(slot);
  } else if (slot.meal_mode === "leftover" && slot.leftover_source_id) {
    const sourceSlot = allSlots.find((s) => s.id === slot.leftover_source_id);
    if (sourceSlot) {
      recipeIds = getSlotRecipeIds(sourceSlot);
    }
  }

  if (recipeIds.length === 0) return [];

  // Collect ingredients from ALL recipes in this slot
  const allIngredients: RecipeIngredientWithDetails[] = [];
  for (const recipeId of recipeIds) {
    const ingredients = ingredientsByRecipe.get(recipeId) ?? [];
    allIngredients.push(...ingredients);
  }
  if (allIngredients.length === 0) return [];

  // Get active participating members
  const activeMemberIds = new Set(
    slotParticipants
      .filter((p) => p.is_participating)
      .map((p) => p.member_id)
  );

  const activeMembers = allMembers.filter((m) => activeMemberIds.has(m.id));
  if (activeMembers.length === 0) return [];

  return checkDietaryConflicts(allIngredients, activeMembers, dietaryPrefs);
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Severity label for UI display */
export function getPrefTypeLabel(prefType: string): string {
  switch (prefType) {
    case "allergy":
      return "Allergy";
    case "hard_no":
      return "Cannot eat";
    case "dislike":
      return "Dislikes";
    default:
      return prefType;
  }
}

/** Severity emoji for UI display */
export function getPrefTypeEmoji(prefType: string): string {
  switch (prefType) {
    case "allergy":
      return "🚨";
    case "hard_no":
      return "🚫";
    case "dislike":
      return "👎";
    default:
      return "⚠️";
  }
}

/** Sort conflicts by severity: allergy > hard_no > dislike */
export function sortConflictsBySeverity(conflicts: DietaryConflict[]): DietaryConflict[] {
  const order = { allergy: 0, hard_no: 1, dislike: 2 };
  return [...conflicts].sort(
    (a, b) => (order[a.prefType] ?? 3) - (order[b.prefType] ?? 3)
  );
}

/**
 * Filter conflicts for recipes in the slot editor.
 * Given a recipe ID and the currently participating member IDs,
 * return only the conflicts that affect those members.
 */
export function getConflictsForRecipe(
  recipeId: string,
  conflictMap: DietaryConflictMap,
  participatingMemberIds: Set<string>
): DietaryConflict[] {
  const allConflicts = conflictMap[recipeId] ?? [];
  return allConflicts.filter((c) => participatingMemberIds.has(c.memberId));
}
