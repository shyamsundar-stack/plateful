import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import type { Recipe } from "@/lib/types/database";
import Header from "@/components/header";
import RecipeGrid from "@/components/recipe-grid";

export default async function RecipesPage() {
  let recipes: Recipe[] = [];
  let error: string | null = null;

  try {
    const supabase = await createClient();

    const { data, error: fetchError } = await supabase
      .from("recipes")
      .select("*")
      .neq("status", "archived")
      .order("created_at", { ascending: false });

    if (fetchError) {
      error = fetchError.message;
    } else {
      recipes = (data as Recipe[]) ?? [];
    }
  } catch {
    error = "Failed to load recipes. Please try again.";
  }

  return (
    <div className="min-h-screen bg-cream">
      <Header />

      <main className="max-w-5xl mx-auto px-4 py-6">
        {/* Page Title */}
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-2xl font-bold text-ink">My Recipes</h2>
          <div className="flex gap-2">
            <Link
              href="/recipes/browse"
              className="px-4 py-2 rounded-lg border border-primary text-primary text-sm font-semibold hover:bg-primary/5 transition-colors"
            >
              Browse Library
            </Link>
            <Link
              href="/recipes/new"
              className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors"
            >
              + Add Recipe
            </Link>
          </div>
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
        ) : (
          <RecipeGrid recipes={recipes} />
        )}
      </main>
    </div>
  );
}
