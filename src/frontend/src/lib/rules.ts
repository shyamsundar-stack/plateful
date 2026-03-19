/**
 * Conditional meal rules engine — pure functions, no Supabase imports.
 *
 * Matches meal rules against a date + meal type, then applies constraints
 * (dietary mode overrides, cuisine boosts, ingredient exclusions, tag boosts)
 * to the candidate recipe list for auto-fill.
 */

import type {
  MealRule,
  FestivalCalendarEntry,
  Recipe,
} from "@/lib/types/database";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

/** Result of evaluating rules for a specific slot */
export type ApplicableRules = {
  /** Dietary mode overrides (e.g., "vegetarian" for a fasting day) */
  dietaryModeOverrides: string[];
  /** Cuisine preferences to boost (e.g., "arabian" for dinner rule) */
  cuisineBoosts: string[];
  /** Ingredient names to exclude */
  excludedIngredients: string[];
  /** Tags to boost (e.g., "no-onion-garlic" for Jain fasting) */
  includedTags: string[];
  /** Source rules that matched (for UI display) */
  matchedRules: MealRule[];
};

/** Result of applying rules to a recipe candidate list */
export type RuleFilterResult = {
  /** Recipe IDs to exclude entirely */
  excludedRecipeIds: Set<string>;
  /** Recipe ID → bonus score from rules */
  ruleBoosts: Map<string, number>;
};

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/** Score boost for cuisine match from a rule */
const CUISINE_BOOST = 3;

/** Score boost for tag match from a rule */
const TAG_BOOST = 2;

/** Score boost for favorite recipes */
export const FAVORITE_BOOST = 2;

/** Score boost per rating point above 3 (e.g., 4★ = +1, 5★ = +2) */
export const RATING_BOOST_PER_POINT = 1;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/**
 * Get the ISO day of week from a date string.
 * Returns 1 (Monday) through 7 (Sunday).
 */
function getIsoDayOfWeek(dateStr: string): number {
  const d = new Date(dateStr + "T00:00:00");
  const jsDay = d.getDay(); // 0=Sun, 1=Mon, ..., 6=Sat
  return jsDay === 0 ? 7 : jsDay; // Convert to ISO: 1=Mon, 7=Sun
}

/**
 * Check if a date falls within a date range.
 * condition_value format: "2026-03-01|2026-03-15"
 */
function isInDateRange(dateStr: string, rangeStr: string): boolean {
  const [start, end] = rangeStr.split("|");
  if (!start || !end) return false;
  return dateStr >= start && dateStr <= end;
}

/**
 * Check if a date falls within any active festival period.
 */
function getMatchingFestivals(
  dateStr: string,
  festivals: FestivalCalendarEntry[]
): FestivalCalendarEntry[] {
  return festivals.filter(
    (f) => dateStr >= f.start_date && dateStr <= f.end_date
  );
}

// ---------------------------------------------------------------------------
// Core: find applicable rules for a date + meal type
// ---------------------------------------------------------------------------

/**
 * Given all household rules, festivals, and the slot's date + meal type,
 * return the combined set of constraints that should be applied.
 *
 * Rules are evaluated in priority order (lower number = higher priority).
 */
export function getApplicableRules(
  rules: MealRule[],
  festivals: FestivalCalendarEntry[],
  slotDate: string,
  mealType: string
): ApplicableRules {
  const result: ApplicableRules = {
    dietaryModeOverrides: [],
    cuisineBoosts: [],
    excludedIngredients: [],
    includedTags: [],
    matchedRules: [],
  };

  // Only active rules, sorted by priority (lower = higher priority)
  const activeRules = rules
    .filter((r) => r.is_active)
    .sort((a, b) => a.priority - b.priority);

  // Check which festivals are active on this date
  const activeFestivals = getMatchingFestivals(slotDate, festivals);
  const activeFestivalNames = new Set(
    activeFestivals.map((f) => f.name.toLowerCase())
  );

  for (const rule of activeRules) {
    let matches = false;

    switch (rule.condition_type) {
      case "day_of_week": {
        // condition_value can be "4" (Thursday) or "4,6" (Thu + Sat)
        const targetDays = rule.condition_value.split(",").map((d) => parseInt(d.trim(), 10));
        const slotDay = getIsoDayOfWeek(slotDate);
        matches = targetDays.includes(slotDay);
        break;
      }
      case "meal_type": {
        // condition_value: "breakfast", "lunch", "dinner", "snack"
        matches = rule.condition_value.toLowerCase() === mealType.toLowerCase();
        break;
      }
      case "date_range": {
        // condition_value: "2026-03-01|2026-03-15"
        matches = isInDateRange(slotDate, rule.condition_value);
        break;
      }
      case "festival": {
        // condition_value: festival name (e.g., "navratri", "shravan")
        matches = activeFestivalNames.has(rule.condition_value.toLowerCase());
        break;
      }
    }

    if (!matches) continue;

    result.matchedRules.push(rule);

    switch (rule.action_type) {
      case "set_dietary_mode":
        result.dietaryModeOverrides.push(rule.action_value.toLowerCase());
        break;
      case "prefer_cuisine":
        result.cuisineBoosts.push(rule.action_value.toLowerCase());
        break;
      case "exclude_ingredient":
        result.excludedIngredients.push(rule.action_value.toLowerCase());
        break;
      case "include_tag":
        result.includedTags.push(rule.action_value.toLowerCase());
        break;
    }
  }

  // Also apply dietary modes from active festivals directly
  // (festivals can have dietary_mode set, e.g., Navratri → vegetarian)
  for (const festival of activeFestivals) {
    if (festival.dietary_mode) {
      result.dietaryModeOverrides.push(festival.dietary_mode);
    }
  }

  return result;
}

// ---------------------------------------------------------------------------
// Core: apply rules to recipe candidates
// ---------------------------------------------------------------------------

/**
 * Given applicable rules and the full recipe list (with their ingredient data),
 * determine which recipes should be excluded and which get score boosts.
 *
 * @param applicableRules - Output of getApplicableRules()
 * @param recipes - Active recipes to filter
 * @param recipeIngredientNames - Map of recipeId → ingredient name list (lowercase)
 */
export function applyRulesToCandidates(
  applicableRules: ApplicableRules,
  recipes: Recipe[],
  recipeIngredientNames?: Map<string, string[]>
): RuleFilterResult {
  const excludedRecipeIds = new Set<string>();
  const ruleBoosts = new Map<string, number>();

  for (const recipe of recipes) {
    let boost = 0;

    // 1. Dietary mode override: exclude recipes that don't match
    for (const mode of applicableRules.dietaryModeOverrides) {
      if (mode === "vegetarian" && !recipe.is_vegetarian) {
        excludedRecipeIds.add(recipe.id);
      }
      if (mode === "vegan" && !recipe.is_vegan) {
        excludedRecipeIds.add(recipe.id);
      }
    }

    // Already excluded? Skip scoring
    if (excludedRecipeIds.has(recipe.id)) continue;

    // 2. Cuisine boost
    const recipeCuisine = (recipe.cuisine ?? "").toLowerCase();
    const recipeCuisineCategory = (recipe.cuisine_category ?? "").toLowerCase();
    for (const cuisine of applicableRules.cuisineBoosts) {
      if (recipeCuisine === cuisine || recipeCuisineCategory === cuisine) {
        boost += CUISINE_BOOST;
      }
    }

    // 3. Exclude by ingredient name
    if (recipeIngredientNames && applicableRules.excludedIngredients.length > 0) {
      const ingredientNames = recipeIngredientNames.get(recipe.id) ?? [];
      for (const excludedName of applicableRules.excludedIngredients) {
        const hasExcluded = ingredientNames.some(
          (name) => name.includes(excludedName) || excludedName.includes(name)
        );
        if (hasExcluded) {
          excludedRecipeIds.add(recipe.id);
          break;
        }
      }
    }

    // Already excluded? Skip remaining
    if (excludedRecipeIds.has(recipe.id)) continue;

    // 4. Tag boost
    const recipeTags = (recipe.tags ?? []).map((t) => t.toLowerCase());
    const recipeDietaryTags = (recipe.dietary_tags ?? []).map((t) => t.toLowerCase());
    const allRecipeTags = [...recipeTags, ...recipeDietaryTags];
    for (const tag of applicableRules.includedTags) {
      if (allRecipeTags.includes(tag)) {
        boost += TAG_BOOST;
      }
    }

    if (boost > 0) {
      ruleBoosts.set(recipe.id, boost);
    }
  }

  return { excludedRecipeIds, ruleBoosts };
}

// ---------------------------------------------------------------------------
// Helper: filter recipes by member dietary modes
// ---------------------------------------------------------------------------

/**
 * Given participating members' dietary modes, determine which recipes are allowed.
 * The MOST restrictive mode among participants wins.
 *
 * Priority: vegan > vegetarian > eggetarian > non_vegetarian
 *
 * - vegan → only is_vegan recipes
 * - vegetarian → only is_vegetarian recipes
 * - eggetarian → only is_vegetarian OR recipes with only egg as non-veg protein
 *   (simplified: use is_vegetarian as proxy — real egg detection needs ingredient data)
 * - non_vegetarian → all recipes
 */
export function filterByDietaryModes(
  recipes: Recipe[],
  memberDietaryModes: string[]
): Recipe[] {
  if (memberDietaryModes.length === 0) return recipes;

  // Find the most restrictive mode
  const hasModeSet = new Set(memberDietaryModes.map((m) => m.toLowerCase()));

  if (hasModeSet.has("vegan")) {
    return recipes.filter((r) => r.is_vegan);
  }
  if (hasModeSet.has("vegetarian")) {
    return recipes.filter((r) => r.is_vegetarian);
  }
  if (hasModeSet.has("eggetarian")) {
    // Eggetarian: vegetarian + egg-only dishes
    // For now, use is_vegetarian as a proxy (conservative)
    // A more precise filter would check if non-veg ingredients are only eggs
    return recipes.filter((r) => r.is_vegetarian);
  }

  // All non_vegetarian — no filter
  return recipes;
}

// ---------------------------------------------------------------------------
// Utility: get rating and favorite boosts for a recipe
// ---------------------------------------------------------------------------

/**
 * Calculate score boosts from rating and favorite status.
 */
export function getRatingFavoriteBoost(recipe: Recipe): number {
  let boost = 0;

  // Favorite boost
  if (recipe.is_favorite) {
    boost += FAVORITE_BOOST;
  }

  // Rating boost: +1 per star above 3
  if (recipe.rating && recipe.rating > 3) {
    boost += (recipe.rating - 3) * RATING_BOOST_PER_POINT;
  }

  return boost;
}
