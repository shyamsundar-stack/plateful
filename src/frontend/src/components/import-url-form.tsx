"use client";

import { useState } from "react";
import Link from "next/link";
import { trackEvent } from "@/lib/actions/analytics-actions";

type ImportUrlFormProps = {
  householdId: string | null;
  loading: boolean; // household ID loading
};

export default function ImportUrlForm({
  householdId,
  loading,
}: ImportUrlFormProps) {
  const [url, setUrl] = useState("");
  const [importing, setImporting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [result, setResult] = useState<{
    recipe_id: string;
    title: string;
    source_url: string;
    unmatched: string[];
  } | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!householdId || !url.trim()) return;

    setImporting(true);
    setError(null);
    setResult(null);

    try {
      const response = await fetch(
        "https://n8n.epixentertainment.com/webhook/recipe-url",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            url: url.trim(),
            household_id: householdId,
          }),
        }
      );

      if (!response.ok) {
        const errData = await response.json().catch(() => null);
        throw new Error(
          errData?.message || `Import failed (${response.status})`
        );
      }

      const data = await response.json();

      if (!data.success) {
        throw new Error(data.error || "Failed to parse recipe from URL");
      }

      setResult({
        recipe_id: data.recipe_id,
        title: data.recipe?.recipe?.title || data.recipe?.title || "Imported Recipe",
        source_url: data.source_url || url,
        unmatched: data.unmatched_ingredients || [],
      });
      setUrl("");
      trackEvent("recipe_imported", { source: "url", recipe_id: data.recipe_id }).catch(() => {});
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to import recipe."
      );
    } finally {
      setImporting(false);
    }
  }

  // Show success state
  if (result) {
    return (
      <div className="space-y-4">
        <div className="p-4 rounded-lg bg-secondary/10 text-secondary-dark">
          <p className="font-semibold">Recipe imported successfully!</p>
          <p className="text-sm mt-1">
            &ldquo;{result.title}&rdquo; has been saved as a draft.
          </p>
          <p className="text-xs mt-1 text-secondary-dark/70">
            Source: {result.source_url}
          </p>
        </div>

        {result.unmatched.length > 0 && (
          <div className="p-3 rounded-lg bg-accent/20 text-accent-dark text-sm">
            <p className="font-medium">
              {result.unmatched.length} new ingredient
              {result.unmatched.length > 1 ? "s" : ""} created:
            </p>
            <ul className="mt-1 list-disc list-inside">
              {result.unmatched.map((name, i) => (
                <li key={i}>{name}</li>
              ))}
            </ul>
          </div>
        )}

        <div className="flex gap-3">
          <Link
            href={`/recipes/${result.recipe_id}/edit`}
            className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors"
          >
            Review & Edit Draft
          </Link>
          <button
            onClick={() => setResult(null)}
            className="px-4 py-2 rounded-lg text-sm text-ink-muted hover:text-ink hover:bg-cream transition-colors"
          >
            Import Another
          </button>
        </div>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div>
        <label className="block text-sm font-medium text-ink mb-1">
          Recipe URL
        </label>
        <input
          type="url"
          value={url}
          onChange={(e) => setUrl(e.target.value)}
          placeholder="https://www.example.com/recipe/dal-tadka"
          required
          className="w-full px-3 py-2.5 rounded-lg border border-ink-light/30 bg-surface text-ink text-sm placeholder:text-ink-light focus:outline-none focus:ring-2 focus:ring-primary/50"
        />
      </div>

      {error && (
        <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm">
          {error}
        </div>
      )}

      <button
        type="submit"
        disabled={importing || loading || !householdId || !url.trim()}
        className="w-full py-2.5 rounded-lg bg-primary text-white font-semibold hover:bg-primary-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {importing ? (
          <span className="flex items-center justify-center gap-2">
            <svg
              className="animate-spin w-4 h-4"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                className="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                strokeWidth="4"
              />
              <path
                className="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z"
              />
            </svg>
            Fetching & parsing recipe...
          </span>
        ) : (
          "Import from URL"
        )}
      </button>

      <p className="text-xs text-ink-light text-center">
        Works best with recipe blogs that show the full recipe on the page.
        JavaScript-heavy sites may not work — use &ldquo;Paste Recipe&rdquo;
        as a fallback.
      </p>
    </form>
  );
}
