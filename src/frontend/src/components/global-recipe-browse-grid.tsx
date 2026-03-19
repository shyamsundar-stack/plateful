"use client";

import { useState, useMemo, useCallback } from "react";
import type {
  GlobalRecipe,
  GlobalRecipeIngredient,
  GlobalRecipeStep,
} from "@/lib/types/database";
import {
  importGlobalRecipeToHousehold,
  fetchGlobalRecipeDetails,
} from "@/lib/actions/global-recipe-actions";
import GlobalRecipeCard from "./global-recipe-card";
import GlobalRecipeDetailModal from "./global-recipe-detail-modal";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const CUISINE_OPTIONS = [
  { value: "north_indian", label: "North Indian" },
  { value: "south_indian", label: "South Indian" },
  { value: "bengali", label: "Bengali" },
  { value: "gujarati", label: "Gujarati" },
  { value: "maharashtrian", label: "Maharashtrian" },
  { value: "indo_chinese", label: "Indo-Chinese" },
  { value: "continental", label: "Continental" },
  { value: "street_food", label: "Street Food" },
  { value: "punjabi", label: "Punjabi" },
  { value: "hyderabadi", label: "Hyderabadi" },
  { value: "kerala", label: "Kerala" },
  { value: "tamil", label: "Tamil" },
  { value: "chettinad", label: "Chettinad" },
  { value: "mughlai", label: "Mughlai" },
  { value: "rajasthani", label: "Rajasthani" },
  { value: "goan", label: "Goan" },
];

const MEAL_TYPE_OPTIONS = ["breakfast", "lunch", "dinner", "snack"];

// ---------------------------------------------------------------------------
// Chip component
// ---------------------------------------------------------------------------

function Chip({
  label,
  isActive,
  onClick,
}: {
  label: string;
  isActive: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`whitespace-nowrap px-3 py-1.5 rounded-full text-xs font-semibold border transition-all ${
        isActive
          ? "bg-primary text-white border-primary"
          : "bg-surface text-ink-muted border-ink-light/30 hover:border-primary/50 hover:text-ink"
      }`}
    >
      {label}
    </button>
  );
}

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

type GlobalRecipeBrowseGridProps = {
  recipes: GlobalRecipe[];
  importedTitles: Set<string>;
};

export default function GlobalRecipeBrowseGrid({
  recipes,
  importedTitles: initialImportedTitles,
}: GlobalRecipeBrowseGridProps) {
  // Filter state
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCuisines, setSelectedCuisines] = useState<string[]>([]);
  const [selectedMealTypes, setSelectedMealTypes] = useState<string[]>([]);
  const [dietaryToggle, setDietaryToggle] = useState<"all" | "veg" | "non-veg">("all");

  // Import state
  const [importedTitles, setImportedTitles] = useState<Set<string>>(initialImportedTitles);
  const [importingId, setImportingId] = useState<string | null>(null);

  // Detail modal state
  const [detailRecipeId, setDetailRecipeId] = useState<string | null>(null);
  const [detailData, setDetailData] = useState<{
    recipe: GlobalRecipe;
    ingredients: GlobalRecipeIngredient[];
    steps: GlobalRecipeStep[];
  } | null>(null);
  const [loadingDetail, setLoadingDetail] = useState(false);

  // Toggle helpers
  const toggleCuisine = useCallback((c: string) => {
    setSelectedCuisines((prev) =>
      prev.includes(c) ? prev.filter((x) => x !== c) : [...prev, c]
    );
  }, []);

  const toggleMealType = useCallback((mt: string) => {
    setSelectedMealTypes((prev) =>
      prev.includes(mt) ? prev.filter((x) => x !== mt) : [...prev, mt]
    );
  }, []);

  // Available cuisines (only show chips for cuisines that exist in data)
  const availableCuisines = useMemo(() => {
    const cuisineSet = new Set(recipes.map((r) => r.cuisine).filter(Boolean) as string[]);
    return CUISINE_OPTIONS.filter((c) => cuisineSet.has(c.value));
  }, [recipes]);

  // Filter recipes
  const filteredRecipes = useMemo(() => {
    return recipes.filter((r) => {
      // Search
      if (
        searchQuery &&
        !r.title.toLowerCase().includes(searchQuery.toLowerCase()) &&
        !(r.description ?? "").toLowerCase().includes(searchQuery.toLowerCase())
      ) {
        return false;
      }
      // Cuisine
      if (selectedCuisines.length > 0 && (!r.cuisine || !selectedCuisines.includes(r.cuisine))) {
        return false;
      }
      // Meal type
      if (
        selectedMealTypes.length > 0 &&
        !selectedMealTypes.some((mt) => r.meal_types?.includes(mt))
      ) {
        return false;
      }
      // Dietary
      if (dietaryToggle === "veg" && !r.is_vegetarian) return false;
      if (dietaryToggle === "non-veg" && r.is_vegetarian) return false;

      return true;
    });
  }, [recipes, searchQuery, selectedCuisines, selectedMealTypes, dietaryToggle]);

  // Has any filter active?
  const hasActiveFilters =
    searchQuery !== "" ||
    selectedCuisines.length > 0 ||
    selectedMealTypes.length > 0 ||
    dietaryToggle !== "all";

  // Import handler
  async function handleImport(recipe: GlobalRecipe) {
    setImportingId(recipe.id);
    try {
      await importGlobalRecipeToHousehold(recipe.id);
      setImportedTitles((prev) => {
        const next = new Set(Array.from(prev));
        next.add(recipe.title);
        return next;
      });
    } catch (err) {
      alert(err instanceof Error ? err.message : "Failed to import recipe");
    } finally {
      setImportingId(null);
    }
  }

  // View details handler
  async function handleViewDetails(recipe: GlobalRecipe) {
    setDetailRecipeId(recipe.id);
    setLoadingDetail(true);
    try {
      const data = await fetchGlobalRecipeDetails(recipe.id);
      setDetailData(data);
    } catch {
      alert("Failed to load recipe details");
      setDetailRecipeId(null);
    } finally {
      setLoadingDetail(false);
    }
  }

  function closeDetail() {
    setDetailRecipeId(null);
    setDetailData(null);
  }

  return (
    <div className="space-y-4">
      {/* Search Bar */}
      <div className="relative">
        <svg
          className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-ink-light"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
          strokeWidth={2}
        >
          <circle cx="11" cy="11" r="8" />
          <line x1="21" y1="21" x2="16.65" y2="16.65" />
        </svg>
        <input
          type="text"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          placeholder="Search library recipes..."
          className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink text-sm placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary transition-all"
        />
        {searchQuery && (
          <button
            onClick={() => setSearchQuery("")}
            className="absolute right-3 top-1/2 -translate-y-1/2 text-ink-light hover:text-ink"
          >
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </button>
        )}
      </div>

      {/* Dietary toggle */}
      <div className="flex gap-1 bg-cream rounded-lg p-1">
        {(["all", "veg", "non-veg"] as const).map((opt) => (
          <button
            key={opt}
            onClick={() => setDietaryToggle(opt)}
            className={`flex-1 py-2 rounded-md text-xs font-semibold transition-all ${
              dietaryToggle === opt
                ? "bg-surface text-ink shadow-sm"
                : "text-ink-muted hover:text-ink"
            }`}
          >
            {opt === "all" ? "All" : opt === "veg" ? "Veg" : "Non-Veg"}
          </button>
        ))}
      </div>

      {/* Filter chips */}
      <div className="relative">
        <div className="pointer-events-none absolute right-0 top-0 bottom-1 w-8 bg-gradient-to-l from-cream to-transparent z-10" />
        <div className="flex gap-2 overflow-x-auto hide-scrollbar pb-1">
          {/* Cuisine chips */}
          {availableCuisines.map((c) => (
            <Chip
              key={c.value}
              label={c.label}
              isActive={selectedCuisines.includes(c.value)}
              onClick={() => toggleCuisine(c.value)}
            />
          ))}

          {availableCuisines.length > 0 && (
            <div className="w-px bg-ink-light/40 mx-1 self-stretch" />
          )}

          {/* Meal type chips */}
          {MEAL_TYPE_OPTIONS.map((mt) => (
            <Chip
              key={mt}
              label={mt.charAt(0).toUpperCase() + mt.slice(1)}
              isActive={selectedMealTypes.includes(mt)}
              onClick={() => toggleMealType(mt)}
            />
          ))}

          {/* Clear all */}
          {hasActiveFilters && (
            <>
              <div className="w-px bg-ink-light/40 mx-1 self-stretch" />
              <button
                onClick={() => {
                  setSearchQuery("");
                  setSelectedCuisines([]);
                  setSelectedMealTypes([]);
                  setDietaryToggle("all");
                }}
                className="whitespace-nowrap px-3 py-1.5 rounded-full text-xs font-semibold text-red-500 hover:bg-red-50 transition-all"
              >
                Clear All
              </button>
            </>
          )}
        </div>
      </div>

      {/* Results count */}
      <p className="text-xs text-ink-muted">
        {filteredRecipes.length} recipe{filteredRecipes.length !== 1 ? "s" : ""} found
      </p>

      {/* Grid */}
      {filteredRecipes.length === 0 ? (
        <div className="text-center py-16">
          <span className="text-5xl">🍳</span>
          <h3 className="text-lg font-semibold text-ink mt-4">No recipes found</h3>
          <p className="text-ink-muted mt-2 text-sm">
            Try adjusting your filters or search query.
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
          {filteredRecipes.map((recipe) => (
            <GlobalRecipeCard
              key={recipe.id}
              recipe={recipe}
              isImported={importedTitles.has(recipe.title)}
              isImporting={importingId === recipe.id}
              onImport={() => handleImport(recipe)}
              onViewDetails={() => handleViewDetails(recipe)}
            />
          ))}
        </div>
      )}

      {/* Detail modal */}
      {detailRecipeId && detailData && !loadingDetail && (
        <GlobalRecipeDetailModal
          recipe={detailData.recipe}
          ingredients={detailData.ingredients}
          steps={detailData.steps}
          isImported={importedTitles.has(detailData.recipe.title)}
          isImporting={importingId === detailData.recipe.id}
          onImport={() => handleImport(detailData.recipe)}
          onClose={closeDetail}
        />
      )}

      {/* Loading detail overlay */}
      {loadingDetail && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30">
          <div className="bg-surface rounded-xl p-6 shadow-xl flex items-center gap-3">
            <svg className="animate-spin w-5 h-5 text-primary" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" />
            </svg>
            <span className="text-sm text-ink">Loading recipe...</span>
          </div>
        </div>
      )}
    </div>
  );
}
