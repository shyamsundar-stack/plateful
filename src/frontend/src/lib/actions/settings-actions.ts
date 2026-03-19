"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

// ──────────────────────────────────────────
// Fetch household + members
// ──────────────────────────────────────────

export async function fetchHouseholdWithMembers() {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  // Get household
  const { data: household, error: hhError } = await supabase
    .from("households")
    .select("*")
    .eq("created_by", user.id)
    .eq("is_archived", false)
    .single();

  if (hhError || !household) throw new Error("Household not found");

  // Get members
  const { data: members, error: memError } = await supabase
    .from("household_members")
    .select("*")
    .eq("household_id", household.id)
    .eq("is_archived", false)
    .order("created_at");

  if (memError) throw new Error("Failed to load members");

  return { household, members: members ?? [] };
}

// ──────────────────────────────────────────
// Update household name
// ──────────────────────────────────────────

export async function updateHouseholdName(householdId: string, name: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("households")
    .update({ name: name.trim() })
    .eq("id", householdId);

  if (error) throw new Error("Failed to update household name");
  revalidatePath("/settings");
}

// ──────────────────────────────────────────
// Update member profile
// ──────────────────────────────────────────

export async function updateMemberProfile(
  memberId: string,
  data: {
    name?: string;
    age?: number | null;
    height_cm?: number | null;
    weight_kg?: number | null;
    biological_sex?: "male" | "female" | "other" | null;
    activity_level?: string | null;
    goal?: string | null;
    dietary_notes?: string | null;
    pregnancy_trimester?: number;
    dietary_mode?: "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan";
  }
) {
  const supabase = await createClient();

  // Validate
  if (data.name !== undefined && !data.name.trim()) {
    throw new Error("Name cannot be empty");
  }
  if (data.age !== undefined && data.age !== null && (data.age < 1 || data.age > 120)) {
    throw new Error("Age must be between 1 and 120");
  }
  if (data.height_cm !== undefined && data.height_cm !== null && (data.height_cm < 30 || data.height_cm > 300)) {
    throw new Error("Height must be between 30 and 300 cm");
  }
  if (data.weight_kg !== undefined && data.weight_kg !== null && (data.weight_kg < 5 || data.weight_kg > 500)) {
    throw new Error("Weight must be between 5 and 500 kg");
  }
  if (data.pregnancy_trimester !== undefined && (data.pregnancy_trimester < 0 || data.pregnancy_trimester > 3)) {
    throw new Error("Pregnancy trimester must be 0-3");
  }

  const { error } = await supabase
    .from("household_members")
    .update({
      ...data,
      name: data.name?.trim(),
      updated_at: new Date().toISOString(),
    })
    .eq("id", memberId);

  if (error) throw new Error("Failed to update member");
  revalidatePath("/settings");
  revalidatePath("/nutrition");
  revalidatePath("/planner");
}

// ──────────────────────────────────────────
// Add new member
// ──────────────────────────────────────────

export async function addHouseholdMember(
  householdId: string,
  name: string
) {
  const supabase = await createClient();

  if (!name.trim()) throw new Error("Name cannot be empty");

  const { error } = await supabase.from("household_members").insert({
    household_id: householdId,
    name: name.trim(),
    is_app_user: false,
  });

  if (error) throw new Error("Failed to add member");
  revalidatePath("/settings");
}

// ──────────────────────────────────────────
// Archive member
// ──────────────────────────────────────────

export async function archiveHouseholdMember(memberId: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("household_members")
    .update({ is_archived: true, updated_at: new Date().toISOString() })
    .eq("id", memberId);

  if (error) throw new Error("Failed to archive member");
  revalidatePath("/settings");
}

// ──────────────────────────────────────────
// Dietary Preferences
// ──────────────────────────────────────────

export async function fetchDietaryPrefs(memberId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("member_dietary_prefs")
    .select("*, ingredients(name)")
    .eq("member_id", memberId)
    .order("created_at");

  if (error) throw new Error("Failed to load dietary preferences");
  return data ?? [];
}

export async function addDietaryPref(
  memberId: string,
  data: {
    pref_type: "allergy" | "hard_no" | "dislike" | "prefer";
    ingredient_id?: string | null;
    ingredient_name?: string | null;
    notes?: string | null;
  }
) {
  const supabase = await createClient();

  if (!data.ingredient_id && !data.ingredient_name?.trim()) {
    throw new Error("Must specify an ingredient");
  }

  const { error } = await supabase.from("member_dietary_prefs").insert({
    member_id: memberId,
    pref_type: data.pref_type,
    ingredient_id: data.ingredient_id || null,
    ingredient_name: data.ingredient_name?.trim() || null,
    notes: data.notes?.trim() || null,
  });

  if (error) throw new Error("Failed to add dietary preference");
  revalidatePath("/settings");
}

export async function deleteDietaryPref(prefId: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("member_dietary_prefs")
    .delete()
    .eq("id", prefId);

  if (error) throw new Error("Failed to delete dietary preference");
  revalidatePath("/settings");
}

// ──────────────────────────────────────────
// Participation Defaults
// ──────────────────────────────────────────

export async function fetchParticipationDefaults(memberId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("member_participation_defaults")
    .select("*")
    .eq("member_id", memberId)
    .order("meal_type")
    .order("day_of_week");

  if (error) throw new Error("Failed to load participation defaults");
  return data ?? [];
}

export async function upsertParticipationDefault(
  memberId: string,
  mealType: string,
  isParticipating: boolean,
  servingFactor: number = 1.0
) {
  const supabase = await createClient();

  // Upsert for all days (day_of_week = null)
  const { error } = await supabase
    .from("member_participation_defaults")
    .upsert(
      {
        member_id: memberId,
        meal_type: mealType,
        day_of_week: null,
        is_participating: isParticipating,
        serving_factor: servingFactor,
      },
      { onConflict: "member_id,meal_type,day_of_week" }
    );

  if (error) throw new Error("Failed to update participation default");
  revalidatePath("/settings");
  revalidatePath("/planner");
}
