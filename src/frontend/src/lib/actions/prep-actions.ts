"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

// ---------------------------------------------------------------------------
// Create a manual prep component
// ---------------------------------------------------------------------------

export async function createPrepComponent(data: {
  name: string;
  description?: string;
  prep_type: string;
  est_time_min?: number;
  steps?: string[];
}) {
  const supabase = await createClient();

  const { data: hid } = await supabase.rpc("get_my_household_id");
  if (!hid) throw new Error("Not authenticated");

  // Create the component
  const { data: component, error } = await supabase
    .from("prep_components")
    .insert({
      household_id: hid,
      name: data.name,
      description: data.description ?? null,
      prep_type: data.prep_type,
      est_time_min: data.est_time_min ?? null,
    })
    .select()
    .single();

  if (error || !component) {
    throw new Error("Failed to create prep component: " + error?.message);
  }

  // Insert steps if provided
  if (data.steps && data.steps.length > 0) {
    const stepRows = data.steps.map((instruction, index) => ({
      prep_component_id: component.id,
      step_number: index + 1,
      instruction,
    }));

    const { error: stepsError } = await supabase
      .from("prep_component_steps")
      .insert(stepRows);

    if (stepsError) {
      console.error("Failed to insert prep steps:", stepsError);
    }
  }

  revalidatePath("/prep");
  return component;
}

// ---------------------------------------------------------------------------
// Update a prep component
// ---------------------------------------------------------------------------

export async function updatePrepComponent(
  componentId: string,
  data: {
    name?: string;
    description?: string;
    prep_type?: string;
    est_time_min?: number;
  }
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("prep_components")
    .update(data)
    .eq("id", componentId);

  if (error) throw new Error("Failed to update: " + error.message);
  revalidatePath("/prep");
}

// ---------------------------------------------------------------------------
// Archive a prep component (soft delete)
// ---------------------------------------------------------------------------

export async function archivePrepComponent(componentId: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("prep_components")
    .update({ is_archived: true })
    .eq("id", componentId);

  if (error) throw new Error("Failed to archive: " + error.message);
  revalidatePath("/prep");
}

// ---------------------------------------------------------------------------
// Link a prep component to a recipe
// ---------------------------------------------------------------------------

export async function linkPrepToRecipe(
  prepComponentId: string,
  recipeId: string,
  notes?: string
) {
  const supabase = await createClient();

  const { error } = await supabase.from("recipe_prep_components").insert({
    prep_component_id: prepComponentId,
    recipe_id: recipeId,
    notes: notes ?? null,
  });

  if (error) {
    if (error.code === "23505") {
      // Unique constraint violation — already linked
      return;
    }
    throw new Error("Failed to link: " + error.message);
  }
  revalidatePath("/prep");
}

// ---------------------------------------------------------------------------
// Unlink a prep component from a recipe
// ---------------------------------------------------------------------------

export async function unlinkPrepFromRecipe(
  prepComponentId: string,
  recipeId: string
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("recipe_prep_components")
    .delete()
    .eq("prep_component_id", prepComponentId)
    .eq("recipe_id", recipeId);

  if (error) throw new Error("Failed to unlink: " + error.message);
  revalidatePath("/prep");
}
