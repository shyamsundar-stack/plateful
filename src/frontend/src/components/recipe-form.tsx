"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import type {
  Recipe,
  Ingredient,
  RecipeIngredientWithName,
  RecipeStep,
  IngredientRow,
  StepRow,
} from "@/lib/types/database";
import {
  createRecipe,
  updateRecipe,
  updateRecipeIngredients,
  updateRecipeSteps,
} from "@/lib/actions/recipe-actions";
import { trackEvent } from "@/lib/actions/analytics-actions";
import { uploadRecipeImage, deleteRecipeImage } from "@/lib/actions/image-actions";
import IngredientListEditor from "./ingredient-list-editor";
import StepListEditor from "./step-list-editor";

// ──────────────────────────────────────────
// Meal type options (for multi-select chips)
// ──────────────────────────────────────────
const MEAL_TYPE_OPTIONS = ["breakfast", "lunch", "dinner", "snack"];
const DIFFICULTY_OPTIONS = ["easy", "medium", "hard"];

type RecipeFormProps = {
  mode: "create" | "edit";
  householdId: string;
  householdIngredients: Ingredient[];
  // For edit mode — pre-populate with existing data
  initialRecipe?: Recipe;
  initialIngredients?: RecipeIngredientWithName[];
  initialSteps?: RecipeStep[];
};

export default function RecipeForm({
  mode,
  householdId,
  householdIngredients: initialHouseholdIngredients,
  initialRecipe,
  initialIngredients,
  initialSteps,
}: RecipeFormProps) {
  const router = useRouter();

  // Track household ingredients locally (so "add new" updates the list)
  const [householdIngredients, setHouseholdIngredients] = useState(
    initialHouseholdIngredients
  );

  // ── Basic fields ──
  const [title, setTitle] = useState(initialRecipe?.title ?? "");
  const [description, setDescription] = useState(initialRecipe?.description ?? "");
  const [cuisine, setCuisine] = useState(initialRecipe?.cuisine ?? "");
  const [mealTypes, setMealTypes] = useState<string[]>(
    initialRecipe?.meal_types ?? []
  );
  const [servings, setServings] = useState(initialRecipe?.servings ?? 2);
  const [prepTime, setPrepTime] = useState<number | null>(
    initialRecipe?.prep_time_min ?? null
  );
  const [cookTime, setCookTime] = useState<number | null>(
    initialRecipe?.cook_time_min ?? null
  );
  const [difficulty, setDifficulty] = useState(initialRecipe?.difficulty ?? "");
  const [tagsInput, setTagsInput] = useState(
    (initialRecipe?.tags ?? []).join(", ")
  );
  const [isVegetarian, setIsVegetarian] = useState(
    initialRecipe?.is_vegetarian ?? false
  );
  const [isVegan, setIsVegan] = useState(initialRecipe?.is_vegan ?? false);
  const [isBatchFriendly, setIsBatchFriendly] = useState(
    initialRecipe?.is_batch_friendly ?? false
  );
  const [leftoverDays, setLeftoverDays] = useState<number | null>(
    initialRecipe?.leftover_days ?? null
  );

  // ── Ingredients ──
  const [ingredientRows, setIngredientRows] = useState<IngredientRow[]>(
    initialIngredients?.map((ing) => ({
      _clientId: crypto.randomUUID(),
      ingredient_id: ing.ingredient_id,
      ingredient_name: ing.ingredients.name,
      quantity: ing.quantity,
      unit: ing.unit ?? "",
      preparation: ing.preparation ?? "",
      is_optional: ing.is_optional,
      group_name: ing.group_name ?? "",
    })) ?? []
  );

  // ── Steps ──
  const [stepRows, setStepRows] = useState<StepRow[]>(
    initialSteps?.map((step) => ({
      _clientId: crypto.randomUUID(),
      instruction: step.instruction,
      duration_min: step.duration_min,
    })) ?? []
  );

  // ── Image state ──
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(
    initialRecipe?.image_url ?? null
  );
  const [imageUploading, setImageUploading] = useState(false);

  // ── UI state ──
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Computed total time
  const totalTime = (prepTime ?? 0) + (cookTime ?? 0);

  // Parse tags from comma-separated input
  function parseTags(): string[] {
    return tagsInput
      .split(",")
      .map((t) => t.trim())
      .filter((t) => t.length > 0);
  }

  // Toggle meal type
  function toggleMealType(type: string) {
    setMealTypes((prev) =>
      prev.includes(type) ? prev.filter((t) => t !== type) : [...prev, type]
    );
  }

  // Handle new ingredient created via autocomplete
  function handleNewIngredient(ingredient: Ingredient) {
    setHouseholdIngredients((prev) => [...prev, ingredient]);
  }

  // ── Image handling ──
  function handleImageSelect(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (!file) return;

    // Client-side compression via canvas
    const reader = new FileReader();
    reader.onload = (event) => {
      const img = new Image();
      img.onload = () => {
        const canvas = document.createElement("canvas");
        const MAX_SIZE = 800;
        let width = img.width;
        let height = img.height;

        if (width > MAX_SIZE || height > MAX_SIZE) {
          if (width > height) {
            height = (height / width) * MAX_SIZE;
            width = MAX_SIZE;
          } else {
            width = (width / height) * MAX_SIZE;
            height = MAX_SIZE;
          }
        }

        canvas.width = width;
        canvas.height = height;
        const ctx = canvas.getContext("2d");
        ctx?.drawImage(img, 0, 0, width, height);

        canvas.toBlob(
          (blob) => {
            if (blob) {
              const compressed = new File([blob], file.name, {
                type: "image/jpeg",
              });
              setImageFile(compressed);
              setImagePreview(URL.createObjectURL(compressed));
            }
          },
          "image/jpeg",
          0.8
        );
      };
      img.src = event.target?.result as string;
    };
    reader.readAsDataURL(file);
  }

  async function handleImageRemove() {
    if (initialRecipe?.id && initialRecipe.image_url) {
      setImageUploading(true);
      try {
        await deleteRecipeImage(initialRecipe.id);
        setImagePreview(null);
        setImageFile(null);
      } catch (err) {
        setError(err instanceof Error ? err.message : "Failed to remove image");
      } finally {
        setImageUploading(false);
      }
    } else {
      setImagePreview(null);
      setImageFile(null);
    }
  }

  // ── SAVE ──
  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);

    // Validation
    if (!title.trim()) {
      setError("Recipe title is required.");
      return;
    }
    if (servings < 1) {
      setError("Servings must be at least 1.");
      return;
    }

    // Check all ingredients have an ingredient_id
    const invalidIngredients = ingredientRows.filter(
      (row) => !row.ingredient_id
    );
    if (invalidIngredients.length > 0) {
      setError(
        "Please select an ingredient for each row, or remove empty rows."
      );
      return;
    }

    // Check all steps have instructions
    const emptySteps = stepRows.filter((row) => !row.instruction.trim());
    if (emptySteps.length > 0) {
      setError("Please fill in all step instructions, or remove empty steps.");
      return;
    }

    setSaving(true);

    try {
      const recipeData = {
        title: title.trim(),
        description: description.trim() || null,
        cuisine: cuisine.trim() || null,
        meal_types: mealTypes,
        servings,
        prep_time_min: prepTime,
        cook_time_min: cookTime,
        difficulty: difficulty || null,
        tags: parseTags(),
        source_type: "manual" as const,
        is_vegetarian: isVegetarian,
        is_vegan: isVegan,
        is_batch_friendly: isBatchFriendly,
        leftover_days: leftoverDays,
      };

      if (mode === "create") {
        const recipe = await createRecipe(
          householdId,
          recipeData,
          ingredientRows,
          stepRows
        );
        trackEvent("recipe_created", { recipe_id: recipe.id, source_type: "manual" }).catch(() => {});

        // Upload image if selected
        if (imageFile) {
          const fd = new FormData();
          fd.append("image", imageFile);
          await uploadRecipeImage(recipe.id, fd);
        }

        router.push(`/recipes/${recipe.id}`);
      } else if (initialRecipe) {
        // Update recipe + ingredients + steps in sequence
        await updateRecipe(initialRecipe.id, recipeData);
        await updateRecipeIngredients(initialRecipe.id, ingredientRows);
        await updateRecipeSteps(initialRecipe.id, stepRows);

        // Upload image if a new file was selected
        if (imageFile) {
          const fd = new FormData();
          fd.append("image", imageFile);
          await uploadRecipeImage(initialRecipe.id, fd);
        }

        router.push(`/recipes/${initialRecipe.id}`);
      }

      router.refresh();
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to save recipe."
      );
    } finally {
      setSaving(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-8">
      {/* Error */}
      {error && (
        <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm">
          {error}
        </div>
      )}

      {/* ═══ BASIC INFO ═══ */}
      <section className="space-y-4">
        <h3 className="text-lg font-bold text-ink">Basic Info</h3>

        {/* Title */}
        <div>
          <label className="block text-sm font-medium text-ink mb-1">
            Recipe Title <span className="text-red-500">*</span>
          </label>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            required
            placeholder="e.g. Dal Tadka"
            className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
          />
        </div>

        {/* Description */}
        <div>
          <label className="block text-sm font-medium text-ink mb-1">
            Description
          </label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Brief description of the dish..."
            rows={2}
            className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 resize-none"
          />
        </div>

        {/* Cuisine */}
        <div>
          <label className="block text-sm font-medium text-ink mb-1">
            Cuisine
          </label>
          <input
            type="text"
            value={cuisine}
            onChange={(e) => setCuisine(e.target.value)}
            placeholder="e.g. Indian, Chinese, Italian"
            className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50"
          />
        </div>

        {/* Meal Types (multi-select chips) */}
        <div>
          <label className="block text-sm font-medium text-ink mb-2">
            Meal Types
          </label>
          <div className="flex gap-2 flex-wrap">
            {MEAL_TYPE_OPTIONS.map((type) => (
              <button
                key={type}
                type="button"
                onClick={() => toggleMealType(type)}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold border transition-all ${
                  mealTypes.includes(type)
                    ? "bg-primary text-white border-primary"
                    : "bg-surface text-ink-muted border-ink-light/30 hover:border-primary/50"
                }`}
              >
                {type.charAt(0).toUpperCase() + type.slice(1)}
              </button>
            ))}
          </div>
        </div>
      </section>

      {/* ═══ RECIPE IMAGE ═══ */}
      <section className="space-y-3">
        <h3 className="text-lg font-bold text-ink">Photo</h3>
        {imagePreview ? (
          <div className="relative">
            <img
              src={imagePreview}
              alt="Recipe preview"
              className="w-full h-48 object-cover rounded-xl border border-ink-light/10"
            />
            <button
              type="button"
              onClick={handleImageRemove}
              disabled={imageUploading}
              className="absolute top-2 right-2 px-2 py-1 rounded-lg bg-black/60 text-white text-xs
                font-semibold hover:bg-black/80 transition-colors disabled:opacity-50"
            >
              {imageUploading ? "Removing..." : "Remove"}
            </button>
          </div>
        ) : (
          <label className="flex flex-col items-center justify-center w-full h-36 rounded-xl border-2
            border-dashed border-ink-light/30 bg-cream/30 cursor-pointer hover:border-primary/50
            hover:bg-primary/5 transition-colors">
            <svg className="w-8 h-8 text-ink-light mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5}
                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>
            <span className="text-sm text-ink-muted">Click to upload a photo</span>
            <span className="text-xs text-ink-light mt-0.5">JPG, PNG up to 5MB</span>
            <input
              type="file"
              accept="image/*"
              onChange={handleImageSelect}
              className="hidden"
            />
          </label>
        )}
      </section>

      {/* ═══ TIMING & SERVINGS ═══ */}
      <section className="space-y-4">
        <h3 className="text-lg font-bold text-ink">Timing & Servings</h3>

        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
          <div>
            <label className="block text-xs font-medium text-ink mb-1">
              Prep (min)
            </label>
            <input
              type="number"
              value={prepTime ?? ""}
              onChange={(e) =>
                setPrepTime(e.target.value ? parseInt(e.target.value) : null)
              }
              min="0"
              placeholder="0"
              className="w-full px-3 py-2 rounded-lg border border-ink-light/30 text-sm focus:outline-none focus:ring-2 focus:ring-primary/50"
            />
          </div>
          <div>
            <label className="block text-xs font-medium text-ink mb-1">
              Cook (min)
            </label>
            <input
              type="number"
              value={cookTime ?? ""}
              onChange={(e) =>
                setCookTime(e.target.value ? parseInt(e.target.value) : null)
              }
              min="0"
              placeholder="0"
              className="w-full px-3 py-2 rounded-lg border border-ink-light/30 text-sm focus:outline-none focus:ring-2 focus:ring-primary/50"
            />
          </div>
          <div>
            <label className="block text-xs font-medium text-ink mb-1">
              Total
            </label>
            <div className="px-3 py-2 rounded-lg border border-ink-light/20 bg-ink-light/5 text-sm text-ink-muted font-medium select-none">
              {totalTime > 0 ? `${totalTime} min` : "—"}
            </div>
          </div>
          <div>
            <label className="block text-xs font-medium text-ink mb-1">
              Servings <span className="text-red-500">*</span>
            </label>
            <input
              type="number"
              value={servings}
              onChange={(e) =>
                setServings(Math.max(1, parseInt(e.target.value) || 1))
              }
              min="1"
              className="w-full px-3 py-2 rounded-lg border border-ink-light/30 text-sm focus:outline-none focus:ring-2 focus:ring-primary/50"
            />
          </div>
        </div>

        {/* Difficulty */}
        <div>
          <label className="block text-sm font-medium text-ink mb-2">
            Difficulty
          </label>
          <div className="flex gap-2">
            {DIFFICULTY_OPTIONS.map((d) => (
              <button
                key={d}
                type="button"
                onClick={() => setDifficulty(difficulty === d ? "" : d)}
                className={`px-3 py-1.5 rounded-full text-xs font-semibold border transition-all capitalize ${
                  difficulty === d
                    ? "bg-primary text-white border-primary"
                    : "bg-surface text-ink-muted border-ink-light/30 hover:border-primary/50"
                }`}
              >
                {d}
              </button>
            ))}
          </div>
        </div>
      </section>

      {/* ═══ DIETARY ═══ */}
      <section className="space-y-4">
        <h3 className="text-lg font-bold text-ink">Dietary Info</h3>

        <div className="flex flex-wrap gap-4">
          <label className="flex items-center gap-2 text-sm text-ink">
            <input
              type="checkbox"
              checked={isVegetarian}
              onChange={(e) => setIsVegetarian(e.target.checked)}
              className="rounded border-ink-light/30"
            />
            <span aria-hidden="true">🟢</span> Vegetarian
          </label>
          <label className="flex items-center gap-2 text-sm text-ink">
            <input
              type="checkbox"
              checked={isVegan}
              onChange={(e) => setIsVegan(e.target.checked)}
              className="rounded border-ink-light/30"
            />
            <span aria-hidden="true">🌱</span> Vegan
          </label>
          <label className="flex items-center gap-2 text-sm text-ink">
            <input
              type="checkbox"
              checked={isBatchFriendly}
              onChange={(e) => setIsBatchFriendly(e.target.checked)}
              className="rounded border-ink-light/30"
            />
            <span aria-hidden="true">📦</span> Batch friendly
          </label>
        </div>

        <div className="flex items-center gap-2">
          <label className="text-sm text-ink">Leftover days:</label>
          <input
            type="number"
            value={leftoverDays ?? ""}
            onChange={(e) =>
              setLeftoverDays(e.target.value ? parseInt(e.target.value) : null)
            }
            min="0"
            max="7"
            placeholder="0"
            className="w-16 px-2 py-1.5 rounded border border-ink-light/30 text-sm focus:outline-none focus:ring-1 focus:ring-primary/50"
          />
        </div>
      </section>

      {/* ═══ TAGS ═══ */}
      <section>
        <h3 className="text-lg font-bold text-ink mb-2">Tags</h3>
        <input
          type="text"
          value={tagsInput}
          onChange={(e) => setTagsInput(e.target.value)}
          placeholder="comfort food, protein-rich, weeknight (comma separated)"
          className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink text-sm placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50"
        />
        {parseTags().length > 0 && (
          <div className="flex flex-wrap gap-1.5 mt-2">
            {parseTags().map((tag) => (
              <span
                key={tag}
                className="px-2 py-0.5 rounded-full text-xs bg-ink/5 text-ink-muted border border-ink-light/20"
              >
                {tag}
              </span>
            ))}
          </div>
        )}
      </section>

      {/* ═══ INGREDIENTS ═══ */}
      <section>
        <h3 className="text-lg font-bold text-ink mb-3">
          🥘 Ingredients
        </h3>
        <IngredientListEditor
          rows={ingredientRows}
          onChange={setIngredientRows}
          householdIngredients={householdIngredients}
          householdId={householdId}
          onNewIngredient={handleNewIngredient}
        />
      </section>

      {/* ═══ STEPS ═══ */}
      <section>
        <h3 className="text-lg font-bold text-ink mb-3">
          📝 Steps
        </h3>
        <StepListEditor rows={stepRows} onChange={setStepRows} />
      </section>

      {/* ═══ SAVE ═══ */}
      <div className="border-t border-ink-light/10 pt-6 flex gap-3">
        <button
          type="submit"
          disabled={saving}
          className="px-6 py-2.5 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {saving
            ? "Saving..."
            : mode === "create"
            ? "Create Recipe"
            : "Save Changes"}
        </button>
        <button
          type="button"
          onClick={() => router.back()}
          className="px-4 py-2.5 rounded-lg text-sm text-ink-muted hover:text-ink hover:bg-cream transition-colors"
        >
          Cancel
        </button>
      </div>
    </form>
  );
}
