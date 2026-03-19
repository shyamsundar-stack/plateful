import { createClient } from "@/lib/supabase/client";
import type {
  WeekPlan,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  HouseholdMember,
  Recipe,
} from "@/lib/types/database";

// ──────────────────────────────────────────
// Utilities
// ──────────────────────────────────────────

/** Format a Date to YYYY-MM-DD in local timezone (avoids UTC shift from toISOString) */
function toLocalDateString(d: Date): string {
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

/** Get the Monday (ISO date string) of the week containing the given date */
export function getMonday(date: Date = new Date()): string {
  const d = new Date(date);
  const day = d.getDay(); // 0=Sun, 1=Mon, ..., 6=Sat
  const diff = day === 0 ? -6 : 1 - day;
  d.setDate(d.getDate() + diff);
  return toLocalDateString(d);
}

/** Shift a Monday date string by N weeks */
export function shiftWeek(monday: string, weeks: number): string {
  const d = new Date(monday + "T00:00:00");
  d.setDate(d.getDate() + weeks * 7);
  return toLocalDateString(d);
}

/** Format a week range: "Mar 17-23, 2026" or "Mar 30 – Apr 5, 2026" */
export function formatWeekRange(monday: string): string {
  const start = new Date(monday + "T00:00:00");
  const end = new Date(start);
  end.setDate(start.getDate() + 6);

  const startMonth = start.toLocaleString("en-US", { month: "short" });
  const endMonth = end.toLocaleString("en-US", { month: "short" });
  const year = end.getFullYear();

  if (startMonth === endMonth) {
    return `${startMonth} ${start.getDate()}–${end.getDate()}, ${year}`;
  }
  return `${startMonth} ${start.getDate()} – ${endMonth} ${end.getDate()}, ${year}`;
}

// ──────────────────────────────────────────
// READ operations
// ──────────────────────────────────────────

/** Fetch the week plan for a given Monday, or null if none exists */
export async function fetchWeekPlan(
  startDate: string
): Promise<WeekPlan | null> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("week_plans")
    .select("*")
    .eq("start_date", startDate)
    .eq("is_archived", false)
    .maybeSingle();

  if (error) throw new Error(error.message);
  return data as WeekPlan | null;
}

/** Fetch all meal slots for a week plan, joined with recipe info + multi-dish data. Excludes snacks. */
export async function fetchWeekSlots(
  weekPlanId: string
): Promise<MealSlotWithDishes[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("meal_slots")
    .select("*, recipes(title, cuisine, total_time_min, is_vegetarian), meal_slot_dishes(*, recipes(title, cuisine, total_time_min, is_vegetarian))")
    .eq("week_plan_id", weekPlanId)
    .in("meal_type", ["breakfast", "lunch", "dinner"])
    .order("slot_date")
    .order("meal_type");

  if (error) throw new Error(error.message);
  return (data ?? []) as MealSlotWithDishes[];
}

/** Fetch all participants for all slots in a week plan, joined with member name */
export async function fetchSlotParticipants(
  slotIds: string[]
): Promise<MealSlotParticipantWithMember[]> {
  if (slotIds.length === 0) return [];
  const supabase = createClient();
  const { data, error } = await supabase
    .from("meal_slot_participants")
    .select("*, household_members(name)")
    .in("meal_slot_id", slotIds);

  if (error) throw new Error(error.message);
  return (data ?? []) as MealSlotParticipantWithMember[];
}

/** Fetch all non-archived household members */
export async function fetchHouseholdMembers(): Promise<HouseholdMember[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("household_members")
    .select("*")
    .eq("is_archived", false)
    .order("name");

  if (error) throw new Error(error.message);
  return (data ?? []) as HouseholdMember[];
}

/** Fetch all active, non-archived recipes for the recipe picker */
export async function fetchActiveRecipes(): Promise<Recipe[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("recipes")
    .select("*")
    .eq("status", "active")
    .eq("is_archived", false)
    .order("title");

  if (error) throw new Error(error.message);
  return (data ?? []) as Recipe[];
}

// ──────────────────────────────────────────
// WRITE operations
// ──────────────────────────────────────────

/** Create a new week plan and generate all 28 meal slots + participants.
 *  If the previous week has locked slots, copy them forward automatically. */
export async function createWeekPlan(
  householdId: string,
  startDate: string
): Promise<WeekPlan> {
  const supabase = createClient();

  // 1. Insert the week plan
  const { data: plan, error: planError } = await supabase
    .from("week_plans")
    .insert({ household_id: householdId, start_date: startDate })
    .select()
    .single();

  if (planError) throw new Error(planError.message);

  // 2. Call RPC to create 28 slots + auto-populate participants
  const { error: rpcError } = await supabase.rpc("create_week_plan_slots", {
    p_week_plan_id: plan.id,
  });

  if (rpcError) throw new Error(rpcError.message);

  // 3. Copy locked slots from previous week (if any)
  const prevMonday = shiftWeek(startDate, -1);
  const { data: prevPlan } = await supabase
    .from("week_plans")
    .select("id")
    .eq("start_date", prevMonday)
    .eq("is_archived", false)
    .maybeSingle();

  if (prevPlan) {
    const { error: copyError } = await supabase.rpc(
      "copy_locked_slots_to_week",
      { p_source_plan_id: prevPlan.id, p_target_plan_id: plan.id }
    );
    // Non-fatal: if RPC doesn't exist yet or fails, plan still works
    if (copyError) {
      console.warn("Could not copy locked slots:", copyError.message);
    }
  }

  return plan as WeekPlan;
}

/** Update a meal slot (recipe assignment, mode change, etc.) */
export async function updateMealSlot(
  slotId: string,
  updates: {
    recipe_id?: string | null;
    meal_mode?: string;
    leftover_source_id?: string | null;
  }
): Promise<void> {
  const supabase = createClient();

  // Enforce CHECK constraints: clear fields based on mode
  const data: Record<string, unknown> = { ...updates };
  if (updates.meal_mode === "eat_outside" || updates.meal_mode === "skip") {
    data.recipe_id = null;
    data.leftover_source_id = null;
  }
  if (updates.meal_mode === "cook") {
    data.leftover_source_id = null;
  }
  if (updates.meal_mode === "leftover") {
    data.recipe_id = null;
  }

  const { error } = await supabase
    .from("meal_slots")
    .update(data)
    .eq("id", slotId);

  if (error) throw new Error(error.message);
}

/** Toggle a slot's is_locked flag (for recurring meals) */
export async function toggleSlotLock(
  slotId: string,
  isLocked: boolean
): Promise<void> {
  const supabase = createClient();
  const { error } = await supabase
    .from("meal_slots")
    .update({ is_locked: isLocked })
    .eq("id", slotId);

  if (error) throw new Error(error.message);
}

/** Toggle a participant's is_participating flag */
export async function updateSlotParticipant(
  participantId: string,
  isParticipating: boolean
): Promise<void> {
  const supabase = createClient();
  const { error } = await supabase
    .from("meal_slot_participants")
    .update({ is_participating: isParticipating })
    .eq("id", participantId);

  if (error) throw new Error(error.message);
}

// ──────────────────────────────────────────
// Multi-dish operations (Phase 6)
// ──────────────────────────────────────────

/**
 * Set all dishes for a meal slot (replaces any existing dishes).
 * Also dual-writes to meal_slots.recipe_id (set to the 'main' dish) for backward compat.
 */
export async function setSlotDishes(
  slotId: string,
  dishes: Array<{
    recipeId: string;
    dishRole: "main" | "staple" | "side" | "accompaniment";
    portionFactor?: number;
  }>
): Promise<void> {
  const supabase = createClient();

  // 1. Delete existing junction rows for this slot
  const { error: deleteError } = await supabase
    .from("meal_slot_dishes")
    .delete()
    .eq("meal_slot_id", slotId);

  if (deleteError) throw new Error(deleteError.message);

  // 2. Insert new dishes
  if (dishes.length > 0) {
    const rows = dishes.map((d, i) => ({
      meal_slot_id: slotId,
      recipe_id: d.recipeId,
      dish_role: d.dishRole,
      portion_factor: d.portionFactor ?? 1.0,
      sort_order: i,
    }));

    const { error: insertError } = await supabase
      .from("meal_slot_dishes")
      .insert(rows);

    if (insertError) throw new Error(insertError.message);

    // 3. Dual-write: set meal_slots.recipe_id to the 'main' dish (or first dish)
    const mainDish = dishes.find((d) => d.dishRole === "main") ?? dishes[0];
    const { error: updateError } = await supabase
      .from("meal_slots")
      .update({ recipe_id: mainDish.recipeId, meal_mode: "cook" })
      .eq("id", slotId);

    if (updateError) throw new Error(updateError.message);
  }
}

/**
 * Remove a single dish from a multi-dish slot.
 * If it was the last dish, clears the slot's recipe_id too.
 */
export async function removeSlotDish(
  slotId: string,
  dishId: string
): Promise<void> {
  const supabase = createClient();

  // Delete the dish
  const { error: deleteError } = await supabase
    .from("meal_slot_dishes")
    .delete()
    .eq("id", dishId);

  if (deleteError) throw new Error(deleteError.message);

  // Check remaining dishes
  const { data: remaining, error: fetchError } = await supabase
    .from("meal_slot_dishes")
    .select("id, recipe_id, dish_role")
    .eq("meal_slot_id", slotId)
    .order("sort_order");

  if (fetchError) throw new Error(fetchError.message);

  if (!remaining || remaining.length === 0) {
    // No dishes left — clear the slot's recipe_id
    const { error: clearError } = await supabase
      .from("meal_slots")
      .update({ recipe_id: null })
      .eq("id", slotId);

    if (clearError) throw new Error(clearError.message);
  } else {
    // Update recipe_id to new main dish (or first remaining)
    const main = remaining.find((d) => d.dish_role === "main") ?? remaining[0];
    const { error: updateError } = await supabase
      .from("meal_slots")
      .update({ recipe_id: main.recipe_id })
      .eq("id", slotId);

    if (updateError) throw new Error(updateError.message);
  }
}

/**
 * Apply a thali template to a meal slot.
 * Caller must resolve template dishes to actual recipe IDs first.
 */
export async function applyThaliTemplate(
  slotId: string,
  resolvedDishes: Array<{
    recipeId: string;
    dishRole: "main" | "staple" | "side" | "accompaniment";
    portionFactor?: number;
  }>
): Promise<void> {
  // Uses the same logic as setSlotDishes — template is just a preset
  await setSlotDishes(slotId, resolvedDishes);
}
