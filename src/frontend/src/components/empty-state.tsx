import Link from "next/link";

type EmptyStateProps = {
  type: "no-recipes" | "no-matches";
  onClearFilters?: () => void;
};

export default function EmptyState({ type, onClearFilters }: EmptyStateProps) {
  if (type === "no-matches") {
    return (
      <div className="text-center py-16 px-4">
        <span className="text-5xl" role="img" aria-label="magnifying glass">
          🔍
        </span>
        <h2 className="text-lg font-semibold text-ink mt-4">
          No recipes match your filters
        </h2>
        <p className="text-ink-muted mt-2 text-sm">
          Try adjusting your search or clearing filters
        </p>
        {onClearFilters && (
          <button
            onClick={onClearFilters}
            className="mt-4 px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors"
          >
            Clear All Filters
          </button>
        )}
      </div>
    );
  }

  // No recipes at all
  return (
    <div className="text-center py-16 px-4">
      <span className="text-6xl" role="img" aria-label="cooking">
        👩‍🍳
      </span>
      <h2 className="text-lg font-semibold text-ink mt-4">
        Your recipe collection is empty
      </h2>
      <p className="text-ink-muted mt-2 text-sm max-w-xs mx-auto">
        Start by adding your first recipe — paste a recipe, import from a URL,
        or create one manually.
      </p>
      <Link
        href="/recipes/new"
        className="inline-block mt-4 px-6 py-2.5 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors"
      >
        Add Your First Recipe
      </Link>
    </div>
  );
}
