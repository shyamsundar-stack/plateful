"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { trackEvent } from "@/lib/actions/analytics-actions";
import type {
  MealSlotWithRecipe,
  MealSlotParticipantWithMember,
  RecipeIngredientWithDetails,
  UnitConversion,
} from "@/lib/types/database";
import { aggregateGroceryItems } from "@/lib/grocery";

// ---------------------------------------------------------------------------
// Generate grocery list from a week plan
// ---------------------------------------------------------------------------

export async function generateGroceryList(weekPlanId: string) {
  const supabase = await createClient();

  // Get household_id
  const { data: hid } = await supabase.rpc("get_my_household_id");
  if (!hid) throw new Error("Not authenticated");

  // Check if a grocery list already exists for this week plan
  const { data: existing } = await supabase
    .from("grocery_lists")
    .select("id")
    .eq("week_plan_id", weekPlanId)
    .eq("status", "active")
    .maybeSingle();

  if (existing) {
    return { groceryListId: existing.id, isExisting: true };
  }

  // Fetch all cook slots with recipes
  const { data: slotData } = await supabase
    .from("meal_slots")
    .select("*, recipes(title, cuisine, total_time_min, is_vegetarian)")
    .eq("week_plan_id", weekPlanId)
    .in("meal_type", ["breakfast", "lunch", "dinner"])
    .order("slot_date");

  const slots = (slotData ?? []) as MealSlotWithRecipe[];

  // Get distinct recipe IDs
  const recipeIds = Array.from(
    new Set(
      slots
        .filter((s) => s.recipe_id != null && s.meal_mode === "cook")
        .map((s) => s.recipe_id as string)
    )
  );

  if (recipeIds.length === 0) {
    throw new Error("No recipes assigned to this week's plan yet");
  }

  // Fetch participants for all slots
  const slotIds = slots.map((s) => s.id);
  const { data: partData } = await supabase
    .from("meal_slot_participants")
    .select("*, household_members(name)")
    .in("meal_slot_id", slotIds);

  const participants = (partData ?? []) as MealSlotParticipantWithMember[];
  const participantsBySlot = new Map<
    string,
    MealSlotParticipantWithMember[]
  >();
  for (const p of participants) {
    const existing = participantsBySlot.get(p.meal_slot_id) ?? [];
    existing.push(p);
    participantsBySlot.set(p.meal_slot_id, existing);
  }

  // Fetch recipe ingredients with full ingredient details
  const { data: riData } = await supabase
    .from("recipe_ingredients")
    .select("*, ingredients(*)")
    .in("recipe_id", recipeIds);

  const recipeIngredients = (riData ?? []) as RecipeIngredientWithDetails[];
  const ingredientsByRecipe = new Map<
    string,
    RecipeIngredientWithDetails[]
  >();
  for (const ri of recipeIngredients) {
    const existing = ingredientsByRecipe.get(ri.recipe_id) ?? [];
    existing.push(ri);
    ingredientsByRecipe.set(ri.recipe_id, existing);
  }

  // Fetch unit conversions
  const { data: ucData } = await supabase
    .from("unit_conversions")
    .select("*");
  const conversions = (ucData ?? []) as UnitConversion[];

  // Run aggregation engine
  const aggregated = aggregateGroceryItems(
    slots,
    participantsBySlot,
    ingredientsByRecipe,
    conversions
  );

  // Create grocery list
  const { data: groceryList, error: listError } = await supabase
    .from("grocery_lists")
    .insert({
      household_id: hid,
      week_plan_id: weekPlanId,
    })
    .select()
    .single();

  if (listError || !groceryList) {
    throw new Error("Failed to create grocery list: " + listError?.message);
  }

  // Insert all aggregated items
  const items = aggregated.map((item, index) => ({
    grocery_list_id: groceryList.id,
    ingredient_id: item.ingredientId,
    name: item.name,
    quantity: item.displayQuantity,
    unit: item.displayUnit,
    category: item.category,
    sort_order: index,
    recipe_sources: item.recipeSources,
  }));

  if (items.length > 0) {
    const { error: itemsError } = await supabase
      .from("grocery_items")
      .insert(items);

    if (itemsError) {
      // Clean up the list if items fail
      await supabase.from("grocery_lists").delete().eq("id", groceryList.id);
      throw new Error("Failed to create grocery items: " + itemsError.message);
    }
  }

  revalidatePath("/grocery");
  trackEvent("grocery_generated", { grocery_list_id: groceryList.id }).catch(() => {});
  return { groceryListId: groceryList.id, isExisting: false };
}

// ---------------------------------------------------------------------------
// Toggle item checked (while shopping)
// ---------------------------------------------------------------------------

export async function toggleGroceryItemChecked(
  itemId: string,
  isChecked: boolean
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("grocery_items")
    .update({ is_checked: isChecked })
    .eq("id", itemId);

  if (error) throw new Error("Failed to update item: " + error.message);
  revalidatePath("/grocery");
}

// ---------------------------------------------------------------------------
// Toggle "already have this"
// ---------------------------------------------------------------------------

export async function toggleAlreadyHave(
  itemId: string,
  alreadyHave: boolean
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("grocery_items")
    .update({ is_already_have: alreadyHave })
    .eq("id", itemId);

  if (error) throw new Error("Failed to update item: " + error.message);
  revalidatePath("/grocery");
}

// ---------------------------------------------------------------------------
// Add a custom item to the list
// ---------------------------------------------------------------------------

export async function addCustomGroceryItem(
  groceryListId: string,
  name: string,
  quantity?: number,
  unit?: string,
  category?: string
) {
  const supabase = await createClient();

  // Get max sort_order
  const { data: maxItem } = await supabase
    .from("grocery_items")
    .select("sort_order")
    .eq("grocery_list_id", groceryListId)
    .order("sort_order", { ascending: false })
    .limit(1)
    .maybeSingle();

  const sortOrder = (maxItem?.sort_order ?? 0) + 1;

  const { error } = await supabase.from("grocery_items").insert({
    grocery_list_id: groceryListId,
    name,
    quantity: quantity ?? null,
    unit: unit ?? null,
    category: category ?? "other",
    sort_order: sortOrder,
    recipe_sources: ["(manually added)"],
  });

  if (error) throw new Error("Failed to add item: " + error.message);
  revalidatePath("/grocery");
}

// ---------------------------------------------------------------------------
// Remove an item from the list
// ---------------------------------------------------------------------------

export async function removeGroceryItem(itemId: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("grocery_items")
    .delete()
    .eq("id", itemId);

  if (error) throw new Error("Failed to remove item: " + error.message);
  revalidatePath("/grocery");
}

// ---------------------------------------------------------------------------
// Get share token for a grocery list
// ---------------------------------------------------------------------------

export async function getShareToken(groceryListId: string): Promise<string> {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("grocery_lists")
    .select("share_token")
    .eq("id", groceryListId)
    .single();

  if (error || !data) throw new Error("Failed to get share token");
  trackEvent("grocery_shared", { grocery_list_id: groceryListId }).catch(() => {});
  return data.share_token;
}

// ---------------------------------------------------------------------------
// Mark grocery list as completed
// ---------------------------------------------------------------------------

export async function completeGroceryList(groceryListId: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("grocery_lists")
    .update({ status: "completed" })
    .eq("id", groceryListId);

  if (error) throw new Error("Failed to complete list: " + error.message);
  revalidatePath("/grocery");
}
