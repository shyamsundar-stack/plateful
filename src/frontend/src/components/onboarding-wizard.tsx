"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Household, HouseholdMember, GlobalRecipe } from "@/lib/types/database";
import {
  updateHouseholdNameOnboarding,
  updateMemberOnboarding,
  addMemberOnboarding,
  completeOnboarding,
} from "@/lib/actions/onboarding-actions";
import { batchImportGlobalRecipes } from "@/lib/actions/global-recipe-actions";
import OnboardingRecipePicker from "./onboarding-recipe-picker";

const STEPS = [
  "Name Your Kitchen",
  "Your Family",
  "Pick Recipes",
  "All Set!",
];

const DIETARY_MODE_OPTIONS = [
  { value: "non_vegetarian", label: "Non-Veg" },
  { value: "vegetarian", label: "Vegetarian" },
  { value: "eggetarian", label: "Eggetarian" },
  { value: "vegan", label: "Vegan" },
] as const;

type MemberForm = {
  id?: string; // existing member ID (undefined for new)
  name: string;
  age: string;
  dietary_notes: string;
  dietary_mode: "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan";
};

export default function OnboardingWizard({
  household,
  members,
  globalRecipes = [],
}: {
  household: Household;
  members: HouseholdMember[];
  globalRecipes?: GlobalRecipe[];
}) {
  const router = useRouter();
  const [step, setStep] = useState(0);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Step 1: Kitchen name
  const [kitchenName, setKitchenName] = useState(
    household.name === "Kitchen" ? "" : household.name
  );

  // Step 2: Family members
  const [memberForms, setMemberForms] = useState<MemberForm[]>(
    members.length > 0
      ? members.map((m) => ({
          id: m.id,
          name: m.name,
          age: m.age?.toString() ?? "",
          dietary_notes: m.dietary_notes ?? "",
          dietary_mode: m.dietary_mode ?? "non_vegetarian",
        }))
      : [{ name: "", age: "", dietary_notes: "", dietary_mode: "non_vegetarian" }]
  );

  // Step 3: Recipe import
  const [importing, setImporting] = useState(false);
  const [importCount, setImportCount] = useState(0);
  const [showPasteMode, setShowPasteMode] = useState(false);
  const [pasteText, setPasteText] = useState("");
  const [importResult, setImportResult] = useState<{
    title: string;
    recipe_id: string;
  } | null>(null);

  async function handleStep1Next() {
    if (!kitchenName.trim()) {
      setError("Give your kitchen a name!");
      return;
    }
    setSaving(true);
    setError(null);
    try {
      await updateHouseholdNameOnboarding(household.id, kitchenName.trim());
      setStep(1);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save");
    } finally {
      setSaving(false);
    }
  }

  async function handleStep2Next() {
    // Validate at least one member with a name
    const validMembers = memberForms.filter((m) => m.name.trim());
    if (validMembers.length === 0) {
      setError("Add at least one family member!");
      return;
    }
    setSaving(true);
    setError(null);
    try {
      for (const form of validMembers) {
        const data = {
          name: form.name.trim(),
          age: form.age ? parseInt(form.age) : null,
          dietary_notes: form.dietary_notes.trim() || null,
          dietary_mode: form.dietary_mode,
        };
        if (form.id) {
          await updateMemberOnboarding(form.id, data);
        } else {
          const newMember = await addMemberOnboarding(household.id, data);
          form.id = newMember.id;
        }
      }
      setStep(2);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save members");
    } finally {
      setSaving(false);
    }
  }

  function addMemberRow() {
    setMemberForms([...memberForms, { name: "", age: "", dietary_notes: "", dietary_mode: "non_vegetarian" }]);
  }

  function updateMemberForm(index: number, field: keyof MemberForm, value: string) {
    setMemberForms((prev) =>
      prev.map((m, i) => (i === index ? { ...m, [field]: value } : m))
    );
  }

  function removeMemberRow(index: number) {
    if (memberForms.length <= 1) return;
    setMemberForms((prev) => prev.filter((_, i) => i !== index));
  }

  async function handleLibraryImport(selectedIds: string[]) {
    setImporting(true);
    setError(null);
    try {
      const result = await batchImportGlobalRecipes(selectedIds);
      setImportCount(result.importedCount);
      setStep(3);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to import recipes");
    } finally {
      setImporting(false);
    }
  }

  async function handlePasteImport() {
    if (!pasteText.trim()) return;
    setImporting(true);
    setError(null);
    try {
      const response = await fetch(
        "https://n8n.epixentertainment.com/webhook/recipe-paste",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            text: pasteText.trim(),
            household_id: household.id,
          }),
        }
      );
      if (!response.ok) throw new Error("Import failed");
      const data = await response.json();
      if (!data.success) throw new Error(data.error || "Failed to parse");
      setImportResult({
        title: data.recipe?.recipe?.title || data.recipe?.title || "Imported Recipe",
        recipe_id: data.recipe_id,
      });
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to import");
    } finally {
      setImporting(false);
    }
  }

  async function handleFinish() {
    setSaving(true);
    try {
      await completeOnboarding();
      router.push("/planner?tour=1");
    } catch {
      router.push("/planner?tour=1");
    }
  }

  return (
    <div className="w-full max-w-lg mx-auto">
      {/* Progress dots */}
      <div className="flex items-center justify-center gap-2 mb-8">
        {STEPS.map((_, i) => (
          <div
            key={i}
            className={`w-2.5 h-2.5 rounded-full transition-all ${
              i === step
                ? "bg-primary w-8"
                : i < step
                ? "bg-secondary"
                : "bg-ink-light/20"
            }`}
          />
        ))}
      </div>

      {/* Step title */}
      <h1 className="text-2xl font-bold text-ink text-center mb-2">
        {step === 0 && "Name Your Kitchen"}
        {step === 1 && "Your Family"}
        {step === 2 && "Pick Your Recipes"}
        {step === 3 && "You're All Set!"}
      </h1>
      <p className="text-sm text-ink-muted text-center mb-6">
        {step === 0 && "What should we call your kitchen?"}
        {step === 1 && "Who's eating at your table? Set their dietary preference."}
        {step === 2 && "Pick recipes from our library to get started quickly!"}
        {step === 3 && "Your kitchen is ready. Let's start planning meals!"}
      </p>

      {/* Error */}
      {error && (
        <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm mb-4">
          {error}
        </div>
      )}

      {/* Card */}
      <div className="bg-surface rounded-2xl shadow-md border border-ink-light/10 p-6">
        {/* STEP 0: Kitchen Name */}
        {step === 0 && (
          <div className="space-y-4">
            <input
              type="text"
              value={kitchenName}
              onChange={(e) => setKitchenName(e.target.value)}
              placeholder="e.g. The Sharma Kitchen, Casa de Shyam"
              autoFocus
              className="w-full px-4 py-3 rounded-xl border border-ink-light/30 bg-surface text-ink text-lg
                placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 text-center"
              onKeyDown={(e) => e.key === "Enter" && handleStep1Next()}
            />
            <button
              onClick={handleStep1Next}
              disabled={saving}
              className="w-full py-3 rounded-xl bg-primary text-white font-semibold text-lg
                hover:bg-primary-dark transition-colors disabled:opacity-50"
            >
              {saving ? "Saving..." : "Next"}
            </button>
          </div>
        )}

        {/* STEP 1: Family Members (with dietary_mode) */}
        {step === 1 && (
          <div className="space-y-4">
            {memberForms.map((form, i) => (
              <div
                key={i}
                className="p-3 rounded-xl bg-cream/50 border border-ink-light/10 space-y-2"
              >
                <div className="flex items-center gap-2">
                  <span className="text-lg">
                    {i === 0 ? "👤" : "👥"}
                  </span>
                  <input
                    type="text"
                    value={form.name}
                    onChange={(e) => updateMemberForm(i, "name", e.target.value)}
                    placeholder={i === 0 ? "Your name" : "Family member name"}
                    className="flex-1 px-3 py-2 rounded-lg border border-ink-light/20 bg-surface text-sm
                      focus:outline-none focus:ring-2 focus:ring-primary/50"
                  />
                  <input
                    type="number"
                    value={form.age}
                    onChange={(e) => updateMemberForm(i, "age", e.target.value)}
                    placeholder="Age"
                    min="1"
                    max="120"
                    className="w-16 px-2 py-2 rounded-lg border border-ink-light/20 bg-surface text-sm text-center
                      focus:outline-none focus:ring-2 focus:ring-primary/50"
                  />
                  {memberForms.length > 1 && (
                    <button
                      type="button"
                      onClick={() => removeMemberRow(i)}
                      className="p-1 text-ink-light hover:text-red-500 transition-colors"
                      title="Remove"
                    >
                      <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  )}
                </div>

                {/* Dietary mode selector */}
                <div className="flex gap-1 bg-cream rounded-lg p-0.5">
                  {DIETARY_MODE_OPTIONS.map((opt) => (
                    <button
                      key={opt.value}
                      type="button"
                      onClick={() => updateMemberForm(i, "dietary_mode", opt.value)}
                      className={`flex-1 py-1.5 rounded-md text-[11px] font-semibold transition-all ${
                        form.dietary_mode === opt.value
                          ? "bg-surface text-ink shadow-sm"
                          : "text-ink-muted hover:text-ink"
                      }`}
                    >
                      {opt.label}
                    </button>
                  ))}
                </div>

                <input
                  type="text"
                  value={form.dietary_notes}
                  onChange={(e) =>
                    updateMemberForm(i, "dietary_notes", e.target.value)
                  }
                  placeholder="Dietary notes (e.g. allergic to peanuts)"
                  className="w-full px-3 py-1.5 rounded-lg border border-ink-light/15 bg-surface text-xs
                    text-ink-muted placeholder:text-ink-light/60 focus:outline-none focus:ring-1 focus:ring-primary/30"
                />
              </div>
            ))}

            <button
              type="button"
              onClick={addMemberRow}
              className="w-full py-2 rounded-xl border-2 border-dashed border-ink-light/20 text-sm
                text-ink-muted hover:border-primary/30 hover:text-primary transition-colors"
            >
              + Add family member
            </button>

            <div className="flex gap-3 pt-2">
              <button
                onClick={() => { setError(null); setStep(0); }}
                className="flex-1 py-3 rounded-xl border border-ink-light/20 text-ink-muted font-semibold
                  hover:bg-cream transition-colors"
              >
                Back
              </button>
              <button
                onClick={handleStep2Next}
                disabled={saving}
                className="flex-1 py-3 rounded-xl bg-primary text-white font-semibold
                  hover:bg-primary-dark transition-colors disabled:opacity-50"
              >
                {saving ? "Saving..." : "Next"}
              </button>
            </div>
          </div>
        )}

        {/* STEP 2: Pick Recipes (library picker OR paste fallback) */}
        {step === 2 && (
          <div className="space-y-4">
            {importResult ? (
              <div className="text-center space-y-3">
                <div className="p-4 rounded-xl bg-secondary/10 text-secondary-dark">
                  <p className="font-semibold">Recipe imported!</p>
                  <p className="text-sm mt-1">&ldquo;{importResult.title}&rdquo;</p>
                </div>
                <button
                  onClick={() => { setError(null); setStep(3); }}
                  className="w-full py-3 rounded-xl bg-primary text-white font-semibold
                    hover:bg-primary-dark transition-colors"
                >
                  Continue
                </button>
              </div>
            ) : showPasteMode ? (
              /* Paste import fallback */
              <>
                <textarea
                  value={pasteText}
                  onChange={(e) => setPasteText(e.target.value)}
                  placeholder="Paste a recipe here — title, ingredients, steps. Any format works!"
                  rows={6}
                  className="w-full px-3 py-2.5 rounded-xl border border-ink-light/30 bg-surface text-sm
                    placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50 resize-y"
                />
                <button
                  onClick={handlePasteImport}
                  disabled={importing || !pasteText.trim()}
                  className="w-full py-3 rounded-xl bg-primary text-white font-semibold
                    hover:bg-primary-dark transition-colors disabled:opacity-50"
                >
                  {importing ? (
                    <span className="flex items-center justify-center gap-2">
                      <svg className="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" />
                      </svg>
                      Parsing with AI...
                    </span>
                  ) : (
                    "Parse Recipe"
                  )}
                </button>
                <button
                  type="button"
                  onClick={() => setShowPasteMode(false)}
                  className="w-full py-2 text-sm text-ink-muted hover:text-ink transition-colors"
                >
                  Back to library picker
                </button>
              </>
            ) : (
              /* Library recipe picker (default) */
              <>
                {globalRecipes.length > 0 ? (
                  <OnboardingRecipePicker
                    recipes={globalRecipes}
                    onImportSelected={handleLibraryImport}
                    importing={importing}
                  />
                ) : (
                  <div className="text-center py-8">
                    <span className="text-4xl">📚</span>
                    <p className="text-sm text-ink-muted mt-3">
                      The recipe library is being prepared. You can paste a recipe instead!
                    </p>
                  </div>
                )}

                <button
                  type="button"
                  onClick={() => setShowPasteMode(true)}
                  className="w-full py-2 text-sm text-ink-muted hover:text-primary transition-colors"
                >
                  Or paste a recipe instead
                </button>
              </>
            )}

            {!importResult && (
              <div className="flex gap-3 pt-2">
                <button
                  onClick={() => { setError(null); setStep(1); }}
                  className="flex-1 py-3 rounded-xl border border-ink-light/20 text-ink-muted font-semibold
                    hover:bg-cream transition-colors"
                >
                  Back
                </button>
                <button
                  onClick={() => { setError(null); setStep(3); }}
                  className="flex-1 py-3 rounded-xl border border-ink-light/20 text-ink-muted font-semibold
                    hover:bg-cream transition-colors"
                >
                  Skip for now
                </button>
              </div>
            )}
          </div>
        )}

        {/* STEP 3: All Set! */}
        {step === 3 && (
          <div className="text-center space-y-6 py-4">
            <div className="text-6xl">🍽️</div>
            <div>
              <p className="text-lg font-semibold text-ink">
                Welcome to {kitchenName || "your kitchen"}!
              </p>
              <p className="text-sm text-ink-muted mt-1">
                {importCount > 0
                  ? `${importCount} recipes imported! `
                  : ""}
                Start by creating a weekly meal plan. Plateful will help you
                fill it with balanced meals, generate grocery lists, and
                optimize your batch prep.
              </p>
            </div>
            <button
              onClick={handleFinish}
              disabled={saving}
              className="w-full py-3 rounded-xl bg-primary text-white font-bold text-lg
                hover:bg-primary-dark transition-colors disabled:opacity-50"
            >
              {saving ? "Loading..." : "Go to Planner"}
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
