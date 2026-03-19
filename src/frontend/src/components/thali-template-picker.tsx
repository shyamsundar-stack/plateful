"use client";

import { useState, useEffect } from "react";
import { fetchThaliTemplates, resolveTemplateDishes } from "@/lib/actions/thali-actions";
import { getDishRoleEmoji, getDishRoleLabel } from "@/lib/meal-utils";
import type { ThaliTemplateWithDishes, Recipe } from "@/lib/types/database";

type DishRole = "main" | "staple" | "side" | "accompaniment";

export default function ThaliTemplatePicker({
  slotMealType,
  recipes,
  saving: parentSaving,
  onApply,
}: {
  slotMealType: string;
  recipes: Recipe[];
  saving: boolean;
  onApply: (
    dishes: Array<{
      dishRole: DishRole;
      recipeId: string;
      portionFactor?: number;
    }>
  ) => void;
}) {
  const [templates, setTemplates] = useState<ThaliTemplateWithDishes[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedTemplateId, setSelectedTemplateId] = useState<string | null>(
    null
  );
  const [resolvedDishes, setResolvedDishes] = useState<
    Array<{
      dishRole: DishRole;
      dishLabel: string;
      recipeId: string | null;
      recipeTitle: string | null;
    }>
  >([]);
  const [resolving, setResolving] = useState(false);

  // Fetch templates on mount
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const data = await fetchThaliTemplates();
        if (!cancelled) setTemplates(data);
      } catch (err) {
        if (!cancelled)
          setError(
            err instanceof Error ? err.message : "Failed to load templates"
          );
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  // Filter templates: prefer those matching the slot's meal_type
  const matchingTemplates = templates.filter(
    (t) =>
      t.meal_types.length === 0 || t.meal_types.includes(slotMealType)
  );
  const otherTemplates = templates.filter(
    (t) =>
      t.meal_types.length > 0 && !t.meal_types.includes(slotMealType)
  );

  async function handleSelectTemplate(templateId: string) {
    setSelectedTemplateId(templateId);
    setResolving(true);
    setError(null);
    try {
      const resolved = await resolveTemplateDishes(templateId);
      setResolvedDishes(resolved);
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to resolve template"
      );
    } finally {
      setResolving(false);
    }
  }

  function handleApply() {
    // Only apply dishes that have a resolved recipe
    const dishesToApply = resolvedDishes
      .filter((d) => d.recipeId !== null)
      .map((d) => ({
        dishRole: d.dishRole,
        recipeId: d.recipeId!,
        portionFactor: 1.0,
      }));

    if (dishesToApply.length === 0) {
      setError(
        "No dishes could be matched to your recipes. Try adding more recipes or picking a different template."
      );
      return;
    }

    onApply(dishesToApply);
  }

  // Allow manual override of a resolved dish
  function handleOverrideRecipe(index: number, recipeId: string) {
    const recipe = recipes.find((r) => r.id === recipeId);
    setResolvedDishes((prev) =>
      prev.map((d, i) =>
        i === index
          ? { ...d, recipeId, recipeTitle: recipe?.title ?? null }
          : d
      )
    );
  }

  if (loading) {
    return (
      <div className="text-center py-6">
        <div className="animate-pulse text-sm text-ink-muted">
          Loading templates...
        </div>
      </div>
    );
  }

  if (templates.length === 0) {
    return (
      <div className="text-center py-6">
        <p className="text-3xl mb-2">📋</p>
        <p className="text-sm text-ink-muted">
          No thali templates yet. Create one in Settings to use quick meal combos.
        </p>
      </div>
    );
  }

  // If a template is selected, show the resolution preview
  if (selectedTemplateId) {
    const template = templates.find((t) => t.id === selectedTemplateId);

    return (
      <div className="space-y-3">
        {/* Back button */}
        <button
          onClick={() => {
            setSelectedTemplateId(null);
            setResolvedDishes([]);
          }}
          className="text-xs text-primary hover:text-primary-dark font-medium flex items-center gap-1"
        >
          <svg
            className="w-3 h-3"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M15 19l-7-7 7-7"
            />
          </svg>
          Back to templates
        </button>

        {/* Template name */}
        <div>
          <h4 className="text-sm font-semibold text-ink">
            {template?.name ?? "Template"}
          </h4>
          {template?.description && (
            <p className="text-xs text-ink-muted mt-0.5">
              {template.description}
            </p>
          )}
        </div>

        {error && (
          <div className="p-2 rounded-lg bg-red-50 text-red-600 text-xs">
            {error}
          </div>
        )}

        {resolving ? (
          <div className="text-center py-4">
            <div className="animate-pulse text-xs text-ink-muted">
              Matching dishes to your recipes...
            </div>
          </div>
        ) : (
          <>
            {/* Resolved dishes preview */}
            <div className="space-y-2">
              {resolvedDishes.map((dish, i) => (
                <div
                  key={i}
                  className="p-2.5 rounded-lg border border-ink-light/10 bg-cream/30"
                >
                  <div className="flex items-center gap-2 mb-1">
                    <span className="text-sm">
                      {getDishRoleEmoji(dish.dishRole)}
                    </span>
                    <span className="text-[10px] font-bold text-ink-muted uppercase">
                      {getDishRoleLabel(dish.dishRole)}
                    </span>
                  </div>

                  {dish.recipeId ? (
                    <p className="text-sm font-medium text-ink pl-6">
                      {dish.recipeTitle}
                    </p>
                  ) : (
                    <div className="pl-6">
                      <p className="text-xs text-amber-600 mb-1">
                        No match found for &ldquo;{dish.dishLabel}&rdquo;
                      </p>
                      {/* Manual override picker */}
                      <select
                        onChange={(e) => {
                          if (e.target.value) {
                            handleOverrideRecipe(i, e.target.value);
                          }
                        }}
                        defaultValue=""
                        className="w-full px-2 py-1 text-xs rounded border border-ink-light/20 bg-surface"
                      >
                        <option value="">Pick a recipe...</option>
                        {recipes.map((r) => (
                          <option key={r.id} value={r.id}>
                            {r.title}
                          </option>
                        ))}
                      </select>
                    </div>
                  )}
                </div>
              ))}
            </div>

            {/* Apply button */}
            <button
              onClick={handleApply}
              disabled={
                parentSaving ||
                resolvedDishes.filter((d) => d.recipeId).length === 0
              }
              className="w-full py-2.5 rounded-lg bg-primary text-white text-sm font-semibold
                hover:bg-primary-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed
                flex items-center justify-center gap-1.5"
            >
              {parentSaving ? (
                <>
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
                  Applying...
                </>
              ) : (
                <>
                  Apply Template (
                  {resolvedDishes.filter((d) => d.recipeId).length} dishes)
                </>
              )}
            </button>
          </>
        )}
      </div>
    );
  }

  // Template grid
  return (
    <div className="space-y-3">
      {matchingTemplates.length > 0 && (
        <div>
          <p className="text-[10px] font-semibold text-ink-muted uppercase tracking-wide mb-2">
            Recommended for {slotMealType}
          </p>
          <div className="grid grid-cols-2 gap-2">
            {matchingTemplates.map((template) => (
              <TemplateCard
                key={template.id}
                template={template}
                onSelect={() => handleSelectTemplate(template.id)}
              />
            ))}
          </div>
        </div>
      )}

      {otherTemplates.length > 0 && (
        <div>
          <p className="text-[10px] font-semibold text-ink-muted uppercase tracking-wide mb-2">
            {matchingTemplates.length > 0 ? "Other templates" : "All templates"}
          </p>
          <div className="grid grid-cols-2 gap-2">
            {otherTemplates.map((template) => (
              <TemplateCard
                key={template.id}
                template={template}
                onSelect={() => handleSelectTemplate(template.id)}
              />
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function TemplateCard({
  template,
  onSelect,
}: {
  template: ThaliTemplateWithDishes;
  onSelect: () => void;
}) {
  const dishCount = template.thali_template_dishes?.length ?? 0;

  return (
    <button
      onClick={onSelect}
      className="text-left p-3 rounded-lg border border-ink-light/10 bg-cream/30
        hover:bg-cream hover:border-primary/30 transition-all group"
    >
      <p className="text-sm font-medium text-ink group-hover:text-primary line-clamp-1">
        {template.name}
      </p>
      {template.description && (
        <p className="text-[10px] text-ink-muted mt-0.5 line-clamp-2">
          {template.description}
        </p>
      )}
      <div className="flex items-center gap-2 mt-1.5">
        {template.cuisine && (
          <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-ink-light/10 text-ink-muted">
            {template.cuisine}
          </span>
        )}
        <span className="text-[10px] text-ink-muted">
          {dishCount} {dishCount === 1 ? "dish" : "dishes"}
        </span>
        {template.is_vegetarian && (
          <span className="text-[10px]">🟢</span>
        )}
        {!template.household_id && (
          <span className="text-[10px] text-accent-dark">Global</span>
        )}
      </div>
    </button>
  );
}
