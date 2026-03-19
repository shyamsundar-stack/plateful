"use client";

import type { GlobalRecipe } from "@/lib/types/database";

// Warm food-inspired placeholder colors — consistent with recipe-card.tsx
const PLACEHOLDER_COLORS = [
  "bg-primary/20 text-primary-dark",
  "bg-secondary/20 text-secondary-dark",
  "bg-accent/20 text-accent-dark",
  "bg-primary/25 text-primary-dark",
  "bg-secondary/25 text-secondary-dark",
  "bg-accent/25 text-accent-dark",
];

function getPlaceholderColor(title: string): string {
  let hash = 0;
  for (let i = 0; i < title.length; i++) {
    hash = title.charCodeAt(i) + ((hash << 5) - hash);
  }
  return PLACEHOLDER_COLORS[Math.abs(hash) % PLACEHOLDER_COLORS.length];
}

type GlobalRecipeCardProps = {
  recipe: GlobalRecipe;
  isImported: boolean;
  isImporting: boolean;
  onImport: () => void;
  onViewDetails: () => void;
  /** Multi-select mode for onboarding */
  selectable?: boolean;
  isSelected?: boolean;
  onToggleSelect?: () => void;
};

export default function GlobalRecipeCard({
  recipe,
  isImported,
  isImporting,
  onImport,
  onViewDetails,
  selectable = false,
  isSelected = false,
  onToggleSelect,
}: GlobalRecipeCardProps) {
  const totalTime = recipe.total_time_min;
  const placeholderColor = getPlaceholderColor(recipe.title);

  return (
    <div className="bg-surface rounded-xl overflow-hidden shadow-sm border border-ink-light/10 hover:shadow-md hover:-translate-y-0.5 transition-all duration-200">
      {/* Image / Placeholder */}
      <button
        type="button"
        onClick={selectable ? onToggleSelect : onViewDetails}
        className="relative aspect-[4/3] w-full block cursor-pointer"
      >
        {recipe.image_url ? (
          <img
            src={recipe.image_url}
            alt={recipe.title}
            className="w-full h-full object-cover"
            loading="lazy"
          />
        ) : (
          <div
            className={`w-full h-full flex items-center justify-center ${placeholderColor}`}
          >
            <span className="text-4xl font-bold opacity-60">
              {recipe.title.charAt(0).toUpperCase()}
            </span>
          </div>
        )}

        {/* Veg/Non-veg indicator - top left */}
        <div className="absolute top-2 left-2">
          <span
            className={`inline-flex items-center justify-center w-6 h-6 rounded-full bg-surface/90 text-xs font-bold border ${
              recipe.is_vegetarian
                ? "text-active border-active/30"
                : "text-red-500 border-red-500/30"
            }`}
            title={recipe.is_vegan ? "Vegan" : recipe.is_vegetarian ? "Vegetarian" : "Non-Vegetarian"}
          >
            {recipe.is_vegan ? "V+" : recipe.is_vegetarian ? "V" : "NV"}
          </span>
        </div>

        {/* Difficulty badge - top right */}
        <div className="absolute top-2 right-2">
          <span
            className={`px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wide ${
              recipe.difficulty === "easy"
                ? "bg-active/20 text-active-dark"
                : recipe.difficulty === "hard"
                ? "bg-red-100 text-red-700"
                : "bg-accent/20 text-accent-dark"
            }`}
          >
            {recipe.difficulty}
          </span>
        </div>

        {/* Selection overlay for onboarding multi-select */}
        {selectable && isSelected && (
          <div className="absolute inset-0 bg-primary/20 flex items-center justify-center">
            <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center shadow-lg">
              <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                <polyline points="20 6 9 17 4 12" />
              </svg>
            </div>
          </div>
        )}
      </button>

      {/* Content */}
      <div className="p-3">
        {/* Title */}
        <h3 className="font-semibold text-ink text-sm line-clamp-2 leading-snug">
          {recipe.title}
        </h3>

        {/* Cuisine + Time */}
        <div className="flex items-center gap-2 mt-1.5 text-xs text-ink-muted">
          {recipe.cuisine && (
            <span className="px-1.5 py-0.5 rounded bg-cream text-ink-muted font-medium">
              {recipe.cuisine.replace(/_/g, " ")}
            </span>
          )}
          {totalTime && totalTime > 0 && (
            <span className="flex items-center gap-0.5">
              <svg
                className="w-3 h-3"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <circle cx="12" cy="12" r="10" />
                <polyline points="12 6 12 12 16 14" />
              </svg>
              {totalTime}m
            </span>
          )}
          {recipe.servings > 0 && (
            <span className="flex items-center gap-0.5">
              <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
                <circle cx="9" cy="7" r="4" />
              </svg>
              {recipe.servings}
            </span>
          )}
        </div>

        {/* Import / Imported button */}
        <div className="mt-3">
          {selectable ? (
            <button
              type="button"
              onClick={onToggleSelect}
              className={`w-full py-2 rounded-lg text-xs font-semibold transition-colors ${
                isSelected
                  ? "bg-primary text-white"
                  : "bg-cream text-ink-muted hover:bg-primary/10 hover:text-primary"
              }`}
            >
              {isSelected ? "Selected" : "Select"}
            </button>
          ) : isImported ? (
            <button
              type="button"
              disabled
              className="w-full py-2 rounded-lg bg-active/10 text-active text-xs font-semibold cursor-default"
            >
              Already Imported
            </button>
          ) : (
            <button
              type="button"
              onClick={onImport}
              disabled={isImporting}
              className="w-full py-2 rounded-lg bg-primary text-white text-xs font-semibold
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
