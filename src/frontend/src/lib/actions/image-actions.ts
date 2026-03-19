"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

// ---------------------------------------------------------------------------
// Upload a recipe image to Supabase Storage
// ---------------------------------------------------------------------------

export async function uploadRecipeImage(
  recipeId: string,
  formData: FormData
) {
  const supabase = await createClient();

  // Get household_id
  const { data: hid } = await supabase.rpc("get_my_household_id");
  if (!hid) throw new Error("Not authenticated");

  const file = formData.get("image") as File;
  if (!file || file.size === 0) throw new Error("No image provided");

  // Validate file type
  if (!file.type.startsWith("image/")) {
    throw new Error("File must be an image");
  }

  // Validate file size (5MB max)
  if (file.size > 5 * 1024 * 1024) {
    throw new Error("Image must be smaller than 5MB");
  }

  // Generate storage path: {household_id}/{recipeId}-{timestamp}.jpg
  const ext = file.type === "image/png" ? "png" : "jpg";
  const storagePath = `${hid}/${recipeId}-${Date.now()}.${ext}`;

  // Upload to Supabase Storage
  const { error: uploadError } = await supabase.storage
    .from("recipe-images")
    .upload(storagePath, file, {
      contentType: file.type,
      upsert: false,
    });

  if (uploadError) {
    throw new Error("Failed to upload image: " + uploadError.message);
  }

  // Get public URL
  const { data: urlData } = supabase.storage
    .from("recipe-images")
    .getPublicUrl(storagePath);

  const publicUrl = urlData.publicUrl;

  // Delete old image if exists
  const { data: recipe } = await supabase
    .from("recipes")
    .select("image_url")
    .eq("id", recipeId)
    .single();

  if (recipe?.image_url) {
    // Extract path from old URL
    const oldPath = extractStoragePath(recipe.image_url);
    if (oldPath) {
      await supabase.storage.from("recipe-images").remove([oldPath]);
    }
  }

  // Update recipe with new image URL
  const { error: updateError } = await supabase
    .from("recipes")
    .update({ image_url: publicUrl })
    .eq("id", recipeId);

  if (updateError) {
    throw new Error("Failed to update recipe image: " + updateError.message);
  }

  revalidatePath(`/recipes/${recipeId}`);
  revalidatePath("/recipes");
  return { imageUrl: publicUrl };
}

// ---------------------------------------------------------------------------
// Delete recipe image
// ---------------------------------------------------------------------------

export async function deleteRecipeImage(recipeId: string) {
  const supabase = await createClient();

  // Get current image URL
  const { data: recipe } = await supabase
    .from("recipes")
    .select("image_url")
    .eq("id", recipeId)
    .single();

  if (recipe?.image_url) {
    const storagePath = extractStoragePath(recipe.image_url);
    if (storagePath) {
      await supabase.storage.from("recipe-images").remove([storagePath]);
    }
  }

  // Null out image_url
  const { error } = await supabase
    .from("recipes")
    .update({ image_url: null })
    .eq("id", recipeId);

  if (error) throw new Error("Failed to remove image: " + error.message);

  revalidatePath(`/recipes/${recipeId}`);
  revalidatePath("/recipes");
}

// ---------------------------------------------------------------------------
// Helper: extract storage path from public URL
// ---------------------------------------------------------------------------

function extractStoragePath(publicUrl: string): string | null {
  try {
    // Supabase public URLs look like:
    // https://xxx.supabase.co/storage/v1/object/public/recipe-images/path/file.jpg
    const match = publicUrl.match(/\/recipe-images\/(.+)$/);
    return match ? match[1] : null;
  } catch {
    return null;
  }
}
