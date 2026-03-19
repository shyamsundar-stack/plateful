// =============================================================================
// Nutrition Calculation Engine — Session 10
// =============================================================================
// ALL pure functions. No Supabase imports. No side effects.
// These functions compute nutrition from ingredient-level data.
// =============================================================================

import type {
  HouseholdMember,
  MealSlotWithRecipe,
  MealSlotParticipantWithMember,
  RecipeIngredientWithDetails,
  UnitConversion,
  RecipeNutrition,
  DayNutrition,
  WeekNutrition,
  MemberTargets,
  ImbalanceFlag,
  PregnancyAlert,
  SwapSuggestion,
  SlotMemberNutrition,
  Recipe,
  MealSlotWithDishes,
} from "@/lib/types/database";
import { getSlotDishes } from "@/lib/meal-utils";

// ---------------------------------------------------------------------------
// Unit Conversion
// ---------------------------------------------------------------------------

/** Convert a quantity + unit to grams using the conversion table */
export function convertToGrams(
  quantity: number | null,
  unit: string | null,
  conversions: Map<string, number>
): number | null {
  if (quantity == null || quantity <= 0) return null;
  if (!unit) return null;

  const u = unit.toLowerCase().trim();

  // Already in grams
  if (u === "g" || u === "gram" || u === "grams") return quantity;

  // Check conversion table
  const factor = conversions.get(u);
  if (factor != null) return quantity * factor;

  // Unknown unit — cannot convert
  return null;
}

/** Build a Map from unit_name → grams_per_unit */
export function buildConversionMap(
  conversions: UnitConversion[]
): Map<string, number> {
  const map = new Map<string, number>();
  for (const c of conversions) {
    map.set(c.unit_name.toLowerCase(), c.grams_per_unit);
  }
  return map;
}

// ---------------------------------------------------------------------------
// Recipe Nutrition
// ---------------------------------------------------------------------------

/** Calculate nutrition for a recipe from its ingredients (returns per-serving values) */
export function calculateRecipeNutrition(
  recipeId: string,
  servings: number,
  ingredients: RecipeIngredientWithDetails[],
  conversions: Map<string, number>
): RecipeNutrition {
  let totalCalories = 0;
  let totalProtein = 0;
  let totalCarbs = 0;
  let totalFat = 0;
  let trackedCount = 0;
  const totalCount = ingredients.length;

  for (const ri of ingredients) {
    const ing = ri.ingredients;
    if (!ing) continue;

    // Convert to grams
    const grams = convertToGrams(ri.quantity, ri.unit, conversions);
    if (grams == null) continue;

    // Check nutrition data exists
    if (
      ing.calories_per_100g == null &&
      ing.protein_per_100g == null &&
      ing.carbs_per_100g == null &&
      ing.fat_per_100g == null
    ) {
      continue;
    }

    trackedCount++;
    totalCalories += ((ing.calories_per_100g ?? 0) / 100) * grams;
    totalProtein += ((ing.protein_per_100g ?? 0) / 100) * grams;
    totalCarbs += ((ing.carbs_per_100g ?? 0) / 100) * grams;
    totalFat += ((ing.fat_per_100g ?? 0) / 100) * grams;
  }

  const effectiveServings = servings > 0 ? servings : 1;

  return {
    recipeId,
    caloriesPerServing: Math.round(totalCalories / effectiveServings),
    proteinPerServing: Math.round((totalProtein / effectiveServings) * 10) / 10,
    carbsPerServing: Math.round((totalCarbs / effectiveServings) * 10) / 10,
    fatPerServing: Math.round((totalFat / effectiveServings) * 10) / 10,
    confidence: totalCount > 0 ? trackedCount / totalCount : 0,
    servings: effectiveServings,
  };
}

// ---------------------------------------------------------------------------
// TDEE Calculation
// ---------------------------------------------------------------------------

const ACTIVITY_MULTIPLIERS: Record<string, number> = {
  sedentary: 1.2,
  light: 1.375,
  moderate: 1.55,
  active: 1.725,
  very_active: 1.9,
};

/** Calculate TDEE using Mifflin-St Jeor. Returns null if profile is incomplete. */
export function calculateTDEE(member: HouseholdMember): number | null {
  if (
    member.weight_kg == null ||
    member.height_cm == null ||
    member.age == null
  ) {
    return null;
  }

  const w = member.weight_kg;
  const h = member.height_cm;
  const a = member.age;

  let bmr: number;
  if (member.biological_sex === "male") {
    bmr = 10 * w + 6.25 * h - 5 * a + 5;
  } else if (member.biological_sex === "female") {
    bmr = 10 * w + 6.25 * h - 5 * a - 161;
  } else {
    // 'other' or null — use average of male + female formulas
    const bmrMale = 10 * w + 6.25 * h - 5 * a + 5;
    const bmrFemale = 10 * w + 6.25 * h - 5 * a - 161;
    bmr = (bmrMale + bmrFemale) / 2;
  }

  const multiplier =
    ACTIVITY_MULTIPLIERS[member.activity_level ?? "moderate"] ?? 1.55;
  return Math.round(bmr * multiplier);
}

/** Calculate macro targets from TDEE */
export function calculateMemberTargets(
  member: HouseholdMember
): MemberTargets {
  const tdee = calculateTDEE(member);
  if (tdee == null) {
    return {
      memberId: member.id,
      memberName: member.name,
      tdee: null,
      proteinTarget: null,
      carbsTarget: null,
      fatTarget: null,
    };
  }

  return {
    memberId: member.id,
    memberName: member.name,
    tdee,
    proteinTarget: Math.round((tdee * 0.3) / 4), // 30% from protein, 4 kcal/g
    carbsTarget: Math.round((tdee * 0.4) / 4), // 40% from carbs, 4 kcal/g
    fatTarget: Math.round((tdee * 0.3) / 9), // 30% from fat, 9 kcal/g
  };
}

// ---------------------------------------------------------------------------
// Imbalance Flags
// ---------------------------------------------------------------------------

/** Get imbalance flags for a member on a given day */
export function getImbalanceFlags(
  actual: { protein: number; carbs: number; fat: number },
  targets: MemberTargets
): ImbalanceFlag[] {
  if (
    targets.proteinTarget == null ||
    targets.carbsTarget == null ||
    targets.fatTarget == null
  ) {
    return [];
  }

  const flags: ImbalanceFlag[] = [];

  const macros: Array<{
    macro: "protein" | "carbs" | "fat";
    actual: number;
    target: number;
  }> = [
    { macro: "protein", actual: actual.protein, target: targets.proteinTarget },
    { macro: "carbs", actual: actual.carbs, target: targets.carbsTarget },
    { macro: "fat", actual: actual.fat, target: targets.fatTarget },
  ];

  for (const m of macros) {
    const ratio = m.target > 0 ? m.actual / m.target : 1;
    let level: "red" | "yellow" | "green";
    if (ratio < 0.6) level = "red";
    else if (ratio < 0.8) level = "yellow";
    else level = "green";

    flags.push({
      macro: m.macro,
      actual: Math.round(m.actual * 10) / 10,
      target: m.target,
      level,
    });
  }

  return flags;
}

// ---------------------------------------------------------------------------
// Pregnancy Safety Alerts
// ---------------------------------------------------------------------------

/** Check a slot for pregnancy-unsafe ingredients for participating pregnant members */
export function checkPregnancyAlerts(
  slot: MealSlotWithRecipe,
  participatingMembers: HouseholdMember[],
  recipeIngredients: RecipeIngredientWithDetails[]
): PregnancyAlert[] {
  // Only check cook and leftover slots (eat_outside/skip have no ingredients to check)
  if (slot.meal_mode !== "cook" && slot.meal_mode !== "leftover") {
    return [];
  }

  // Find pregnant members
  const pregnantMembers = participatingMembers.filter(
    (m) => m.pregnancy_trimester > 0
  );
  if (pregnantMembers.length === 0) return [];

  // Find unsafe ingredients in the recipe
  const unsafeIngredients = recipeIngredients.filter(
    (ri) => ri.ingredients?.is_pregnancy_unsafe === true
  );
  if (unsafeIngredients.length === 0) return [];

  // Generate alerts: one per pregnant member × unsafe ingredient
  const alerts: PregnancyAlert[] = [];
  for (const member of pregnantMembers) {
    for (const ri of unsafeIngredients) {
      alerts.push({
        memberName: member.name,
        memberId: member.id,
        trimester: member.pregnancy_trimester,
        ingredientName: ri.ingredients.name,
        warning: ri.ingredients.pregnancy_warning ?? "Potentially unsafe during pregnancy",
        slotId: slot.id,
      });
    }
  }

  return alerts;
}

/** Generate pregnancy reminder for eat_outside slots with pregnant participants */
export function getEatOutsidePregnancyReminder(
  slot: MealSlotWithRecipe,
  participatingMembers: HouseholdMember[]
): string | null {
  if (slot.meal_mode !== "eat_outside") return null;
  const pregnantMembers = participatingMembers.filter(
    (m) => m.pregnancy_trimester > 0
  );
  if (pregnantMembers.length === 0) return null;
  const names = pregnantMembers.map((m) => m.name).join(", ");
  return `${names} — eating out, check with restaurant about pregnancy-safe ingredients`;
}

// ---------------------------------------------------------------------------
// Week Nutrition Calculation
// ---------------------------------------------------------------------------

/** Calculate full week nutrition from slots, recipe nutrition, and participants.
 *  Supports multi-dish slots: sums nutrition across all dishes with portion_factor. */
export function calculateWeekNutrition(
  slots: (MealSlotWithRecipe | MealSlotWithDishes)[],
  recipeNutritionMap: Map<string, RecipeNutrition>,
  participantsBySlot: Map<string, MealSlotParticipantWithMember[]>,
  members: HouseholdMember[],
  recipeIngredientsByRecipe: Map<string, RecipeIngredientWithDetails[]>,
  allSlots: (MealSlotWithRecipe | MealSlotWithDishes)[]
): WeekNutrition {
  // Group slots by date
  const slotsByDate = new Map<string, MealSlotWithRecipe[]>();
  for (const slot of slots) {
    const existing = slotsByDate.get(slot.slot_date) ?? [];
    existing.push(slot);
    slotsByDate.set(slot.slot_date, existing);
  }

  // Build member lookup
  const memberMap = new Map<string, HouseholdMember>();
  for (const m of members) memberMap.set(m.id, m);

  // Calculate member targets
  const memberTargets = new Map<string, MemberTargets>();
  for (const m of members) {
    memberTargets.set(m.id, calculateMemberTargets(m));
  }

  const days: DayNutrition[] = [];
  let totalImbalanced = 0;
  let totalPregnancyAlerts = 0;

  // Get sorted unique dates
  const dates = Array.from(slotsByDate.keys()).sort();

  for (const date of dates) {
    const daySlots = slotsByDate.get(date) ?? [];
    let dayCalories = 0;
    let dayProtein = 0;
    let dayCarbs = 0;
    let dayFat = 0;
    let isPartial = false;
    const dayPregnancyAlerts: PregnancyAlert[] = [];

    // Per-member accumulation
    const memberNutrition = new Map<
      string,
      { calories: number; protein: number; carbs: number; fat: number; isPartial: boolean }
    >();

    for (const slot of daySlots) {
      const slotParticipants = participantsBySlot.get(slot.id) ?? [];
      const activeParticipants = slotParticipants.filter(
        (p) => p.is_participating
      );

      // Resolve recipe nutrition — supports multi-dish slots
      // For multi-dish: sum nutrition from all dishes × portion_factor
      // For single-dish: fallback to slot.recipe_id as before
      let slotNutrition: RecipeNutrition | null = null;
      const recipeIngredients: RecipeIngredientWithDetails[] = [];

      if (slot.meal_mode === "cook") {
        const dishes = getSlotDishes(slot);
        if (dishes.length > 0) {
          // Sum nutrition across all dishes in this slot
          let totalCal = 0, totalPro = 0, totalCarb = 0, totalFat = 0;
          let hasAny = false;
          for (const dish of dishes) {
            const nut = recipeNutritionMap.get(dish.recipeId);
            if (nut) {
              hasAny = true;
              totalCal += nut.caloriesPerServing * dish.portionFactor;
              totalPro += nut.proteinPerServing * dish.portionFactor;
              totalCarb += nut.carbsPerServing * dish.portionFactor;
              totalFat += nut.fatPerServing * dish.portionFactor;
            }
            // Collect ALL recipe ingredients for pregnancy checks
            const ri = recipeIngredientsByRecipe.get(dish.recipeId) ?? [];
            recipeIngredients.push(...ri);
          }
          if (hasAny) {
            slotNutrition = {
              recipeId: dishes[0].recipeId,
              caloriesPerServing: Math.round(totalCal),
              proteinPerServing: Math.round(totalPro * 10) / 10,
              carbsPerServing: Math.round(totalCarb * 10) / 10,
              fatPerServing: Math.round(totalFat * 10) / 10,
              confidence: 1,
              servings: 1,
            };
          }
        }
      } else if (slot.meal_mode === "leftover" && slot.leftover_source_id) {
        // Find source slot's recipe(s)
        const sourceSlot = allSlots.find(
          (s) => s.id === slot.leftover_source_id
        );
        if (sourceSlot) {
          const sourceDishes = getSlotDishes(sourceSlot);
          if (sourceDishes.length > 0) {
            let totalCal = 0, totalPro = 0, totalCarb = 0, totalFat = 0;
            let hasAny = false;
            for (const dish of sourceDishes) {
              const nut = recipeNutritionMap.get(dish.recipeId);
              if (nut) {
                hasAny = true;
                totalCal += nut.caloriesPerServing * dish.portionFactor;
                totalPro += nut.proteinPerServing * dish.portionFactor;
                totalCarb += nut.carbsPerServing * dish.portionFactor;
                totalFat += nut.fatPerServing * dish.portionFactor;
              }
              const ri = recipeIngredientsByRecipe.get(dish.recipeId) ?? [];
              recipeIngredients.push(...ri);
            }
            if (hasAny) {
              slotNutrition = {
                recipeId: sourceDishes[0].recipeId,
                caloriesPerServing: Math.round(totalCal),
                proteinPerServing: Math.round(totalPro * 10) / 10,
                carbsPerServing: Math.round(totalCarb * 10) / 10,
                fatPerServing: Math.round(totalFat * 10) / 10,
                confidence: 1,
                servings: 1,
              };
            }
          }
        }
      } else if (slot.meal_mode === "eat_outside") {
        if (slot.manual_calories != null) {
          // Use manual macros
          for (const p of activeParticipants) {
            const member = memberMap.get(p.member_id);
            if (!member) continue;
            const existing = memberNutrition.get(p.member_id) ?? {
              calories: 0, protein: 0, carbs: 0, fat: 0, isPartial: false,
            };
            existing.calories += slot.manual_calories ?? 0;
            existing.protein += slot.manual_protein_g ?? 0;
            existing.carbs += slot.manual_carbs_g ?? 0;
            existing.fat += slot.manual_fat_g ?? 0;
            memberNutrition.set(p.member_id, existing);

            dayCalories += slot.manual_calories ?? 0;
            dayProtein += slot.manual_protein_g ?? 0;
            dayCarbs += slot.manual_carbs_g ?? 0;
            dayFat += slot.manual_fat_g ?? 0;
          }
        } else {
          isPartial = true;
          // Mark all participants as partial for this day
          for (const p of activeParticipants) {
            const existing = memberNutrition.get(p.member_id) ?? {
              calories: 0, protein: 0, carbs: 0, fat: 0, isPartial: false,
            };
            existing.isPartial = true;
            memberNutrition.set(p.member_id, existing);
          }
        }

        // Pregnancy reminder for eat_outside — check pregnant members
        const pregnantParticipants = activeParticipants
          .map((p) => memberMap.get(p.member_id))
          .filter((m): m is HouseholdMember => m != null && m.pregnancy_trimester > 0);
        if (pregnantParticipants.length > 0) {
          for (const pm of pregnantParticipants) {
            dayPregnancyAlerts.push({
              memberName: pm.name,
              memberId: pm.id,
              trimester: pm.pregnancy_trimester,
              ingredientName: "(eating out)",
              warning: "Eating out — check with restaurant about pregnancy-safe ingredients",
              slotId: slot.id,
            });
          }
        }

        continue; // Already handled eat_outside
      }
      // skip mode: zero contribution, no further processing

      if (slot.meal_mode === "skip") continue;

      // Apply recipe nutrition to participants
      if (slotNutrition) {
        for (const p of activeParticipants) {
          const servingFactor = p.serving_factor ?? 1;
          const memberCalories = slotNutrition.caloriesPerServing * servingFactor;
          const memberProtein = slotNutrition.proteinPerServing * servingFactor;
          const memberCarbs = slotNutrition.carbsPerServing * servingFactor;
          const memberFat = slotNutrition.fatPerServing * servingFactor;

          const existing = memberNutrition.get(p.member_id) ?? {
            calories: 0, protein: 0, carbs: 0, fat: 0, isPartial: false,
          };
          existing.calories += memberCalories;
          existing.protein += memberProtein;
          existing.carbs += memberCarbs;
          existing.fat += memberFat;
          memberNutrition.set(p.member_id, existing);

          dayCalories += memberCalories;
          dayProtein += memberProtein;
          dayCarbs += memberCarbs;
          dayFat += memberFat;
        }
      }

      // Pregnancy alerts for cook/leftover slots
      if (recipeIngredients.length > 0) {
        const participatingMembers = activeParticipants
          .map((p) => memberMap.get(p.member_id))
          .filter((m): m is HouseholdMember => m != null);

        const alerts = checkPregnancyAlerts(
          slot,
          participatingMembers,
          recipeIngredients
        );
        dayPregnancyAlerts.push(...alerts);
      }
    }

    // Build per-member nutrition array
    const perMember: SlotMemberNutrition[] = [];
    for (const [memberId, nutrition] of Array.from(memberNutrition.entries())) {
      const member = memberMap.get(memberId);
      perMember.push({
        memberId,
        memberName: member?.name ?? "Unknown",
        calories: Math.round(nutrition.calories),
        protein: Math.round(nutrition.protein * 10) / 10,
        carbs: Math.round(nutrition.carbs * 10) / 10,
        fat: Math.round(nutrition.fat * 10) / 10,
        isPartial: nutrition.isPartial,
      });
    }

    // Check for imbalanced day (any member has a red flag)
    let dayImbalanced = false;
    if (!isPartial) {
      for (const mn of perMember) {
        const targets = memberTargets.get(mn.memberId);
        if (!targets) continue;
        const flags = getImbalanceFlags(
          { protein: mn.protein, carbs: mn.carbs, fat: mn.fat },
          targets
        );
        if (flags.some((f) => f.level === "red")) {
          dayImbalanced = true;
          break;
        }
      }
    }
    if (dayImbalanced) totalImbalanced++;

    totalPregnancyAlerts += dayPregnancyAlerts.length;

    days.push({
      date,
      totalCalories: Math.round(dayCalories),
      totalProtein: Math.round(dayProtein * 10) / 10,
      totalCarbs: Math.round(dayCarbs * 10) / 10,
      totalFat: Math.round(dayFat * 10) / 10,
      isPartial,
      perMember,
      pregnancyAlerts: dayPregnancyAlerts,
    });
  }

  // Week averages (only non-partial days)
  const fullDays = days.filter((d) => !d.isPartial);
  const dayCount = fullDays.length || 1;

  return {
    days,
    avgCalories: Math.round(
      fullDays.reduce((s, d) => s + d.totalCalories, 0) / dayCount
    ),
    avgProtein: Math.round(
      (fullDays.reduce((s, d) => s + d.totalProtein, 0) / dayCount) * 10
    ) / 10,
    avgCarbs: Math.round(
      (fullDays.reduce((s, d) => s + d.totalCarbs, 0) / dayCount) * 10
    ) / 10,
    avgFat: Math.round(
      (fullDays.reduce((s, d) => s + d.totalFat, 0) / dayCount) * 10
    ) / 10,
    imbalancedDayCount: totalImbalanced,
    pregnancyAlertCount: totalPregnancyAlerts,
  };
}

// ---------------------------------------------------------------------------
// Swap Suggestions
// ---------------------------------------------------------------------------

/** Find a recipe swap to fix the biggest macro deficiency on a flagged day */
export function getSwapSuggestion(
  daySlots: MealSlotWithRecipe[],
  recipeNutritionMap: Map<string, RecipeNutrition>,
  deficientMacro: "protein" | "carbs" | "fat",
  activeRecipes: Recipe[],
  allRecipeNutrition: Map<string, RecipeNutrition>
): SwapSuggestion | null {
  // 1. Find the weakest cook slot (lowest contribution of deficient macro)
  let weakestSlot: MealSlotWithRecipe | null = null;
  let weakestValue = Infinity;
  let weakestNutrition: RecipeNutrition | null = null;

  for (const slot of daySlots) {
    if (slot.meal_mode !== "cook" || !slot.recipe_id) continue;
    const nutrition = recipeNutritionMap.get(slot.recipe_id);
    if (!nutrition) continue;

    const value =
      deficientMacro === "protein"
        ? nutrition.proteinPerServing
        : deficientMacro === "carbs"
          ? nutrition.carbsPerServing
          : nutrition.fatPerServing;

    if (value < weakestValue) {
      weakestValue = value;
      weakestSlot = slot;
      weakestNutrition = nutrition;
    }
  }

  if (!weakestSlot || !weakestNutrition) return null;

  // 2. Find a better recipe (same meal_type, higher in deficient macro)
  let bestCandidate: {
    recipe: Recipe;
    nutrition: RecipeNutrition;
    delta: number;
  } | null = null;

  for (const recipe of activeRecipes) {
    if (recipe.id === weakestSlot.recipe_id) continue;

    // Check meal_type compatibility
    if (
      recipe.meal_types &&
      !recipe.meal_types.includes(weakestSlot.meal_type)
    ) {
      continue;
    }

    const nutrition = allRecipeNutrition.get(recipe.id);
    if (!nutrition || nutrition.confidence < 0.5) continue;

    const candidateValue =
      deficientMacro === "protein"
        ? nutrition.proteinPerServing
        : deficientMacro === "carbs"
          ? nutrition.carbsPerServing
          : nutrition.fatPerServing;

    const delta = candidateValue - weakestValue;
    if (delta <= 0) continue;

    if (!bestCandidate || delta > bestCandidate.delta) {
      bestCandidate = { recipe, nutrition, delta };
    }
  }

  if (!bestCandidate) return null;

  const macroUnit = deficientMacro === "protein" ? "protein" : deficientMacro;

  return {
    slotId: weakestSlot.id,
    currentRecipeTitle: weakestSlot.recipes?.title ?? "Unknown",
    suggestedRecipeId: bestCandidate.recipe.id,
    suggestedRecipeTitle: bestCandidate.recipe.title,
    macroDelta: `+${Math.round(bestCandidate.delta)}g ${macroUnit}`,
  };
}
