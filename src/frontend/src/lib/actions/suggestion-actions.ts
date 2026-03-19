"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { trackEvent } from "@/lib/actions/analytics-actions";
import { generateWeekSuggestions } from "@/lib/suggestions";
import type {
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  HouseholdMember,
  Recipe,
  RecipePreference,
  MemberDietaryPref,
  RecipeIngredientWithDetails,
  DietaryConflictMap,
  MealRule,
  FestivalCalendarEntry,
} from "@/lib/types/database";
import { computeDietaryConflictMap } from "@/lib/dietary";

// ---------------------------------------------------------------------------
// Auto-fill empty cook slots with smart suggestions
// ---------------------------------------------------------------------------

export async function autoFillWeek(weekPlanId: string) {
  const supabase = await createClient();

  // Get household_id
  const { data: hid } = await supabase.rpc("get_my_household_id");
  if (!hid) throw new Error("Not authenticated");

  // 1. Fetch all meal slots for this week (with multi-dish data)
  const { data: slotData } = await supabase
    .from("meal_slots")
    .select("*, recipes(title, cuisine, total_time_min, is_vegetarian), meal_slot_dishes(*, recipes(title, cuisine, total_time_min, is_vegetarian))")
    .eq("week_plan_id", weekPlanId)
    .in("meal_type", ["breakfast", "lunch", "dinner"])
    .order("slot_date");

  const slots = (slotData ?? []) as MealSlotWithDishes[];
  const slotIds = slots.map((s) => s.id);

  // 2. Fetch participants
  const { data: partData } = await supabase
    .from("meal_slot_participants")
    .select("*, household_members(name)")
    .in("meal_slot_id", slotIds);

  const participants = (partData ?? []) as MealSlotParticipantWithMember[];
  const participantsBySlot = new Map<string, MealSlotParticipantWithMember[]>();
  for (const p of participants) {
    const existing = participantsBySlot.get(p.meal_slot_id) ?? [];
    existing.push(p);
    participantsBySlot.set(p.meal_slot_id, existing);
  }

  // 3. Fetch all active recipes
  const { data: recipeData } = await supabase
    .from("recipes")
    .select("*")
    .eq("household_id", hid)
    .eq("status", "active")
    .eq("is_archived", false);

  const recipes = (recipeData ?? []) as Recipe[];
  if (recipes.length === 0) {
    throw new Error("No active recipes found. Add some recipes first!");
  }

  // 4. Fetch household members
  const { data: memberData } = await supabase
    .from("household_members")
    .select("*")
    .eq("household_id", hid)
    .eq("is_archived", false);

  const members = (memberData ?? []) as HouseholdMember[];

  // 5. Fetch dietary preferences
  const { data: prefData } = await supabase
    .from("member_dietary_prefs")
    .select("*")
    .in(
      "member_id",
      members.map((m) => m.id)
    );

  const dietaryPrefs = (prefData ?? []) as MemberDietaryPref[];

  // 6. Fetch recipe preferences (for ranking)
  const { data: recipePrefData } = await supabase
    .from("recipe_preferences")
    .select("*")
    .eq("household_id", hid);

  const recipePreferences = (recipePrefData ?? []) as RecipePreference[];

  // 7. Fetch recipe ingredients for dietary conflict checking
  const recipeIds = recipes.map((r) => r.id);
  const { data: riData } = await supabase
    .from("recipe_ingredients")
    .select("*, ingredients(*)")
    .in("recipe_id", recipeIds);

  const recipeIngredients = (riData ?? []) as RecipeIngredientWithDetails[];
  const ingredientsByRecipe = new Map<string, RecipeIngredientWithDetails[]>();
  for (const ri of recipeIngredients) {
    const existing = ingredientsByRecipe.get(ri.recipe_id) ?? [];
    existing.push(ri);
    ingredientsByRecipe.set(ri.recipe_id, existing);
  }

  // 8. Compute dietary conflict map
  const dietaryConflictMap: DietaryConflictMap = computeDietaryConflictMap(
    ingredientsByRecipe,
    members,
    dietaryPrefs
  );

  // 9. Fetch meal rules and festival calendar (Phase 5)
  const [rulesResult, festivalsResult] = await Promise.all([
    supabase
      .from("meal_rules")
      .select("*")
      .eq("household_id", hid)
      .eq("is_active", true)
      .order("priority"),
    supabase
      .from("festival_calendar")
      .select("*")
      .order("start_date"),
  ]);

  const mealRules = (rulesResult.data ?? []) as MealRule[];
  const festivals = (festivalsResult.data ?? []) as FestivalCalendarEntry[];

  // 10. Run suggestion engine (now with rules + festivals)
  const suggestions = generateWeekSuggestions({
    slots,
    recipes,
    preferences: recipePreferences,
    participantsBySlot,
    members,
    dietaryPrefs,
    ingredientsByRecipe,
    dietaryConflictMap,
    mealRules,
    festivals,
  });

  if (suggestions.size === 0) {
    throw new Error(
      "No suggestions could be generated. You may need more active recipes."
    );
  }

  // 10. Batch update meal slots with suggestions + dual-write to junction table
  let filledCount = 0;
  for (const [slotId, recipeId] of Array.from(suggestions.entries())) {
    // Update legacy recipe_id on meal_slots
    const { error } = await supabase
      .from("meal_slots")
      .update({ recipe_id: recipeId, meal_mode: "cook" })
      .eq("id", slotId);

    if (!error) {
      filledCount++;
      // Also write to junction table (dual-write for Phase 6 compat)
      await supabase
        .from("meal_slot_dishes")
        .delete()
        .eq("meal_slot_id", slotId);

      await supabase
        .from("meal_slot_dishes")
        .insert({
          meal_slot_id: slotId,
          recipe_id: recipeId,
          dish_role: "main",
          portion_factor: 1.0,
          sort_order: 0,
        });
    }
  }

  revalidatePath("/planner");
  trackEvent("auto_fill_week", {
    week_plan_id: weekPlanId,
    filled_count: filledCount,
    total_empty: suggestions.size,
  }).catch(() => {});

  return { filledCount };
}
