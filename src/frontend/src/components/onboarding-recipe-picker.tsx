"use client";

import { useState, useMemo } from "react";
import type { GlobalRecipe } from "@/lib/types/database";
import GlobalRecipeCard from "./global-recipe-card";

type OnboardingRecipePickerProps = {
  recipes: GlobalRecipe[];
  onImportSelected: (selectedIds: string[]) => Promise<void>;
  importing: boolean;
};

export default function OnboardingRecipePicker({
  recipes,
  onImportSelected,
  importing,
}: OnboardingRecipePickerProps) {
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [dietaryToggle, setDietaryToggle] = useState<"all" | "veg" | "non-veg">("all");
  const [searchQuery, setSearchQuery] = useState("");

  // Filter recipes
  const filteredRecipes = useMemo(() => {
    return recipes.filter((r) => {
      if (dietaryToggle === "veg" && !r.is_vegetarian) return false;
      if (dietaryToggle === "non-veg" && r.is_vegetarian) return false;
      if (
        searchQuery &&
        !r.title.toLowerCase().includes(searchQuery.toLowerCase())
      ) {
        return false;
      }
      return true;
    });
  }, [recipes, dietaryToggle, searchQuery]);

  function toggleSelect(id: string) {
    setSelectedIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) {
        next.delete(id);
      } else {
        next.add(id);
      }
      return next;
    });
  }

  async function handleImport() {
    if (selectedIds.size === 0) return;
    await onImportSelected(Array.from(selectedIds));
  }

  return (
    <div className="space-y-4">
      {/* Search */}
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
          placeholder="Search recipes..."
          className="w-full pl-10 pr-4 py-2 rounded-lg border border-ink-light/30 bg-surface text-ink text-sm
            placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50"
        />
      </div>

      {/* Dietary toggle */}
      <div className="flex gap-1 bg-cream rounded-lg p-1">
        {(["all", "veg", "non-veg"] as const).map((opt) => (
          <button
            key={opt}
            onClick={() => setDietaryToggle(opt)}
            className={`flex-1 py-1.5 rounded-md text-xs font-semibold transition-all ${
              dietaryToggle === opt
                ? "bg-surface text-ink shadow-sm"
                : "text-ink-muted hover:text-ink"
            }`}
          >
            {opt === "all" ? "All" : opt === "veg" ? "Veg" : "Non-Veg"}
          </button>
        ))}
      </div>

      {/* Grid */}
      <div
        className="grid grid-cols-2 gap-3 max-h-[40vh] overflow-y-auto pr-1"
        style={{ scrollbarWidth: "thin" }}
      >
        {filteredRecipes.map((recipe) => (
          <GlobalRecipeCard
            key={recipe.id}
            recipe={recipe}
            isImported={false}
            isImporting={false}
            onImport={() => {}}
            onViewDetails={() => {}}
            selectable
            isSelected={selectedIds.has(recipe.id)}
            onToggleSelect={() => toggleSelect(recipe.id)}
          />
        ))}
      </div>

      {filteredRecipes.length === 0 && (
        <p className="text-center text-sm text-ink-muted py-4">
          No recipes match your search.
        </p>
      )}

      {/* Import button */}
      <button
        type="button"
        onClick={handleImport}
        disabled={selectedIds.size === 0 || importing}
        className="w-full py-3 rounded-xl bg-primary text-white font-semibold
          hover:bg-primary-dark transition-colors disabled:opacity-50"
      >
        {importing
          ? "Importing..."
          : selectedIds.size > 0
          ? `Import ${selectedIds.size} Recipe${selectedIds.size > 1 ? "s" : ""} & Continue`
          : "Select recipes to import"}
      </button>
    </div>
  );
}
