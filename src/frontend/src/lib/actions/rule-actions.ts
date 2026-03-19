"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { trackEvent } from "@/lib/actions/analytics-actions";
import type { MealRule, FestivalCalendarEntry } from "@/lib/types/database";

// ---------------------------------------------------------------------------
// Fetch meal rules for the household
// ---------------------------------------------------------------------------

export async function fetchMealRules(): Promise<MealRule[]> {
  const supabase = await createClient();

  const { data: householdId } = await supabase.rpc("get_my_household_id");
  if (!householdId) throw new Error("Not authenticated");

  const { data, error } = await supabase
    .from("meal_rules")
    .select("*")
    .eq("household_id", householdId)
    .order("priority")
    .order("created_at");

  if (error) throw new Error(`Failed to fetch meal rules: ${error.message}`);
  return (data ?? []) as MealRule[];
}

// ---------------------------------------------------------------------------
// Create a new meal rule
// ---------------------------------------------------------------------------

export async function createMealRule(data: {
  rule_name: string;
  member_id?: string | null;
  condition_type: "day_of_week" | "meal_type" | "date_range" | "festival";
  condition_value: string;
  action_type: "set_dietary_mode" | "prefer_cuisine" | "exclude_ingredient" | "include_tag";
  action_value: string;
  priority?: number;
}): Promise<MealRule> {
  const supabase = await createClient();

  const { data: householdId } = await supabase.rpc("get_my_household_id");
  if (!householdId) throw new Error("Not authenticated");

  if (!data.rule_name.trim()) throw new Error("Rule name cannot be empty");
  if (!data.condition_value.trim()) throw new Error("Condition value cannot be empty");
  if (!data.action_value.trim()) throw new Error("Action value cannot be empty");

  const { data: rule, error } = await supabase
    .from("meal_rules")
    .insert({
      household_id: householdId,
      rule_name: data.rule_name.trim(),
      member_id: data.member_id || null,
      condition_type: data.condition_type,
      condition_value: data.condition_value.trim(),
      action_type: data.action_type,
      action_value: data.action_value.trim(),
      priority: data.priority ?? 10,
      is_active: true,
    })
    .select()
    .single();

  if (error || !rule) {
    throw new Error(`Failed to create rule: ${error?.message ?? "Unknown error"}`);
  }

  trackEvent("meal_rule_created", {
    rule_id: rule.id,
    condition_type: data.condition_type,
    action_type: data.action_type,
  }).catch(() => {});

  revalidatePath("/settings");
  revalidatePath("/planner");

  return rule as MealRule;
}

// ---------------------------------------------------------------------------
// Update an existing meal rule
// ---------------------------------------------------------------------------

export async function updateMealRule(
  ruleId: string,
  data: {
    rule_name?: string;
    member_id?: string | null;
    condition_type?: "day_of_week" | "meal_type" | "date_range" | "festival";
    condition_value?: string;
    action_type?: "set_dietary_mode" | "prefer_cuisine" | "exclude_ingredient" | "include_tag";
    action_value?: string;
    priority?: number;
  }
): Promise<void> {
  const supabase = await createClient();

  const updateData: Record<string, unknown> = {};
  if (data.rule_name !== undefined) updateData.rule_name = data.rule_name.trim();
  if (data.member_id !== undefined) updateData.member_id = data.member_id || null;
  if (data.condition_type !== undefined) updateData.condition_type = data.condition_type;
  if (data.condition_value !== undefined) updateData.condition_value = data.condition_value.trim();
  if (data.action_type !== undefined) updateData.action_type = data.action_type;
  if (data.action_value !== undefined) updateData.action_value = data.action_value.trim();
  if (data.priority !== undefined) updateData.priority = data.priority;

  const { error } = await supabase
    .from("meal_rules")
    .update(updateData)
    .eq("id", ruleId);

  if (error) throw new Error(`Failed to update rule: ${error.message}`);

  trackEvent("meal_rule_updated", { rule_id: ruleId }).catch(() => {});

  revalidatePath("/settings");
  revalidatePath("/planner");
}

// ---------------------------------------------------------------------------
// Toggle rule active/inactive
// ---------------------------------------------------------------------------

export async function toggleMealRule(
  ruleId: string,
  isActive: boolean
): Promise<void> {
  const supabase = await createClient();

  const { error } = await supabase
    .from("meal_rules")
    .update({ is_active: isActive })
    .eq("id", ruleId);

  if (error) throw new Error(`Failed to toggle rule: ${error.message}`);

  trackEvent("meal_rule_toggled", { rule_id: ruleId, is_active: isActive }).catch(() => {});

  revalidatePath("/settings");
  revalidatePath("/planner");
}

// ---------------------------------------------------------------------------
// Delete a meal rule
// ---------------------------------------------------------------------------

export async function deleteMealRule(ruleId: string): Promise<void> {
  const supabase = await createClient();

  const { error } = await supabase
    .from("meal_rules")
    .delete()
    .eq("id", ruleId);

  if (error) throw new Error(`Failed to delete rule: ${error.message}`);

  trackEvent("meal_rule_deleted", { rule_id: ruleId }).catch(() => {});

  revalidatePath("/settings");
  revalidatePath("/planner");
}

// ---------------------------------------------------------------------------
// Fetch festival calendar
// ---------------------------------------------------------------------------

export async function fetchFestivalCalendar(
  year?: number
): Promise<FestivalCalendarEntry[]> {
  const supabase = await createClient();

  let query = supabase
    .from("festival_calendar")
    .select("*")
    .order("start_date");

  if (year) {
    query = query.eq("year", year);
  }

  const { data, error } = await query;

  if (error) throw new Error(`Failed to fetch festival calendar: ${error.message}`);
  return (data ?? []) as FestivalCalendarEntry[];
}
