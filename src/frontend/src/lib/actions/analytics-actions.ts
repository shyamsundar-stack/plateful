"use server";

import { createClient } from "@/lib/supabase/server";

/**
 * Log an analytics event — fire-and-forget, never throws.
 *
 * Supported event types:
 * - recipe_created, recipe_imported
 * - week_plan_created, meal_assigned, meal_removed, auto_fill_week
 * - grocery_generated, grocery_shared, grocery_item_checked
 */
export async function trackEvent(
  eventType: string,
  eventData?: Record<string, unknown>
): Promise<void> {
  try {
    const supabase = await createClient();
    const { data: householdId } = await supabase.rpc("get_my_household_id");
    if (!householdId) return;

    await supabase.from("analytics_events").insert({
      household_id: householdId,
      event_type: eventType,
      event_data: eventData ?? {},
    });
  } catch {
    // Silently ignore — analytics should never block the user
  }
}
