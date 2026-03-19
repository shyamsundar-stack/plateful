import Link from "next/link";
import Header from "@/components/header";
import GlobalRecipeBrowseGrid from "@/components/global-recipe-browse-grid";
import {
  fetchGlobalRecipes,
  getImportedRecipeTitles,
} from "@/lib/actions/global-recipe-actions";
import type { GlobalRecipe } from "@/lib/types/database";

export default async function BrowseRecipesPage() {
  let recipes: GlobalRecipe[] = [];
  let importedTitles = new Set<string>();
  let error: string | null = null;

  try {
    [recipes, importedTitles] = await Promise.all([
      fetchGlobalRecipes(),
      getImportedRecipeTitles(),
    ]);
  } catch (err) {
    error = err instanceof Error ? err.message : "Failed to load library recipes";
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />

      <main className="max-w-5xl mx-auto px-4 py-6">
        {/* Page Title */}
        <div className="flex items-center justify-between mb-6">
          <div>
            <h2 className="text-2xl font-bold text-ink">Recipe Library</h2>
            <p className="text-sm text-ink-muted mt-1">
              Browse curated recipes and import them to your kitchen
            </p>
          </div>
          <Link
            href="/recipes"
            className="px-4 py-2 rounded-lg border border-ink-light/20 text-ink-muted text-sm font-semibold hover:bg-surface transition-colors"
          >
            My Recipes
          </Link>
        </div>

        {/* Error State */}
        {error ? (
          <div className="text-center py-16">
            <span className="text-5xl">😕</span>
            <h3 className="text-lg font-semibold text-ink mt-4">
              Something went wrong
            </h3>
            <p className="text-ink-muted mt-2 text-sm">{error}</p>
          </div>
        ) : recipes.length === 0 ? (
          <div className="text-center py-16">
            <span className="text-5xl">📚</span>
            <h3 className="text-lg font-semibold text-ink mt-4">
              Library is empty
            </h3>
            <p className="text-ink-muted mt-2 text-sm">
              The global recipe library hasn&apos;t been populated yet. Check back soon!
            </p>
          </div>
        ) : (
          <GlobalRecipeBrowseGrid
            recipes={recipes}
            importedTitles={importedTitles}
          />
        )}
      </main>
    </div>
  );
}
