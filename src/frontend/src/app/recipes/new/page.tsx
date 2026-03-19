"use client";

import { useState, useEffect } from "react";
import Header from "@/components/header";
import BackButton from "@/components/back-button";
import TabSwitcher from "@/components/tab-switcher";
import RecipeForm from "@/components/recipe-form";
import ImportPasteForm from "@/components/import-paste-form";
import ImportUrlForm from "@/components/import-url-form";
import { useHouseholdId } from "@/lib/hooks/use-household-id";
import { fetchHouseholdIngredients } from "@/lib/actions/recipe-actions";
import type { Ingredient } from "@/lib/types/database";

const TABS = [
  { key: "manual", label: "Manual Entry" },
  { key: "paste", label: "Paste Recipe" },
  { key: "url", label: "Import URL" },
];

export default function NewRecipePage() {
  const [activeTab, setActiveTab] = useState("manual");
  const { householdId, loading: householdLoading, error: householdError } =
    useHouseholdId();

  // Fetch ingredients for manual entry tab (needed for autocomplete)
  const [ingredients, setIngredients] = useState<Ingredient[]>([]);
  const [ingredientsLoading, setIngredientsLoading] = useState(true);

  useEffect(() => {
    async function loadIngredients() {
      try {
        const data = await fetchHouseholdIngredients();
        setIngredients(data);
      } catch {
        // Non-blocking — manual entry will just lack autocomplete
      } finally {
        setIngredientsLoading(false);
      }
    }
    loadIngredients();
  }, []);

  return (
    <div className="min-h-screen bg-cream">
      <Header />
      <main className="max-w-3xl mx-auto px-4 py-6">
        <BackButton href="/recipes" label="Back to Recipes" />

        <h2 className="text-2xl font-bold text-ink mb-6">Add Recipe</h2>

        {/* Household error */}
        {householdError && (
          <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm mb-4">
            {householdError}
          </div>
        )}

        {/* Tabs */}
        <div className="mb-6">
          <TabSwitcher
            tabs={TABS}
            activeTab={activeTab}
            onTabChange={setActiveTab}
          />
        </div>

        {/* Tab Content */}
        {activeTab === "manual" && (
          <div>
            {householdLoading || ingredientsLoading ? (
              <div className="text-center py-8 text-ink-muted text-sm">
                Loading...
              </div>
            ) : householdId ? (
              <RecipeForm
                mode="create"
                householdId={householdId}
                householdIngredients={ingredients}
              />
            ) : (
              <div className="text-center py-8 text-ink-muted text-sm">
                Unable to load household. Please try refreshing.
              </div>
            )}
          </div>
        )}

        {activeTab === "paste" && (
          <ImportPasteForm
            householdId={householdId}
            loading={householdLoading}
          />
        )}

        {activeTab === "url" && (
          <ImportUrlForm
            householdId={householdId}
            loading={householdLoading}
          />
        )}
      </main>
    </div>
  );
}
