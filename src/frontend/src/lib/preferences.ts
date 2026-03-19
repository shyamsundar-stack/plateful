/**
 * Preference scoring and recipe ranking — pure functions, no Supabase imports.
 *
 * Calculates preference scores based on historical accept/reject data,
 * with recency weighting and cuisine affinity bonuses.
 */

import type {
  Recipe,
  RecipePreference,
  RecipePreferenceScore,
} from "@/lib/types/database";
import { getRatingFavoriteBoost } from "@/lib/rules";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/** Only consider preferences from the last N weeks for scoring */
const RECENCY_WINDOW_WEEKS = 8;

/** How much newer preferences are weighted vs older ones */
const RECENCY_DECAY = 0.85; // each week older → 85% of previous weight

/** Number of top-scoring recipes to mark as "recommended" */
const RECOMMENDED_COUNT = 3;

// ---------------------------------------------------------------------------
// Core: calculate preference score for a single recipe
// ---------------------------------------------------------------------------

/**
 * Calculate a preference score for a recipe based on historical data.
 *
 * Score = sum of weighted accepts - sum of weighted rejects
 * Weight decreases with age (recency bias).
 * Cuisine affinity adds a bonus if the household frequently picks this cuisine.
 */
function calculateScore(
  recipeId: string,
  preferences: RecipePreference[],
  cuisineBonus: Map<string, number>,
  recipe: Recipe
): RecipePreferenceScore {
  const now = new Date();
  const cutoff = new Date(now);
  cutoff.setDate(cutoff.getDate() - RECENCY_WINDOW_WEEKS * 7);

  const recentPrefs = preferences.filter(
    (p) =>
      p.recipe_id === recipeId &&
      new Date(p.created_at) >= cutoff
  );

  let score = 0;
  let acceptCount = 0;
  let rejectCount = 0;

  for (const pref of recentPrefs) {
    // Calculate age in weeks
    const ageMs = now.getTime() - new Date(pref.created_at).getTime();
    const ageWeeks = Math.floor(ageMs / (7 * 24 * 60 * 60 * 1000));
    const weight = Math.pow(RECENCY_DECAY, ageWeeks);

    if (pref.action === "accept") {
      score += weight;
      acceptCount++;
    } else if (pref.action === "reject") {
      score -= weight;
      rejectCount++;
    }
    // "skip" doesn't affect score
  }

  // Add cuisine affinity bonus (0-2 range)
  if (recipe.cuisine) {
    score += cuisineBonus.get(recipe.cuisine.toLowerCase()) ?? 0;
  }

  return {
    recipeId,
    score,
    acceptCount,
    rejectCount,
    isRecommended: false, // set during ranking phase
  };
}

// ---------------------------------------------------------------------------
// Batch: calculate cuisine affinity from all preferences
// ---------------------------------------------------------------------------

/**
 * Build a cuisine affinity map from historical preferences.
 * Cuisines that are frequently accepted get a bonus (0-2 range).
 */
function buildCuisineAffinity(
  preferences: RecipePreference[],
  recipes: Recipe[]
): Map<string, number> {
  const recipeMap = new Map<string, Recipe>();
  for (const r of recipes) recipeMap.set(r.id, r);

  const cuisineCounts = new Map<string, { accepts: number; total: number }>();

  for (const pref of preferences) {
    const recipe = recipeMap.get(pref.recipe_id);
    if (!recipe?.cuisine) continue;

    const cuisine = recipe.cuisine.toLowerCase();
    const existing = cuisineCounts.get(cuisine) ?? { accepts: 0, total: 0 };
    existing.total++;
    if (pref.action === "accept") existing.accepts++;
    cuisineCounts.set(cuisine, existing);
  }

  const result = new Map<string, number>();
  cuisineCounts.forEach(({ accepts, total }, cuisine) => {
    if (total >= 2) {
      // Scale: 0 to 2 based on accept ratio
      result.set(cuisine, (accepts / total) * 2);
    }
  });

  return result;
}

// ---------------------------------------------------------------------------
// Main: rank recipes for the slot editor
// ---------------------------------------------------------------------------

/**
 * Rank all recipes by preference score.
 * Returns a map of recipeId → PreferenceScore, with top 3 marked as recommended.
 *
 * @param recipes - All active recipes in the household
 * @param preferences - Historical preference data (already filtered by household)
 * @param mealType - Optional: boost recipes that match this meal type
 */
export function rankRecipesByPreference(
  recipes: Recipe[],
  preferences: RecipePreference[],
  mealType?: string
): Map<string, RecipePreferenceScore> {
  const cuisineBonus = buildCuisineAffinity(preferences, recipes);
  const scores = new Map<string, RecipePreferenceScore>();

  for (const recipe of recipes) {
    const prefScore = calculateScore(recipe.id, preferences, cuisineBonus, recipe);

    // Meal type match bonus: if recipe's meal_types includes the current slot's meal type
    if (mealType && recipe.meal_types?.includes(mealType)) {
      prefScore.score += 1.0;
    }

    // Rating + favorite boost (Phase 5)
    prefScore.score += getRatingFavoriteBoost(recipe);

    scores.set(recipe.id, prefScore);
  }

  // Mark top N as recommended (only those with score > 0)
  const sorted = Array.from(scores.values())
    .filter((s) => s.score > 0)
    .sort((a, b) => b.score - a.score);

  for (let i = 0; i < Math.min(RECOMMENDED_COUNT, sorted.length); i++) {
    sorted[i].isRecommended = true;
    // Update in the map
    scores.set(sorted[i].recipeId, sorted[i]);
  }

  return scores;
}

/**
 * Sort recipes array by preference score (highest first).
 * Recipes with no score data sort after scored ones, alphabetically.
 */
export function sortRecipesByPreference(
  recipes: Recipe[],
  scores: Map<string, RecipePreferenceScore>
): Recipe[] {
  return [...recipes].sort((a, b) => {
    const scoreA = scores.get(a.id)?.score ?? -999;
    const scoreB = scores.get(b.id)?.score ?? -999;

    // Both have scores → sort by score descending
    if (scoreA !== -999 && scoreB !== -999) {
      if (scoreB !== scoreA) return scoreB - scoreA;
    }

    // One has score, other doesn't → scored first
    if (scoreA !== -999 && scoreB === -999) return -1;
    if (scoreA === -999 && scoreB !== -999) return 1;

    // Both unscored → alphabetical
    return a.title.localeCompare(b.title);
  });
}
