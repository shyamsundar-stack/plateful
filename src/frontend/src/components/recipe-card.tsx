import Link from "next/link";
import type { Recipe } from "@/lib/types/database";
import StatusBadge from "./status-badge";

// Warm food-inspired placeholder colors — consistent 20% opacity for visual balance
const PLACEHOLDER_COLORS = [
  "bg-primary/20 text-primary-dark",
  "bg-secondary/20 text-secondary-dark",
  "bg-accent/20 text-accent-dark",
  "bg-primary/25 text-primary-dark",
  "bg-secondary/25 text-secondary-dark",
  "bg-accent/25 text-accent-dark",
];

function getPlaceholderColor(title: string): string {
  // Simple hash based on title to get consistent color per recipe
  let hash = 0;
  for (let i = 0; i < title.length; i++) {
    hash = title.charCodeAt(i) + ((hash << 5) - hash);
  }
  return PLACEHOLDER_COLORS[Math.abs(hash) % PLACEHOLDER_COLORS.length];
}

type RecipeCardProps = {
  recipe: Recipe;
};

export default function RecipeCard({ recipe }: RecipeCardProps) {
  const mealTypes = recipe.meal_types ?? [];
  const totalTime = recipe.total_time_min;
  const placeholderColor = getPlaceholderColor(recipe.title);

  return (
    <Link
      href={`/recipes/${recipe.id}`}
      className="block group"
      aria-label={`${recipe.title}${recipe.cuisine ? `, ${recipe.cuisine}` : ""}${recipe.total_time_min ? `, ${recipe.total_time_min} minutes` : ""}`}
    >
      <div className="bg-surface rounded-xl overflow-hidden shadow-sm border border-ink-light/10 hover:shadow-md hover:-translate-y-0.5 transition-all duration-200">
        {/* Image / Placeholder */}
        <div className="relative aspect-[4/3]">
          {recipe.image_url ? (
            <img
              src={recipe.image_url}
              alt={recipe.title}
              className="w-full h-full object-cover"
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

          {/* Status Badge - top right */}
          <div className="absolute top-2 right-2">
            <StatusBadge status={recipe.status} />
          </div>

          {/* Veg/Vegan indicator - top left */}
          {(recipe.is_vegetarian || recipe.is_vegan) && (
            <div className="absolute top-2 left-2">
              <span
                className="inline-flex items-center justify-center w-6 h-6 rounded-full bg-surface/90 text-xs font-bold text-active border border-active/30"
                title={recipe.is_vegan ? "Vegan" : "Vegetarian"}
              >
                <span aria-hidden="true">{recipe.is_vegan ? "🌱" : "V"}</span>
              </span>
            </div>
          )}

          {/* Favorite heart - bottom right */}
          {recipe.is_favorite && (
            <div className="absolute bottom-2 right-2">
              <span className="inline-flex items-center justify-center w-6 h-6 rounded-full bg-surface/90">
                <svg className="w-4 h-4 fill-red-500 text-red-500" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                </svg>
              </span>
            </div>
          )}
        </div>

        {/* Content */}
        <div className="p-3">
          {/* Title */}
          <h3 className="font-semibold text-ink text-sm line-clamp-2 leading-snug group-hover:text-primary transition-colors">
            {recipe.title}
          </h3>

          {/* Cuisine + Time + Rating */}
          <div className="flex items-center gap-2 mt-1.5 text-xs text-ink-muted">
            {recipe.cuisine && (
              <span className="px-1.5 py-0.5 rounded bg-cream text-ink-muted font-medium">
                {recipe.cuisine}
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
            {recipe.rating != null && recipe.rating > 0 && (
              <span className="flex items-center gap-0.5 text-accent">
                <svg className="w-3 h-3 fill-current" viewBox="0 0 24 24">
                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
                </svg>
                {recipe.rating}
              </span>
            )}
          </div>

          {/* Meal Type Tags */}
          {mealTypes.length > 0 && (
            <div className="flex flex-wrap gap-1 mt-2">
              {mealTypes.map((type) => (
                <span
                  key={type}
                  className="px-1.5 py-0.5 rounded text-xs font-medium bg-primary/10 text-primary-dark"
                >
                  {type}
                </span>
              ))}
            </div>
          )}
        </div>
      </div>
    </Link>
  );
}
