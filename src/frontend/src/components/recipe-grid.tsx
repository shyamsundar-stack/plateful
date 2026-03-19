"use client";

import { useState, useMemo } from "react";
import type { Recipe } from "@/lib/types/database";
import RecipeCard from "./recipe-card";
import RecipeFilters from "./recipe-filters";
import EmptyState from "./empty-state";

type RecipeGridProps = {
  recipes: Recipe[];
};

export default function RecipeGrid({ recipes }: RecipeGridProps) {
  // Filter state
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedStatuses, setSelectedStatuses] = useState<string[]>([]);
  const [selectedCuisines, setSelectedCuisines] = useState<string[]>([]);
  const [selectedMealTypes, setSelectedMealTypes] = useState<string[]>([]);
  const [showVegOnly, setShowVegOnly] = useState(false);
  const [showVeganOnly, setShowVeganOnly] = useState(false);
  const [showFavoritesOnly, setShowFavoritesOnly] = useState(false);

  // Extract unique cuisines from data (dynamic, not hardcoded)
  const availableCuisines = useMemo(() => {
    const cuisines = new Set<string>();
    recipes.forEach((r) => {
      if (r.cuisine) cuisines.add(r.cuisine);
    });
    return Array.from(cuisines).sort();
  }, [recipes]);

  // Check if any filter is active
  const hasActiveFilters =
    searchQuery !== "" ||
    selectedStatuses.length > 0 ||
    selectedCuisines.length > 0 ||
    selectedMealTypes.length > 0 ||
    showVegOnly ||
    showVeganOnly ||
    showFavoritesOnly;

  // Filter recipes
  const filteredRecipes = useMemo(() => {
    return recipes.filter((recipe) => {
      // Search by title
      if (
        searchQuery &&
        !recipe.title.toLowerCase().includes(searchQuery.toLowerCase())
      ) {
        return false;
      }

      // Filter by status
      if (
        selectedStatuses.length > 0 &&
        !selectedStatuses.includes(recipe.status)
      ) {
        return false;
      }

      // Filter by cuisine
      if (
        selectedCuisines.length > 0 &&
        (!recipe.cuisine || !selectedCuisines.includes(recipe.cuisine))
      ) {
        return false;
      }

      // Filter by meal type
      if (selectedMealTypes.length > 0) {
        const recipeMealTypes = recipe.meal_types ?? [];
        if (!selectedMealTypes.some((t) => recipeMealTypes.includes(t))) {
          return false;
        }
      }

      // Filter by veg
      if (showVegOnly && !recipe.is_vegetarian) {
        return false;
      }

      // Filter by vegan
      if (showVeganOnly && !recipe.is_vegan) {
        return false;
      }

      // Filter by favorites
      if (showFavoritesOnly && !recipe.is_favorite) {
        return false;
      }

      return true;
    });
  }, [
    recipes,
    searchQuery,
    selectedStatuses,
    selectedCuisines,
    selectedMealTypes,
    showVegOnly,
    showVeganOnly,
    showFavoritesOnly,
  ]);

  // Toggle helpers
  function toggleInArray(arr: string[], value: string): string[] {
    return arr.includes(value)
      ? arr.filter((v) => v !== value)
      : [...arr, value];
  }

  function clearAllFilters() {
    setSearchQuery("");
    setSelectedStatuses([]);
    setSelectedCuisines([]);
    setSelectedMealTypes([]);
    setShowVegOnly(false);
    setShowVeganOnly(false);
    setShowFavoritesOnly(false);
  }

  // No recipes at all
  if (recipes.length === 0) {
    return <EmptyState type="no-recipes" />;
  }

  return (
    <div>
      {/* Filters */}
      <RecipeFilters
        searchQuery={searchQuery}
        onSearchChange={setSearchQuery}
        selectedStatuses={selectedStatuses}
        onToggleStatus={(s) => setSelectedStatuses(toggleInArray(selectedStatuses, s))}
        availableCuisines={availableCuisines}
        selectedCuisines={selectedCuisines}
        onToggleCuisine={(c) => setSelectedCuisines(toggleInArray(selectedCuisines, c))}
        selectedMealTypes={selectedMealTypes}
        onToggleMealType={(t) => setSelectedMealTypes(toggleInArray(selectedMealTypes, t))}
        showVegOnly={showVegOnly}
        onToggleVeg={() => setShowVegOnly(!showVegOnly)}
        showVeganOnly={showVeganOnly}
        onToggleVegan={() => setShowVeganOnly(!showVeganOnly)}
        showFavoritesOnly={showFavoritesOnly}
        onToggleFavorites={() => setShowFavoritesOnly(!showFavoritesOnly)}
        hasActiveFilters={hasActiveFilters}
        onClearAll={clearAllFilters}
      />

      {/* Recipe count */}
      <div className="mt-4 mb-3 text-sm text-ink-muted">
        {filteredRecipes.length} of {recipes.length} recipe
        {recipes.length !== 1 ? "s" : ""}
      </div>

      {/* Grid or Empty */}
      {filteredRecipes.length === 0 ? (
        <EmptyState type="no-matches" onClearFilters={clearAllFilters} />
      ) : (
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
          {filteredRecipes.map((recipe) => (
            <RecipeCard key={recipe.id} recipe={recipe} />
          ))}
        </div>
      )}
    </div>
  );
}
