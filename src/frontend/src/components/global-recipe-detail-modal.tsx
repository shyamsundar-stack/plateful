"use client";

import { useEffect } from "react";
import type {
  GlobalRecipe,
  GlobalRecipeIngredient,
  GlobalRecipeStep,
} from "@/lib/types/database";

type GlobalRecipeDetailModalProps = {
  recipe: GlobalRecipe;
  ingredients: GlobalRecipeIngredient[];
  steps: GlobalRecipeStep[];
  isImported: boolean;
  isImporting: boolean;
  onImport: () => void;
  onClose: () => void;
};

export default function GlobalRecipeDetailModal({
  recipe,
  ingredients,
  steps,
  isImported,
  isImporting,
  onImport,
  onClose,
}: GlobalRecipeDetailModalProps) {
  // Close on escape
  useEffect(() => {
    function handleKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("keydown", handleKey);
    return () => document.removeEventListener("keydown", handleKey);
  }, [onClose]);

  // Group ingredients by group_name
  const groupedIngredients = new Map<string, GlobalRecipeIngredient[]>();
  for (const ing of ingredients) {
    const group = ing.group_name ?? "";
    const existing = groupedIngredients.get(group) ?? [];
    existing.push(ing);
    groupedIngredients.set(group, existing);
  }

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center">
      {/* Backdrop */}
      <div
        className="absolute inset-0 bg-black/50 backdrop-blur-sm"
        onClick={onClose}
      />

      {/* Modal */}
      <div className="relative w-full max-w-2xl mx-4 mt-8 mb-8 max-h-[90vh] flex flex-col bg-surface rounded-2xl shadow-xl overflow-hidden">
        {/* Hero Image */}
        {recipe.image_url && (
          <div className="relative aspect-[16/9] flex-shrink-0">
            <img
              src={recipe.image_url}
              alt={recipe.title}
              className="w-full h-full object-cover"
            />
            {/* Close button on image */}
            <button
              onClick={onClose}
              className="absolute top-3 right-3 w-8 h-8 rounded-full bg-black/50 text-white flex items-center justify-center hover:bg-black/70 transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        )}

        {/* Scrollable content */}
        <div className="flex-1 overflow-y-auto p-6">
          {/* Close button if no image */}
          {!recipe.image_url && (
            <button
              onClick={onClose}
              className="absolute top-4 right-4 w-8 h-8 rounded-full bg-cream text-ink-muted flex items-center justify-center hover:bg-ink-light/20 transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          )}

          {/* Title + badges */}
          <h2 className="text-xl font-bold text-ink pr-8">{recipe.title}</h2>
          {recipe.description && (
            <p className="text-sm text-ink-muted mt-1">{recipe.description}</p>
          )}

          {/* Meta badges */}
          <div className="flex flex-wrap gap-2 mt-3">
            {/* Veg/Non-veg */}
            <span
              className={`px-2 py-0.5 rounded-full text-xs font-semibold ${
                recipe.is_vegetarian
                  ? "bg-active/10 text-active"
                  : "bg-red-50 text-red-600"
              }`}
            >
              {recipe.is_vegan ? "Vegan" : recipe.is_vegetarian ? "Vegetarian" : "Non-Veg"}
            </span>

            {/* Cuisine */}
            {recipe.cuisine && (
              <span className="px-2 py-0.5 rounded-full text-xs font-semibold bg-cream text-ink-muted">
                {recipe.cuisine.replace(/_/g, " ")}
              </span>
            )}

            {/* Difficulty */}
            <span
              className={`px-2 py-0.5 rounded-full text-xs font-semibold ${
                recipe.difficulty === "easy"
                  ? "bg-active/10 text-active"
                  : recipe.difficulty === "hard"
                  ? "bg-red-50 text-red-600"
                  : "bg-accent/10 text-accent-dark"
              }`}
            >
              {recipe.difficulty}
            </span>

            {/* Time */}
            {recipe.total_time_min && recipe.total_time_min > 0 && (
              <span className="px-2 py-0.5 rounded-full text-xs font-semibold bg-cream text-ink-muted">
                {recipe.total_time_min} min
              </span>
            )}

            {/* Servings */}
            <span className="px-2 py-0.5 rounded-full text-xs font-semibold bg-cream text-ink-muted">
              {recipe.servings} servings
            </span>

            {/* Meal types */}
            {recipe.meal_types?.map((mt) => (
              <span
                key={mt}
                className="px-2 py-0.5 rounded-full text-xs font-semibold bg-primary/10 text-primary-dark"
              >
                {mt}
              </span>
            ))}
          </div>

          {/* Ingredients */}
          <div className="mt-6">
            <h3 className="text-sm font-bold text-ink uppercase tracking-wide mb-3">
              Ingredients
            </h3>
            {Array.from(groupedIngredients.entries()).map(([group, items]) => (
              <div key={group} className="mb-3">
                {group && (
                  <h4 className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-1">
                    {group}
                  </h4>
                )}
                <ul className="space-y-1">
                  {items.map((ing) => (
                    <li key={ing.id} className="flex items-baseline gap-2 text-sm">
                      <span className="text-ink-muted w-16 text-right flex-shrink-0">
                        {ing.quantity} {ing.unit}
                      </span>
                      <span className="text-ink">
                        {ing.ingredient_name}
                        {ing.preparation && (
                          <span className="text-ink-light"> ({ing.preparation})</span>
                        )}
                        {ing.is_optional && (
                          <span className="text-ink-light italic"> optional</span>
                        )}
                      </span>
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>

          {/* Steps */}
          {steps.length > 0 && (
            <div className="mt-6">
              <h3 className="text-sm font-bold text-ink uppercase tracking-wide mb-3">
                Instructions
              </h3>
              <ol className="space-y-3">
                {steps.map((s) => (
                  <li key={s.id} className="flex gap-3">
                    <span className="flex-shrink-0 w-6 h-6 rounded-full bg-primary/10 text-primary-dark text-xs font-bold flex items-center justify-center mt-0.5">
                      {s.step_number}
                    </span>
                    <div>
                      <p className="text-sm text-ink leading-relaxed">{s.instruction}</p>
                      {s.duration_min && (
                        <p className="text-xs text-ink-light mt-0.5">{s.duration_min} min</p>
                      )}
                    </div>
                  </li>
                ))}
              </ol>
            </div>
          )}
        </div>

        {/* Sticky footer */}
        <div className="flex-shrink-0 p-4 border-t border-ink-light/10 bg-surface">
          {isImported ? (
            <button
              type="button"
              disabled
              className="w-full py-3 rounded-xl bg-active/10 text-active font-semibold cursor-default"
            >
              Already in Your Kitchen
            </button>
          ) : (
            <button
              type="button"
              onClick={onImport}
              disabled={isImporting}
              className="w-full py-3 rounded-xl bg-primary text-white font-semibold text-lg
                hover:bg-primary-dark transition-colors disabled:opacity-50"
            >
              {isImporting ? "Importing..." : "Import to My Kitchen"}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
