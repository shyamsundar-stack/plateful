// =============================================================================
// Grocery Aggregation Engine — Session 11
// =============================================================================
// Pure functions. No Supabase imports. No side effects.
// Aggregates recipe ingredients into a merged grocery list.
// =============================================================================

import type {
  MealSlotWithRecipe,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  RecipeIngredientWithDetails,
  UnitConversion,
  AggregatedGroceryItem,
} from "@/lib/types/database";
import { convertToGrams, buildConversionMap } from "@/lib/nutrition";
import { getSlotDishes } from "@/lib/meal-utils";

// ---------------------------------------------------------------------------
// Category mapping — maps ingredient categories to grocery store sections
// ---------------------------------------------------------------------------

const CATEGORY_MAP: Record<string, string> = {
  vegetable: "produce",
  fruit: "produce",
  leafy_green: "produce",
  herb: "produce",
  protein: "protein",
  seafood: "protein",
  egg: "protein",
  dairy: "dairy",
  grain: "grains",
  flour: "grains",
  bread: "grains",
  rice: "grains",
  pasta: "grains",
  noodle: "grains",
  spice: "spices",
  seasoning: "spices",
  oil: "oils",
  fat: "oils",
  ghee: "oils",
  legume: "legumes",
  lentil: "legumes",
  bean: "legumes",
  nut: "nuts_seeds",
  seed: "nuts_seeds",
  dry_fruit: "nuts_seeds",
  condiment: "condiments",
  sauce: "condiments",
  vinegar: "condiments",
  frozen: "frozen",
  other: "other",
};

/** Map ingredient category to grocery store section */
export function mapToGroceryCategory(ingredientCategory: string | null): string {
  if (!ingredientCategory) return "other";
  return CATEGORY_MAP[ingredientCategory.toLowerCase()] ?? "other";
}

// ---------------------------------------------------------------------------
// Best display unit — pick a human-friendly unit for the total grams
// ---------------------------------------------------------------------------

const DISPLAY_UNIT_RULES: Array<{
  minGrams: number;
  unit: string;
  divisor: number;
}> = [
  { minGrams: 1000, unit: "kg", divisor: 1000 },
  { minGrams: 100, unit: "g", divisor: 1 },
  { minGrams: 15, unit: "tbsp", divisor: 15 },
  { minGrams: 5, unit: "tsp", divisor: 5 },
  { minGrams: 0, unit: "g", divisor: 1 },
];

/** Convert total grams back to a friendly display unit */
export function toDisplayUnit(totalGrams: number): {
  quantity: number;
  unit: string;
} {
  for (const rule of DISPLAY_UNIT_RULES) {
    if (totalGrams >= rule.minGrams) {
      return {
        quantity: Math.round((totalGrams / rule.divisor) * 10) / 10,
        unit: rule.unit,
      };
    }
  }
  return { quantity: Math.round(totalGrams * 10) / 10, unit: "g" };
}

// ---------------------------------------------------------------------------
// Main aggregation function
// ---------------------------------------------------------------------------

/**
 * Walk all cook slots in a week plan, sum recipe ingredients,
 * merge duplicates, scale by participants, convert units, and
 * return a list of aggregated grocery items grouped by store section.
 *
 * Supports multi-dish slots: collects ingredients from ALL dishes in each slot,
 * applying each dish's portion_factor to quantities.
 */
export function aggregateGroceryItems(
  slots: (MealSlotWithRecipe | MealSlotWithDishes)[],
  participantsBySlot: Map<string, MealSlotParticipantWithMember[]>,
  recipeIngredientsByRecipe: Map<string, RecipeIngredientWithDetails[]>,
  conversions: UnitConversion[]
): AggregatedGroceryItem[] {
  const conversionMap = buildConversionMap(conversions);

  // Accumulator: ingredient name (lowercase) → { totalGrams, category, sources, ingredientId }
  const accumulator = new Map<
    string,
    {
      ingredientId: string | null;
      name: string;
      totalGrams: number;
      category: string;
      recipeSources: Set<string>;
      hasUnconvertible: boolean;
      rawQuantity: number;
      rawUnit: string | null;
    }
  >();

  for (const slot of slots) {
    // Only process cook slots with recipes
    if (slot.meal_mode !== "cook") continue;

    // Get all dishes in this slot (multi-dish or single fallback)
    const dishes = getSlotDishes(slot);
    if (dishes.length === 0) continue;

    // Count active participants for scaling
    const slotParticipants = participantsBySlot.get(slot.id) ?? [];
    const activeCount = slotParticipants.filter(
      (p) => p.is_participating
    ).length;
    if (activeCount === 0) continue;

    // Get recipe servings and compute base scale factor
    const recipeServings = slot.servings_override ?? 2;
    const baseScaleFactor = activeCount / recipeServings;

    // Process each dish in this slot
    for (const dish of dishes) {
      const recipeIngredients =
        recipeIngredientsByRecipe.get(dish.recipeId) ?? [];
      if (recipeIngredients.length === 0) continue;

      // Apply both participant scale and dish portion_factor
      const scaleFactor = baseScaleFactor * dish.portionFactor;

      // Look up recipe title from the slot's joined data or from ingredients
      // For multi-dish slots with joined recipe data, get title from dishes array
      const slotWithDishes = slot as MealSlotWithDishes;
      const dishData = slotWithDishes.meal_slot_dishes?.find(
        (d) => d.recipe_id === dish.recipeId
      );
      const recipeTitle =
        dishData?.recipes?.title ??
        (slot.recipe_id === dish.recipeId ? slot.recipes?.title : null) ??
        "Unknown";

      for (const ri of recipeIngredients) {
        const ing = ri.ingredients;
        if (!ing) continue;

        const key = ing.name.toLowerCase().trim();
        const existing = accumulator.get(key);

        // Try to convert to grams
        const grams = convertToGrams(ri.quantity, ri.unit, conversionMap);
        const scaledGrams = grams != null ? grams * scaleFactor : null;

        if (existing) {
          if (scaledGrams != null) {
            existing.totalGrams += scaledGrams;
          } else {
            existing.hasUnconvertible = true;
            existing.rawQuantity += (ri.quantity ?? 0) * scaleFactor;
            existing.rawUnit = ri.unit;
          }
          existing.recipeSources.add(recipeTitle);
        } else {
          accumulator.set(key, {
            ingredientId: ing.id,
            name: ing.name,
            totalGrams: scaledGrams ?? 0,
            category: mapToGroceryCategory(ing.category),
            recipeSources: new Set([recipeTitle]),
            hasUnconvertible: scaledGrams == null,
            rawQuantity: scaledGrams == null ? (ri.quantity ?? 0) * scaleFactor : 0,
            rawUnit: scaledGrams == null ? ri.unit : null,
          });
        }
      }
    }
  }

  // Convert accumulator to AggregatedGroceryItem[]
  const items: AggregatedGroceryItem[] = [];

  for (const [, data] of Array.from(accumulator.entries())) {
    let displayQuantity: number | null;
    let displayUnit: string | null;

    if (data.totalGrams > 0) {
      const display = toDisplayUnit(data.totalGrams);
      displayQuantity = display.quantity;
      displayUnit = display.unit;
    } else if (data.hasUnconvertible && data.rawQuantity > 0) {
      // Can't convert — show raw quantity + unit
      displayQuantity = Math.round(data.rawQuantity * 10) / 10;
      displayUnit = data.rawUnit;
    } else {
      displayQuantity = null;
      displayUnit = null;
    }

    items.push({
      ingredientId: data.ingredientId,
      name: data.name,
      totalQuantityGrams: data.totalGrams > 0 ? data.totalGrams : null,
      displayQuantity,
      displayUnit,
      category: data.category,
      recipeSources: Array.from(data.recipeSources),
    });
  }

  // Sort by category, then by name
  items.sort((a, b) => {
    if (a.category !== b.category) return a.category.localeCompare(b.category);
    return a.name.localeCompare(b.name);
  });

  return items;
}

// ---------------------------------------------------------------------------
// Category display helpers
// ---------------------------------------------------------------------------

const CATEGORY_LABELS: Record<string, string> = {
  produce: "🥬 Produce",
  protein: "🥩 Protein",
  dairy: "🥛 Dairy",
  grains: "🌾 Grains & Cereals",
  spices: "🌶️ Spices & Seasoning",
  oils: "🫒 Oils & Fats",
  legumes: "🫘 Legumes & Lentils",
  nuts_seeds: "🥜 Nuts & Seeds",
  condiments: "🫙 Condiments & Sauces",
  frozen: "🧊 Frozen",
  other: "📦 Other",
};

const CATEGORY_ORDER = [
  "produce",
  "protein",
  "dairy",
  "grains",
  "legumes",
  "spices",
  "oils",
  "nuts_seeds",
  "condiments",
  "frozen",
  "other",
];

export function getCategoryLabel(category: string): string {
  return CATEGORY_LABELS[category] ?? "📦 Other";
}

export function getCategoryOrder(): string[] {
  return CATEGORY_ORDER;
}

/** Format quantity + unit for display (e.g., "250g", "1.5 kg", "3 pieces") */
export function formatQuantity(
  quantity: number | null,
  unit: string | null
): string {
  if (quantity == null) return "";
  const q = Math.round(quantity * 10) / 10;
  if (!unit) return `${q}`;
  // No space for g/kg/ml/l, space for everything else
  const noSpace = ["g", "kg", "ml", "l"].includes(unit.toLowerCase());
  return noSpace ? `${q}${unit}` : `${q} ${unit}`;
}
