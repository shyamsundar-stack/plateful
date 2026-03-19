// =============================================================================
// Prep Detection Engine — Session 11
// =============================================================================
// Pure functions for auto-detecting shared prep work across a week's recipes
// and organizing manual prep components into prep blocks.
// =============================================================================

import type {
  MealSlotWithRecipe,
  RecipeIngredientWithDetails,
  UnitConversion,
  AutoPrepSuggestion,
  PrepComponentWithRecipes,
  PrepBlock,
} from "@/lib/types/database";
import { convertToGrams, buildConversionMap } from "@/lib/nutrition";
import { toDisplayUnit } from "@/lib/grocery";

// ---------------------------------------------------------------------------
// Prep type detection — guess what kind of prep an ingredient needs
// ---------------------------------------------------------------------------

const PREP_TYPE_RULES: Array<{
  categories: string[];
  prepType: AutoPrepSuggestion["prepType"];
  timePerKg: number; // estimated minutes per kg
}> = [
  {
    categories: ["vegetable", "fruit", "leafy_green"],
    prepType: "chop",
    timePerKg: 15,
  },
  {
    categories: ["herb"],
    prepType: "chop",
    timePerKg: 20,
  },
  {
    categories: ["legume", "lentil", "bean"],
    prepType: "soak",
    timePerKg: 5, // Mostly passive time, 5 min active
  },
  {
    categories: ["protein", "seafood"],
    prepType: "marinate",
    timePerKg: 10,
  },
  {
    categories: ["spice", "seasoning"],
    prepType: "grind",
    timePerKg: 10,
  },
  {
    categories: ["grain", "rice", "pasta", "noodle"],
    prepType: "cook",
    timePerKg: 5,
  },
];

function detectPrepType(category: string | null): {
  prepType: AutoPrepSuggestion["prepType"];
  timePerKg: number;
} {
  if (!category)
    return { prepType: "other", timePerKg: 10 };
  const cat = category.toLowerCase();
  for (const rule of PREP_TYPE_RULES) {
    if (rule.categories.includes(cat)) {
      return { prepType: rule.prepType, timePerKg: rule.timePerKg };
    }
  }
  return { prepType: "other", timePerKg: 10 };
}

// ---------------------------------------------------------------------------
// Auto-detect shared ingredients across the week
// ---------------------------------------------------------------------------

/**
 * Find ingredients used in 2+ cook slots this week and suggest batch prep.
 * Returns only ingredients that appear in multiple meals — no point prepping
 * something used only once.
 */
export function detectSharedPrep(
  slots: MealSlotWithRecipe[],
  recipeIngredientsByRecipe: Map<string, RecipeIngredientWithDetails[]>,
  conversions: UnitConversion[]
): AutoPrepSuggestion[] {
  const conversionMap = buildConversionMap(conversions);

  // Track: ingredient name → { totalGrams, category, sources, dates }
  const tracker = new Map<
    string,
    {
      ingredientId: string;
      name: string;
      category: string | null;
      totalGrams: number;
      recipeSources: Set<string>;
      slotDates: Set<string>;
      slotCount: number;
    }
  >();

  // Only look at cook slots with recipes
  const cookSlots = slots.filter(
    (s) => s.meal_mode === "cook" && s.recipe_id
  );

  for (const slot of cookSlots) {
    const recipeIngredients =
      recipeIngredientsByRecipe.get(slot.recipe_id!) ?? [];
    const recipeTitle = slot.recipes?.title ?? "Unknown";

    for (const ri of recipeIngredients) {
      const ing = ri.ingredients;
      if (!ing) continue;

      // Skip spices/seasonings with tiny amounts — not worth batch-prepping
      if (
        ing.category &&
        ["spice", "seasoning"].includes(ing.category.toLowerCase())
      ) {
        continue;
      }

      const key = ing.name.toLowerCase().trim();
      const grams = convertToGrams(ri.quantity, ri.unit, conversionMap);

      const existing = tracker.get(key);
      if (existing) {
        existing.totalGrams += grams ?? 0;
        existing.recipeSources.add(recipeTitle);
        existing.slotDates.add(slot.slot_date);
        existing.slotCount++;
      } else {
        tracker.set(key, {
          ingredientId: ing.id,
          name: ing.name,
          category: ing.category,
          totalGrams: grams ?? 0,
          recipeSources: new Set([recipeTitle]),
          slotDates: new Set([slot.slot_date]),
          slotCount: 1,
        });
      }
    }
  }

  // Filter: only ingredients used in 2+ slots
  const suggestions: AutoPrepSuggestion[] = [];

  for (const [, data] of Array.from(tracker.entries())) {
    if (data.slotCount < 2) continue;
    if (data.totalGrams <= 0) continue;

    const { prepType, timePerKg } = detectPrepType(data.category);
    const display = toDisplayUnit(data.totalGrams);

    // Estimate time: at least 2 min, proportional to quantity
    const estTime = Math.max(
      2,
      Math.round((data.totalGrams / 1000) * timePerKg)
    );

    suggestions.push({
      ingredientName: data.name,
      ingredientId: data.ingredientId,
      prepType,
      totalQuantityGrams: data.totalGrams,
      displayQuantity: display.quantity,
      displayUnit: display.unit,
      recipeSources: Array.from(data.recipeSources),
      slotDates: Array.from(data.slotDates).sort(),
      estTimeMin: estTime,
    });
  }

  // Sort by prep type, then by time (descending — biggest tasks first)
  suggestions.sort((a, b) => {
    if (a.prepType !== b.prepType) return a.prepType.localeCompare(b.prepType);
    return b.estTimeMin - a.estTimeMin;
  });

  return suggestions;
}

// ---------------------------------------------------------------------------
// Organize into prep blocks
// ---------------------------------------------------------------------------

const PREP_TYPE_LABELS: Record<string, string> = {
  chop: "🔪 Chopping",
  cook: "🍳 Cooking",
  marinate: "🥩 Marinating",
  grind: "⚙️ Grinding",
  soak: "💧 Soaking",
  other: "📋 Other Prep",
};

export function getPrepTypeLabel(prepType: string): string {
  return PREP_TYPE_LABELS[prepType] ?? "📋 Other Prep";
}

/**
 * Organize auto-detected suggestions and manual prep components
 * into time-grouped prep blocks.
 */
export function organizeIntoPrepBlocks(
  autoSuggestions: AutoPrepSuggestion[],
  manualComponents: PrepComponentWithRecipes[]
): PrepBlock[] {
  // Group auto suggestions by prep type
  const autoByType = new Map<string, AutoPrepSuggestion[]>();
  for (const s of autoSuggestions) {
    const existing = autoByType.get(s.prepType) ?? [];
    existing.push(s);
    autoByType.set(s.prepType, existing);
  }

  // Group manual components by prep type
  const manualByType = new Map<string, PrepComponentWithRecipes[]>();
  for (const c of manualComponents) {
    const existing = manualByType.get(c.prep_type) ?? [];
    existing.push(c);
    manualByType.set(c.prep_type, existing);
  }

  // Merge into blocks
  const allTypes = new Set([
    ...Array.from(autoByType.keys()),
    ...Array.from(manualByType.keys()),
  ]);

  const blocks: PrepBlock[] = [];

  for (const prepType of Array.from(allTypes)) {
    const autoItems = autoByType.get(prepType) ?? [];
    const manualItems = manualByType.get(prepType) ?? [];

    const autoTime = autoItems.reduce((s, i) => s + i.estTimeMin, 0);
    const manualTime = manualItems.reduce(
      (s, c) => s + (c.est_time_min ?? 10),
      0
    );

    blocks.push({
      label: getPrepTypeLabel(prepType),
      prepType,
      items: autoItems,
      manualItems,
      totalTimeMin: autoTime + manualTime,
    });
  }

  // Sort by total time (biggest first)
  blocks.sort((a, b) => b.totalTimeMin - a.totalTimeMin);

  return blocks;
}

/** Get total prep time across all blocks */
export function getTotalPrepTime(blocks: PrepBlock[]): number {
  return blocks.reduce((s, b) => s + b.totalTimeMin, 0);
}
