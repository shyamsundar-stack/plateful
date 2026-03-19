"use server";

import { createClient } from "@/lib/supabase/server";
import type { RecipePreference, MemberDietaryPref } from "@/lib/types/database";

// ──────────────────────────────────────────
// Fetch dietary preferences for all household members
// ──────────────────────────────────────────

export async function fetchHouseholdDietaryPrefs(): Promise<MemberDietaryPref[]> {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return [];

  // RLS auto-filters by household
  const { data, error } = await supabase
    .from("member_dietary_prefs")
    .select("*")
    .order("created_at");

  if (error) {
    console.error("Failed to fetch dietary prefs:", error);
    return [];
  }

  return (data ?? []) as MemberDietaryPref[];
}

// ──────────────────────────────────────────
// Fetch recipe preferences (for scoring)
// ──────────────────────────────────────────

export async function fetchRecipePreferences(): Promise<RecipePreference[]> {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return [];

  // Get preferences from last 8 weeks
  const cutoff = new Date();
  cutoff.setDate(cutoff.getDate() - 56); // 8 weeks

  const { data, error } = await supabase
    .from("recipe_preferences")
    .select("*")
    .gte("created_at", cutoff.toISOString())
    .order("created_at", { ascending: false });

  if (error) {
    console.error("Failed to fetch recipe preferences:", error);
    return [];
  }

  return (data ?? []) as RecipePreference[];
}

// ──────────────────────────────────────────
// Log a recipe preference (accept/reject)
// ──────────────────────────────────────────

export async function logRecipePreference(
  recipeId: string,
  memberIds: string[],
  action: "accept" | "reject",
  mealType?: string,
  weekStart?: string
) {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  // Get household_id
  const { data: hhId } = await supabase.rpc("get_my_household_id");
  if (!hhId) throw new Error("No household found");

  // Insert one preference record per participating member
  const rows = memberIds.map((memberId) => ({
    household_id: hhId,
    member_id: memberId,
    recipe_id: recipeId,
    action,
    meal_type: mealType ?? null,
    week_start: weekStart ?? null,
  }));

  const { error } = await supabase.from("recipe_preferences").insert(rows);

  if (error) {
    console.error("Failed to log recipe preference:", error);
    // Non-critical — don't throw, just log
  }
}
