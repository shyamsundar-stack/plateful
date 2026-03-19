/**
 * Smart meal suggestion engine — pure functions, no Supabase imports.
 *
 * Generates recipe suggestions for empty cook slots in a week plan.
 * Uses preference scoring, dietary conflict filtering, meal type matching,
 * protein bias, and variety constraints.
 */

import type {
  Recipe,
  RecipePreference,
  MealSlotWithRecipe,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  HouseholdMember,
  MemberDietaryPref,
  RecipeIngredientWithDetails,
  DietaryConflictMap,
  RecipeNutrition,
  MealRule,
  FestivalCalendarEntry,
} from "@/lib/types/database";
import { rankRecipesByPreference } from "@/lib/preferences";
import { checkDietaryConflicts } from "@/lib/dietary";
import {
  getApplicableRules,
  applyRulesToCandidates,
  filterByDietaryModes,
  getRatingFavoriteBoost,
} from "@/lib/rules";
import { getSlotRecipeIds } from "@/lib/meal-utils";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/** Don't repeat same recipe within this many days (strict for auto-fill) */
const VARIETY_THRESHOLD_DAYS = 5;

/** Score bonus for high-protein recipes */
const PROTEIN_BONUS = 2;

/** Protein threshold: grams per serving to qualify as "high protein" */
const HIGH_PROTEIN_GRAMS_PER_SERVING = 20;

/** Protein threshold: percentage of calories from protein */
const HIGH_PROTEIN_CALORIE_PERCENT = 25;

/** Score bonus for meal type match */
const MEAL_TYPE_MATCH_BONUS = 3;

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export type SuggestionParams = {
  slots: (MealSlotWithRecipe | MealSlotWithDishes)[];
  recipes: Recipe[];
  preferences: RecipePreference[];
  participantsBySlot: Map<string, MealSlotParticipantWithMember[]>;
  members: HouseholdMember[];
  dietaryPrefs: MemberDietaryPref[];
  ingredientsByRecipe: Map<string, RecipeIngredientWithDetails[]>;
  dietaryConflictMap: DietaryConflictMap;
  nutritionByRecipe?: Map<string, RecipeNutrition>;
  varietyThresholdDays?: number;
  /** Meal rules for the household */
  mealRules?: MealRule[];
  /** Festival calendar entries for the year */
  festivals?: FestivalCalendarEntry[];
};

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Check if a recipe qualifies as "high protein" */
export function isHighProtein(nutrition?: RecipeNutrition): boolean {
  if (!nutrition || nutrition.confidence < 0.3) return false;

  // Check absolute protein per serving
  if (nutrition.proteinPerServing >= HIGH_PROTEIN_GRAMS_PER_SERVING) return true;

  // Check protein as percentage of calories (protein = 4 cal/g)
  if (nutrition.caloriesPerServing > 0) {
    const proteinCalories = nutrition.proteinPerServing * 4;
    const proteinPercent = (proteinCalories / nutrition.caloriesPerServing) * 100;
    if (proteinPercent >= HIGH_PROTEIN_CALORIE_PERCENT) return true;
  }

  return false;
}

/** Get the date difference in days between two ISO date strings */
function daysBetween(date1: string, date2: string): number {
  const d1 = new Date(date1 + "T00:00:00");
  const d2 = new Date(date2 + "T00:00:00");
  return Math.abs(Math.round((d1.getTime() - d2.getTime()) / (24 * 60 * 60 * 1000)));
}

// ---------------------------------------------------------------------------
// Core: Generate suggestions for all empty cook slots
// ---------------------------------------------------------------------------

/**
 * Generate recipe suggestions for empty cook slots.
 * Returns a Map of slotId → recipeId for slots that should be auto-filled.
 *
 * Algorithm:
 * 1. Only fill empty cook slots (no recipe assigned)
 * 2. For each slot, build candidate list from active recipes
 * 3. Score using preference ranking + meal type match + protein bias
 * 4. Filter out dietary conflicts (allergy/hard_no only — dislikes stay)
 * 5. Enforce variety: skip if same recipe assigned within threshold days
 * 6. Pick highest-scoring candidate per slot
 */
export function generateWeekSuggestions(
  params: SuggestionParams
): Map<string, string> {
  const {
    slots,
    recipes,
    preferences,
    participantsBySlot,
    members,
    dietaryPrefs,
    ingredientsByRecipe,
    nutritionByRecipe,
    varietyThresholdDays = VARIETY_THRESHOLD_DAYS,
    mealRules = [],
    festivals = [],
  } = params;

  const result = new Map<string, string>();

  // Only active recipes
  const activeRecipes = recipes.filter(
    (r) => r.status === "active" && !r.is_archived
  );
  if (activeRecipes.length === 0) return result;

  // Pre-compute ingredient name lists for rule-based filtering
  const recipeIngredientNames = new Map<string, string[]>();
  ingredientsByRecipe.forEach((ingredients, recipeId) => {
    recipeIngredientNames.set(
      recipeId,
      ingredients.map((i) => (i.ingredients?.name ?? "").toLowerCase())
    );
  });

  // Get base preference scores
  const preferenceScores = rankRecipesByPreference(activeRecipes, preferences);

  // Find empty cook slots (cook mode, no recipe assigned)
  const emptySlots = slots.filter(
    (s) => s.meal_mode === "cook" && !s.recipe_id
  );

  // Sort slots by date to process in order (important for variety tracking)
  const sortedEmptySlots = [...emptySlots].sort((a, b) =>
    a.slot_date.localeCompare(b.slot_date)
  );

  // Track assigned recipes for variety constraint (includes existing assignments)
  // Multi-dish aware: track ALL recipe IDs in each slot
  const assignedRecipes = new Map<string, string[]>(); // recipeId → [dates]
  for (const slot of slots) {
    const recipeIds = getSlotRecipeIds(slot);
    for (const recipeId of recipeIds) {
      const dates = assignedRecipes.get(recipeId) ?? [];
      dates.push(slot.slot_date);
      assignedRecipes.set(recipeId, dates);
    }
  }

  for (const slot of sortedEmptySlots) {
    // Get participating members for this slot
    const slotParticipants = participantsBySlot.get(slot.id) ?? [];
    const activeMemberIds = new Set(
      slotParticipants.filter((p) => p.is_participating).map((p) => p.member_id)
    );
    const activeMembers = members.filter((m) => activeMemberIds.has(m.id));

    // --- Phase 5: Dietary mode filtering ---
    // Get dietary modes of participating members
    const memberDietaryModes = activeMembers
      .map((m) => m.dietary_mode)
      .filter(Boolean);

    // Filter recipes by members' base dietary modes
    let slotCandidates = filterByDietaryModes(activeRecipes, memberDietaryModes);

    // --- Phase 5: Rules engine ---
    // Get applicable rules for this slot's date + meal type
    const applicableRules = getApplicableRules(
      mealRules,
      festivals,
      slot.slot_date,
      slot.meal_type
    );

    // Apply rule-based exclusions and boosts
    const { excludedRecipeIds: ruleExcluded, ruleBoosts } =
      applyRulesToCandidates(applicableRules, slotCandidates, recipeIngredientNames);

    // Remove rule-excluded recipes from candidates
    if (ruleExcluded.size > 0) {
      slotCandidates = slotCandidates.filter((r) => !ruleExcluded.has(r.id));
    }

    let bestRecipeId: string | null = null;
    let bestScore = -Infinity;

    for (const recipe of slotCandidates) {
      let score = preferenceScores.get(recipe.id)?.score ?? 0;

      // 1. Meal type match bonus
      if (recipe.meal_types?.includes(slot.meal_type)) {
        score += MEAL_TYPE_MATCH_BONUS;
      }

      // 2. High protein bonus
      if (nutritionByRecipe) {
        const nutrition = nutritionByRecipe.get(recipe.id);
        if (isHighProtein(nutrition)) {
          score += PROTEIN_BONUS;
        }
      }

      // 3. Rating + favorite boost (Phase 5)
      score += getRatingFavoriteBoost(recipe);

      // 4. Rule-based boost (Phase 5)
      score += ruleBoosts.get(recipe.id) ?? 0;

      // 5. Dietary conflict filter — skip recipes with allergies or hard_no
      const recipeIngredients = ingredientsByRecipe.get(recipe.id) ?? [];
      if (recipeIngredients.length > 0 && activeMembers.length > 0) {
        const conflicts = checkDietaryConflicts(
          recipeIngredients,
          activeMembers,
          dietaryPrefs
        );
        const hasSevereConflict = conflicts.some(
          (c) => c.prefType === "allergy" || c.prefType === "hard_no"
        );
        if (hasSevereConflict) continue; // Skip this recipe entirely
      }

      // 6. Variety constraint — skip if used within threshold days
      const usedDates = assignedRecipes.get(recipe.id) ?? [];
      const tooRecent = usedDates.some(
        (date) => daysBetween(date, slot.slot_date) < varietyThresholdDays
      );
      if (tooRecent) continue;

      // 7. Meal type mismatch penalty: skip breakfast recipes for dinner, etc.
      if (
        recipe.meal_types &&
        recipe.meal_types.length > 0 &&
        !recipe.meal_types.includes(slot.meal_type)
      ) {
        score -= 5;
      }

      // Update best
      if (score > bestScore) {
        bestScore = score;
        bestRecipeId = recipe.id;
      }
    }

    if (bestRecipeId) {
      result.set(slot.id, bestRecipeId);
      // Track for variety
      const dates = assignedRecipes.get(bestRecipeId) ?? [];
      dates.push(slot.slot_date);
      assignedRecipes.set(bestRecipeId, dates);
    }
  }

  return result;
}
