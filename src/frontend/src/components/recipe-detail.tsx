"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import type { Recipe, RecipeIngredientWithName, RecipeStep, RecipeNutrition } from "@/lib/types/database";
import { updateRecipeStatus, updateRecipeRating, toggleRecipeFavorite } from "@/lib/actions/recipe-actions";
import StatusBadge from "./status-badge";
import StarRating from "./star-rating";
import ConfirmDialog from "./confirm-dialog";

type RecipeDetailProps = {
  recipe: Recipe;
  ingredients: RecipeIngredientWithName[];
  steps: RecipeStep[];
  nutrition?: RecipeNutrition | null;
};

export default function RecipeDetail({
  recipe,
  ingredients,
  steps,
  nutrition,
}: RecipeDetailProps) {
  const router = useRouter();
  const [statusLoading, setStatusLoading] = useState(false);
  const [showArchiveDialog, setShowArchiveDialog] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [rating, setRating] = useState<number | null>(recipe.rating ?? null);
  const [isFavorite, setIsFavorite] = useState(recipe.is_favorite);
  const [favoriteLoading, setFavoriteLoading] = useState(false);

  const mealTypes = recipe.meal_types ?? [];
  const tags = recipe.tags ?? [];

  // Group ingredients by group_name
  const ingredientGroups = groupIngredients(ingredients);

  async function handleRatingChange(newRating: number | null) {
    setRating(newRating);
    try {
      await updateRecipeRating(recipe.id, newRating);
    } catch {
      setRating(recipe.rating ?? null); // revert on failure
    }
  }

  async function handleFavoriteToggle() {
    const newVal = !isFavorite;
    setIsFavorite(newVal);
    setFavoriteLoading(true);
    try {
      await toggleRecipeFavorite(recipe.id, newVal);
    } catch {
      setIsFavorite(!newVal); // revert on failure
    } finally {
      setFavoriteLoading(false);
    }
  }

  async function handleStatusChange(newStatus: "draft" | "active" | "archived") {
    setStatusLoading(true);
    setError(null);
    try {
      await updateRecipeStatus(recipe.id, newStatus);
      if (newStatus === "archived") {
        router.push("/recipes");
      } else {
        router.refresh();
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to update status");
    } finally {
      setStatusLoading(false);
      setShowArchiveDialog(false);
    }
  }

  return (
    <div className="space-y-6">
      {/* Error */}
      {error && (
        <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm">
          {error}
        </div>
      )}

      {/* Hero Image */}
      {recipe.image_url && (
        <div className="-mx-4 sm:mx-0 sm:rounded-xl overflow-hidden">
          <img
            src={recipe.image_url}
            alt={recipe.title}
            className="w-full h-48 sm:h-64 object-cover"
          />
        </div>
      )}

      {/* Header Section */}
      <div>
        <div className="mb-2">
          <StatusBadge status={recipe.status} />
        </div>
        <h1 className="text-2xl font-bold text-ink">{recipe.title}</h1>

        {/* Rating + Favorite */}
        <div className="flex items-center gap-3 mt-2">
          <StarRating value={rating} onChange={handleRatingChange} size="md" />
          <button
            type="button"
            onClick={handleFavoriteToggle}
            disabled={favoriteLoading}
            className="group flex items-center gap-1 transition-colors"
            aria-label={isFavorite ? "Remove from favorites" : "Add to favorites"}
          >
            <svg
              className={`w-6 h-6 transition-colors ${
                isFavorite
                  ? "fill-red-500 text-red-500"
                  : "fill-none text-ink-light group-hover:text-red-400"
              }`}
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
            </svg>
            <span className={`text-xs font-medium ${isFavorite ? "text-red-500" : "text-ink-light"}`}>
              {isFavorite ? "Favorited" : "Favorite"}
            </span>
          </button>
        </div>

        {recipe.description && (
          <p className="mt-2 text-ink-muted text-sm leading-relaxed">
            {recipe.description}
          </p>
        )}
      </div>

      {/* Meta Info */}
      <div className="flex flex-wrap gap-2 text-sm">
        {recipe.cuisine && (
          <span className="px-2 py-1 rounded-lg bg-cream text-ink font-medium">
            {recipe.cuisine}
          </span>
        )}
        {mealTypes.map((type) => (
          <span
            key={type}
            className="px-2 py-1 rounded-lg bg-primary/10 text-primary-dark font-medium"
          >
            {type}
          </span>
        ))}
      </div>

      {/* Times + Servings + Difficulty */}
      <div className="flex flex-wrap gap-4 text-sm text-ink-muted">
        {recipe.prep_time_min != null && (
          <span>🕐 {recipe.prep_time_min}m prep</span>
        )}
        {recipe.cook_time_min != null && (
          <span>🍳 {recipe.cook_time_min}m cook</span>
        )}
        {recipe.total_time_min != null && recipe.total_time_min > 0 && (
          <span className="font-medium text-ink">
            ⏱ {recipe.total_time_min}m total
          </span>
        )}
        <span>🍽 Serves {recipe.servings}</span>
        {recipe.difficulty && (
          <span className="capitalize">📊 {recipe.difficulty}</span>
        )}
      </div>

      {/* Flags */}
      <div className="flex flex-wrap gap-2 text-sm">
        {recipe.is_vegetarian && (
          <span className="px-2 py-1 rounded-lg bg-active/10 text-active font-medium">
            🟢 Vegetarian
          </span>
        )}
        {recipe.is_vegan && (
          <span className="px-2 py-1 rounded-lg bg-active/10 text-active font-medium">
            🌱 Vegan
          </span>
        )}
        {recipe.is_batch_friendly && (
          <span className="px-2 py-1 rounded-lg bg-secondary/10 text-secondary-dark font-medium">
            📦 Batch friendly
          </span>
        )}
        {recipe.leftover_days != null && recipe.leftover_days > 0 && (
          <span className="px-2 py-1 rounded-lg bg-accent/20 text-accent-dark font-medium">
            🗓 {recipe.leftover_days}d leftovers
          </span>
        )}
      </div>

      {/* ── NUTRITION ── */}
      {nutrition && (
        <div>
          <h2 className="text-lg font-bold text-ink mb-3 flex items-center gap-2">
            <span>📊</span> Nutrition
            <span className="text-xs font-normal text-ink-muted">
              (per serving)
            </span>
          </h2>
          <div className="grid grid-cols-4 gap-3">
            <div className="bg-surface rounded-xl border border-ink-light/10 p-3 text-center">
              <p className="text-lg font-bold text-primary">
                {nutrition.caloriesPerServing}
              </p>
              <p className="text-xs text-ink-muted">Calories</p>
            </div>
            <div className="bg-surface rounded-xl border border-ink-light/10 p-3 text-center">
              <p className="text-lg font-bold text-secondary">
                {nutrition.proteinPerServing}g
              </p>
              <p className="text-xs text-ink-muted">Protein</p>
            </div>
            <div className="bg-surface rounded-xl border border-ink-light/10 p-3 text-center">
              <p className="text-lg font-bold text-accent-dark">
                {nutrition.carbsPerServing}g
              </p>
              <p className="text-xs text-ink-muted">Carbs</p>
            </div>
            <div className="bg-surface rounded-xl border border-ink-light/10 p-3 text-center">
              <p className="text-lg font-bold text-ink">
                {nutrition.fatPerServing}g
              </p>
              <p className="text-xs text-ink-muted">Fat</p>
            </div>
          </div>
          {nutrition.confidence < 1 && (
            <p className="text-xs text-ink-light mt-2">
              ⚠️ Data available for {Math.round(nutrition.confidence * 100)}% of
              ingredients. Actual values may differ.
            </p>
          )}
        </div>
      )}

      {/* Tags */}
      {tags.length > 0 && (
        <div className="flex flex-wrap gap-1.5">
          {tags.map((tag) => (
            <span
              key={tag}
              className="px-2 py-0.5 rounded-full text-xs bg-ink/5 text-ink-muted border border-ink-light/20"
            >
              {tag}
            </span>
          ))}
        </div>
      )}

      {/* Source */}
      {recipe.source_url && (
        <div className="text-xs text-ink-light">
          Source:{" "}
          <a
            href={recipe.source_url}
            target="_blank"
            rel="noopener noreferrer"
            className="text-primary hover:underline"
          >
            {recipe.source_url}
          </a>
        </div>
      )}

      {/* ── INGREDIENTS ── */}
      <div>
        <h2 className="text-lg font-bold text-ink mb-3 flex items-center gap-2">
          <span>🥘</span> Ingredients
        </h2>
        {ingredients.length === 0 ? (
          <p className="text-sm text-ink-muted italic">No ingredients added yet.</p>
        ) : (
          <div className="space-y-4">
            {ingredientGroups.map((group) => (
              <div key={group.name}>
                {group.name !== "_default" && (
                  <h3 className="text-sm font-semibold text-ink-muted mb-2">
                    {group.name}
                  </h3>
                )}
                <ul className="space-y-1.5">
                  {group.items.map((ing) => (
                    <li key={ing.id} className="flex items-start gap-2 text-sm">
                      <span className="text-primary mt-0.5">•</span>
                      <span>
                        {ing.quantity != null && (
                          <span className="font-medium">{ing.quantity}</span>
                        )}{" "}
                        {ing.unit && <span className="text-ink-muted">{ing.unit}</span>}{" "}
                        <span className="text-ink">{ing.ingredients.name}</span>
                        {ing.preparation && (
                          <span className="text-ink-light">, {ing.preparation}</span>
                        )}
                        {ing.is_optional && (
                          <span className="ml-1 text-xs text-ink-light italic">
                            (optional)
                          </span>
                        )}
                      </span>
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* ── STEPS ── */}
      <div>
        <h2 className="text-lg font-bold text-ink mb-3 flex items-center gap-2">
          <span>📝</span> Steps
        </h2>
        {steps.length === 0 ? (
          <p className="text-sm text-ink-muted italic">No steps added yet.</p>
        ) : (
          <ol className="space-y-4">
            {steps.map((step) => (
              <li key={step.id} className="flex gap-3">
                <span className="flex-shrink-0 w-7 h-7 rounded-full bg-primary/10 text-primary font-bold text-sm flex items-center justify-center">
                  {step.step_number}
                </span>
                <div className="flex-1 pt-0.5">
                  <p className="text-sm text-ink leading-relaxed">
                    {step.instruction}
                  </p>
                  {step.duration_min != null && (
                    <span className="text-xs text-ink-light mt-1 inline-block">
                      ⏱ {step.duration_min} min
                    </span>
                  )}
                </div>
              </li>
            ))}
          </ol>
        )}
      </div>

      {/* ── ACTIONS ── */}
      <div className="border-t border-ink-light/10 pt-6 flex flex-wrap gap-3">
        <Link
          href={`/recipes/${recipe.id}/edit`}
          className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors"
        >
          Edit Recipe
        </Link>

        {/* Status buttons */}
        {recipe.status === "draft" && (
          <button
            onClick={() => handleStatusChange("active")}
            disabled={statusLoading}
            className="px-4 py-2 rounded-lg bg-active text-white text-sm font-semibold hover:bg-active/90 transition-colors disabled:opacity-50"
          >
            {statusLoading ? "Updating..." : "Mark as Active"}
          </button>
        )}
        {recipe.status === "active" && (
          <button
            onClick={() => handleStatusChange("draft")}
            disabled={statusLoading}
            className="px-4 py-2 rounded-lg bg-draft text-white text-sm font-semibold hover:bg-draft/90 transition-colors disabled:opacity-50"
          >
            {statusLoading ? "Updating..." : "Revert to Draft"}
          </button>
        )}
        {recipe.status === "archived" && (
          <button
            onClick={() => handleStatusChange("draft")}
            disabled={statusLoading}
            className="px-4 py-2 rounded-lg bg-secondary text-white text-sm font-semibold hover:bg-secondary-dark transition-colors disabled:opacity-50"
          >
            {statusLoading ? "Updating..." : "Restore as Draft"}
          </button>
        )}

        {/* Archive button (not shown if already archived) */}
        {recipe.status !== "archived" && (
          <button
            onClick={() => setShowArchiveDialog(true)}
            className="px-4 py-2 rounded-lg text-sm font-medium text-red-500 hover:bg-red-50 transition-colors"
          >
            Archive
          </button>
        )}
      </div>

      {/* Archive Confirmation Dialog */}
      {showArchiveDialog && (
        <ConfirmDialog
          title="Archive Recipe"
          message={`Are you sure you want to archive "${recipe.title}"? It will no longer appear in your recipe list.`}
          confirmLabel="Archive"
          confirmVariant="danger"
          onConfirm={() => handleStatusChange("archived")}
          onCancel={() => setShowArchiveDialog(false)}
        />
      )}
    </div>
  );
}

// Helper: group ingredients by group_name
function groupIngredients(ingredients: RecipeIngredientWithName[]) {
  const groups: { name: string; items: RecipeIngredientWithName[] }[] = [];
  const groupMap = new Map<string, RecipeIngredientWithName[]>();

  for (const ing of ingredients) {
    const key = ing.group_name || "_default";
    if (!groupMap.has(key)) {
      groupMap.set(key, []);
    }
    groupMap.get(key)!.push(ing);
  }

  // Put _default group first, then others in order
  const keys = Array.from(groupMap.keys());
  if (groupMap.has("_default")) {
    groups.push({ name: "_default", items: groupMap.get("_default")! });
  }
  keys.forEach((name) => {
    if (name !== "_default") {
      groups.push({ name, items: groupMap.get(name)! });
    }
  });

  return groups;
}
