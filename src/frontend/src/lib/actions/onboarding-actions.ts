"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { cookies } from "next/headers";
import { trackEvent } from "@/lib/actions/analytics-actions";

// ---------------------------------------------------------------------------
// Check if the current user needs onboarding
// ---------------------------------------------------------------------------

export async function checkOnboardingStatus() {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { needsOnboarding: false, household: null, members: [] };

  // Get household
  const { data: household } = await supabase
    .from("households")
    .select("*")
    .eq("created_by", user.id)
    .eq("is_archived", false)
    .maybeSingle();

  if (!household) return { needsOnboarding: false, household: null, members: [] };

  // Get members
  const { data: members } = await supabase
    .from("household_members")
    .select("*")
    .eq("household_id", household.id)
    .eq("is_archived", false)
    .order("created_at");

  // Get recipe count
  const { count } = await supabase
    .from("recipes")
    .select("*", { count: "exact", head: true })
    .eq("household_id", household.id)
    .eq("is_archived", false);

  // Onboarding needed if household name is still "Kitchen" AND zero recipes
  const needsOnboarding =
    household.name === "Kitchen" && (count ?? 0) === 0;

  return {
    needsOnboarding,
    household,
    members: members ?? [],
  };
}

// ---------------------------------------------------------------------------
// Update household name (onboarding step 1)
// ---------------------------------------------------------------------------

export async function updateHouseholdNameOnboarding(
  householdId: string,
  name: string
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("households")
    .update({ name: name.trim() })
    .eq("id", householdId);

  if (error) throw new Error("Failed to update household name");
  revalidatePath("/settings");
}

// ---------------------------------------------------------------------------
// Update member during onboarding (step 2)
// ---------------------------------------------------------------------------

export async function updateMemberOnboarding(
  memberId: string,
  data: {
    name: string;
    age?: number | null;
    dietary_notes?: string | null;
    dietary_mode?: "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan";
  }
) {
  const supabase = await createClient();

  if (!data.name.trim()) throw new Error("Name cannot be empty");

  const { error } = await supabase
    .from("household_members")
    .update({
      name: data.name.trim(),
      age: data.age ?? null,
      dietary_notes: data.dietary_notes?.trim() || null,
      dietary_mode: data.dietary_mode ?? "non_vegetarian",
      updated_at: new Date().toISOString(),
    })
    .eq("id", memberId);

  if (error) throw new Error("Failed to update member");
}

// ---------------------------------------------------------------------------
// Add member during onboarding (step 2)
// ---------------------------------------------------------------------------

export async function addMemberOnboarding(
  householdId: string,
  data: {
    name: string;
    age?: number | null;
    dietary_notes?: string | null;
    dietary_mode?: "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan";
  }
) {
  const supabase = await createClient();

  if (!data.name.trim()) throw new Error("Name cannot be empty");

  const { data: member, error } = await supabase
    .from("household_members")
    .insert({
      household_id: householdId,
      name: data.name.trim(),
      age: data.age ?? null,
      dietary_notes: data.dietary_notes?.trim() || null,
      dietary_mode: data.dietary_mode ?? "non_vegetarian",
      is_app_user: false,
    })
    .select()
    .single();

  if (error) throw new Error("Failed to add member");
  return member;
}

// ---------------------------------------------------------------------------
// Complete onboarding — mark as done + track event
// ---------------------------------------------------------------------------

export async function completeOnboarding() {
  trackEvent("onboarding_completed").catch(() => {});

  // Set cookie so middleware skips onboarding DB queries on future page loads
  const cookieStore = await cookies();
  cookieStore.set("plateful-onboarded", "true", {
    path: "/",
    maxAge: 60 * 60 * 24 * 365, // 1 year
    httpOnly: true,
    sameSite: "lax",
  });

  revalidatePath("/");
  revalidatePath("/planner");
  revalidatePath("/recipes");
}
