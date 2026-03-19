"use client";

import { useState, useRef, useEffect } from "react";
import type { Ingredient } from "@/lib/types/database";
import { createIngredient } from "@/lib/actions/recipe-actions";

type IngredientSearchProps = {
  ingredients: Ingredient[];
  householdId: string;
  value: string; // current ingredient name display
  onSelect: (ingredient: Ingredient) => void;
  onNewIngredient?: (ingredient: Ingredient) => void; // called when a new ingredient is created
};

export default function IngredientSearch({
  ingredients,
  householdId,
  value,
  onSelect,
  onNewIngredient,
}: IngredientSearchProps) {
  const [query, setQuery] = useState(value);
  const [isOpen, setIsOpen] = useState(false);
  const [creating, setCreating] = useState(false);
  const wrapperRef = useRef<HTMLDivElement>(null);

  // Close dropdown when clicking outside
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (wrapperRef.current && !wrapperRef.current.contains(e.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  // Filter ingredients by query (name + aliases)
  const filtered = query.trim()
    ? ingredients
        .filter((ing) => {
          const q = query.toLowerCase();
          if (ing.name.toLowerCase().includes(q)) return true;
          if (ing.aliases?.some((a) => a.toLowerCase().includes(q))) return true;
          return false;
        })
        .slice(0, 10) // Show top 10 matches
    : [];

  const exactMatch = ingredients.some(
    (ing) => ing.name.toLowerCase() === query.trim().toLowerCase()
  );

  async function handleCreateNew() {
    if (!query.trim()) return;
    setCreating(true);
    try {
      const newIngredient = await createIngredient(householdId, query.trim());
      onSelect(newIngredient);
      onNewIngredient?.(newIngredient);
      setIsOpen(false);
    } catch {
      // Silently fail — user can try again
    } finally {
      setCreating(false);
    }
  }

  return (
    <div ref={wrapperRef} className="relative">
      <input
        type="text"
        value={query}
        onChange={(e) => {
          setQuery(e.target.value);
          setIsOpen(true);
        }}
        onFocus={() => query.trim() && setIsOpen(true)}
        placeholder="Search ingredient..."
        className="w-full px-2 py-1.5 rounded border border-ink-light/30 bg-surface text-ink text-sm placeholder:text-ink-light focus:outline-none focus:ring-1 focus:ring-primary/50 focus:border-primary transition-all"
      />

      {/* Dropdown */}
      {isOpen && query.trim() && (
        <div className="absolute z-30 top-full left-0 right-0 mt-1 bg-surface border border-ink-light/20 rounded-lg shadow-lg max-h-48 overflow-y-auto">
          {filtered.map((ing) => (
            <button
              key={ing.id}
              type="button"
              onClick={() => {
                setQuery(ing.name);
                onSelect(ing);
                setIsOpen(false);
              }}
              className="w-full text-left px-3 py-2 text-sm text-ink hover:bg-cream transition-colors"
            >
              {ing.name}
              {ing.category && (
                <span className="text-xs text-ink-light ml-2">
                  ({ing.category})
                </span>
              )}
            </button>
          ))}

          {/* Add new option */}
          {!exactMatch && query.trim().length >= 2 && (
            <button
              type="button"
              onClick={handleCreateNew}
              disabled={creating}
              className="w-full text-left px-3 py-2 text-sm text-primary font-medium hover:bg-primary/5 transition-colors border-t border-ink-light/10"
            >
              {creating ? "Creating..." : `+ Add "${query.trim()}" as new ingredient`}
            </button>
          )}

          {filtered.length === 0 && exactMatch && (
            <div className="px-3 py-2 text-sm text-ink-light">
              No more matches
            </div>
          )}
        </div>
      )}
    </div>
  );
}
