/**
 * Variety detection — pure functions, no Supabase imports.
 *
 * Detects repeated recipes in the week plan to help users
 * maintain variety in their meal planning.
 *
 * Multi-dish aware: only 'main' dishes trigger variety warnings.
 * Repeated staples (rice/roti every day) are normal in Indian cuisine.
 */

import type { MealSlotWithRecipe, MealSlotWithDishes } from "@/lib/types/database";
import { getSlotMainRecipeIds } from "@/lib/meal-utils";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/** Visual warning threshold: show badge if same recipe appears within this many days */
const DEFAULT_THRESHOLD_DAYS = 3;

// ---------------------------------------------------------------------------
// Core: detect repeated recipes
// ---------------------------------------------------------------------------

/**
 * Detect slot IDs where a main dish recipe is repeated within the threshold.
 * Returns a Set of slot IDs that should show a "repeated" visual indicator.
 *
 * Multi-dish aware: only 'main' role dishes trigger variety warnings.
 * Staples (rice, roti) eaten daily do NOT trigger warnings.
 *
 * A recipe is considered "repeated" if the same recipe_id appears as a main
 * dish in another slot within `thresholdDays` days. Both slots get flagged.
 * Leftover slots count as the source recipe for this check.
 */
export function detectRepeatedRecipes(
  slots: (MealSlotWithRecipe | MealSlotWithDishes)[],
  thresholdDays: number = DEFAULT_THRESHOLD_DAYS
): Set<string> {
  const repeatedSlotIds = new Set<string>();

  // Build a list of (slotId, recipeId, date) — only main dishes
  type SlotInfo = { slotId: string; recipeId: string; date: string };
  const slotInfos: SlotInfo[] = [];

  for (const slot of slots) {
    let mainRecipeIds: string[] = [];

    if (slot.meal_mode === "cook") {
      mainRecipeIds = getSlotMainRecipeIds(slot);
    } else if (slot.meal_mode === "leftover" && slot.leftover_source_id) {
      // Find the source slot's main recipe(s)
      const source = slots.find((s) => s.id === slot.leftover_source_id);
      if (source) {
        mainRecipeIds = getSlotMainRecipeIds(source);
      }
    }

    for (const recipeId of mainRecipeIds) {
      slotInfos.push({ slotId: slot.id, recipeId, date: slot.slot_date });
    }
  }

  // Compare all pairs to find repeats within threshold
  for (let i = 0; i < slotInfos.length; i++) {
    for (let j = i + 1; j < slotInfos.length; j++) {
      const a = slotInfos[i];
      const b = slotInfos[j];

      if (a.recipeId !== b.recipeId) continue;

      const daysDiff = Math.abs(daysBetween(a.date, b.date));
      if (daysDiff <= thresholdDays && daysDiff > 0) {
        repeatedSlotIds.add(a.slotId);
        repeatedSlotIds.add(b.slotId);
      }
    }
  }

  return repeatedSlotIds;
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

function daysBetween(date1: string, date2: string): number {
  const d1 = new Date(date1 + "T00:00:00");
  const d2 = new Date(date2 + "T00:00:00");
  return Math.round((d1.getTime() - d2.getTime()) / (24 * 60 * 60 * 1000));
}
