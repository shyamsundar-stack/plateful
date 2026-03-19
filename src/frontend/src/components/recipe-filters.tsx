"use client";

type FilterChip = {
  label: string;
  value: string;
  isActive: boolean;
  onClick: () => void;
};

function Chip({ label, isActive, onClick }: FilterChip) {
  return (
    <button
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

type RecipeFiltersProps = {
  searchQuery: string;
  onSearchChange: (query: string) => void;
  // Status filters
  selectedStatuses: string[];
  onToggleStatus: (status: string) => void;
  // Cuisine filters (dynamic from data)
  availableCuisines: string[];
  selectedCuisines: string[];
  onToggleCuisine: (cuisine: string) => void;
  // Meal type filters
  selectedMealTypes: string[];
  onToggleMealType: (type: string) => void;
  // Diet filters
  showVegOnly: boolean;
  onToggleVeg: () => void;
  showVeganOnly: boolean;
  onToggleVegan: () => void;
  // Favorites
  showFavoritesOnly: boolean;
  onToggleFavorites: () => void;
  // Clear all
  hasActiveFilters: boolean;
  onClearAll: () => void;
};

const MEAL_TYPES = ["breakfast", "lunch", "dinner", "snack"];

export default function RecipeFilters({
  searchQuery,
  onSearchChange,
  selectedStatuses,
  onToggleStatus,
  availableCuisines,
  selectedCuisines,
  onToggleCuisine,
  selectedMealTypes,
  onToggleMealType,
  showVegOnly,
  onToggleVeg,
  showVeganOnly,
  onToggleVegan,
  showFavoritesOnly,
  onToggleFavorites,
  hasActiveFilters,
  onClearAll,
}: RecipeFiltersProps) {
  return (
    <div className="space-y-3">
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
          onChange={(e) => onSearchChange(e.target.value)}
          placeholder="Search recipes..."
          className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink text-sm placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary transition-all"
        />
        {searchQuery && (
          <button
            onClick={() => onSearchChange("")}
            className="absolute right-3 top-1/2 -translate-y-1/2 text-ink-light hover:text-ink"
          >
            <svg
              className="w-4 h-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              strokeWidth={2}
            >
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </button>
        )}
      </div>

      {/* Filter Chips — horizontally scrollable with fade hint */}
      <div className="relative">
        {/* Right-fade gradient — hints that chips continue off screen */}
        <div className="pointer-events-none absolute right-0 top-0 bottom-1 w-8 bg-gradient-to-l from-cream to-transparent z-10" />
      <div
        className="flex gap-2 overflow-x-auto hide-scrollbar pb-1"
        role="group"
        aria-label="Filter chips — scroll to see more"
      >
        {/* Status */}
        <Chip
          label="Draft"
          value="draft"
          isActive={selectedStatuses.includes("draft")}
          onClick={() => onToggleStatus("draft")}
        />
        <Chip
          label="Active"
          value="active"
          isActive={selectedStatuses.includes("active")}
          onClick={() => onToggleStatus("active")}
        />

        {/* Divider */}
        <div className="w-px bg-ink-light/40 mx-1 self-stretch" />

        {/* Cuisines (dynamic) */}
        {availableCuisines.map((cuisine) => (
          <Chip
            key={cuisine}
            label={cuisine}
            value={cuisine}
            isActive={selectedCuisines.includes(cuisine)}
            onClick={() => onToggleCuisine(cuisine)}
          />
        ))}

        {availableCuisines.length > 0 && (
          <div className="w-px bg-ink-light/40 mx-1 self-stretch" />
        )}

        {/* Meal Types */}
        {MEAL_TYPES.map((type) => (
          <Chip
            key={type}
            label={type.charAt(0).toUpperCase() + type.slice(1)}
            value={type}
            isActive={selectedMealTypes.includes(type)}
            onClick={() => onToggleMealType(type)}
          />
        ))}

        {/* Divider */}
        <div className="w-px bg-ink-light/40 mx-1 self-stretch" />

        {/* Diet */}
        <Chip
          label="Veg"
          value="veg"
          isActive={showVegOnly}
          onClick={onToggleVeg}
        />
        <Chip
          label="Vegan"
          value="vegan"
          isActive={showVeganOnly}
          onClick={onToggleVegan}
        />

        {/* Divider */}
        <div className="w-px bg-ink-light/40 mx-1 self-stretch" />

        {/* Favorites */}
        <Chip
          label="Favorites"
          value="favorites"
          isActive={showFavoritesOnly}
          onClick={onToggleFavorites}
        />

        {/* Clear All */}
        {hasActiveFilters && (
          <>
            <div className="w-px bg-ink-light/40 mx-1 self-stretch" />
            <button
              onClick={onClearAll}
              className="whitespace-nowrap px-3 py-1.5 rounded-full text-xs font-semibold text-red-500 hover:bg-red-50 transition-all"
            >
              Clear All
            </button>
          </>
        )}
      </div>
      </div>
    </div>
  );
}
