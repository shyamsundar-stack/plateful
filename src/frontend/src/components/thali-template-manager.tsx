"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import {
  createThaliTemplate,
  updateThaliTemplate,
  deleteThaliTemplate,
} from "@/lib/actions/thali-actions";
import { getDishRoleEmoji, getDishRoleLabel } from "@/lib/meal-utils";
import type { ThaliTemplateWithDishes } from "@/lib/types/database";

type DishRole = "main" | "staple" | "side" | "accompaniment";

const DISH_ROLES: DishRole[] = ["main", "staple", "side", "accompaniment"];

const CUISINES = [
  "North Indian",
  "South Indian",
  "Punjabi",
  "Bengali",
  "Gujarati",
  "Rajasthani",
  "Maharashtrian",
  "Kerala",
  "Tamil",
  "Indo-Chinese",
  "Continental",
  "Other",
];

const MEAL_TYPES_OPTIONS = [
  { value: "breakfast", label: "Breakfast" },
  { value: "lunch", label: "Lunch" },
  { value: "dinner", label: "Dinner" },
  { value: "snack", label: "Snack" },
];

type DishEntry = {
  dishRole: DishRole;
  dishLabel: string;
  tags: string;
};

export default function ThaliTemplateManager({
  templates: initialTemplates,
}: {
  templates: ThaliTemplateWithDishes[];
}) {
  const router = useRouter();
  const [templates, setTemplates] = useState(initialTemplates);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);

  // Split into household and global
  const householdTemplates = templates.filter((t) => t.household_id !== null);
  const globalTemplates = templates.filter((t) => t.household_id === null);

  async function handleDelete(templateId: string) {
    if (!confirm("Archive this template? It will no longer appear in the template picker.")) return;
    setSaving(true);
    setError(null);
    try {
      await deleteThaliTemplate(templateId);
      setTemplates((prev) => prev.filter((t) => t.id !== templateId));
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to delete template");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-lg font-semibold text-ink">Thali Templates</h2>
          <p className="text-xs text-ink-muted mt-0.5">
            Pre-built meal combos for quick planning. Apply a template to fill a meal slot with multiple dishes.
          </p>
        </div>
        {!showCreateForm && (
          <button
            onClick={() => {
              setShowCreateForm(true);
              setEditingId(null);
            }}
            className="px-3 py-1.5 rounded-lg bg-primary text-white text-sm font-semibold
              hover:bg-primary-dark transition-colors"
          >
            + New Template
          </button>
        )}
      </div>

      {error && (
        <div className="p-2 rounded-lg bg-red-50 text-red-600 text-sm">
          {error}
        </div>
      )}

      {/* Create / Edit Form */}
      {(showCreateForm || editingId) && (
        <TemplateForm
          template={editingId ? templates.find((t) => t.id === editingId) ?? null : null}
          saving={saving}
          onSave={async (data) => {
            setSaving(true);
            setError(null);
            try {
              if (editingId) {
                await updateThaliTemplate(editingId, data);
              } else {
                await createThaliTemplate(data);
              }
              setShowCreateForm(false);
              setEditingId(null);
              router.refresh();
              // Refresh templates list
              // For simplicity, we'll just reload the page
              window.location.reload();
            } catch (err) {
              setError(err instanceof Error ? err.message : "Failed to save template");
            } finally {
              setSaving(false);
            }
          }}
          onCancel={() => {
            setShowCreateForm(false);
            setEditingId(null);
          }}
        />
      )}

      {/* Household Templates */}
      {householdTemplates.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2">
            Your Templates
          </p>
          <div className="space-y-2">
            {householdTemplates.map((template) => (
              <TemplateRow
                key={template.id}
                template={template}
                editable
                onEdit={() => {
                  setEditingId(template.id);
                  setShowCreateForm(false);
                }}
                onDelete={() => handleDelete(template.id)}
              />
            ))}
          </div>
        </div>
      )}

      {/* Global Templates */}
      {globalTemplates.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2">
            Built-in Templates
          </p>
          <div className="space-y-2">
            {globalTemplates.map((template) => (
              <TemplateRow
                key={template.id}
                template={template}
                editable={false}
              />
            ))}
          </div>
        </div>
      )}

      {templates.length === 0 && !showCreateForm && (
        <div className="text-center py-8">
          <p className="text-3xl mb-2">📋</p>
          <p className="text-sm text-ink-muted">
            No templates yet. Create your first thali template to speed up meal planning.
          </p>
        </div>
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────
// Template Row (display)
// ─────────────────────────────────────────────────

function TemplateRow({
  template,
  editable,
  onEdit,
  onDelete,
}: {
  template: ThaliTemplateWithDishes;
  editable: boolean;
  onEdit?: () => void;
  onDelete?: () => void;
}) {
  const dishes = (template.thali_template_dishes ?? []).sort(
    (a, b) => a.sort_order - b.sort_order
  );

  return (
    <div className="p-3 rounded-xl border border-ink-light/10 bg-surface">
      <div className="flex items-start justify-between">
        <div className="flex-1">
          <p className="text-sm font-semibold text-ink">{template.name}</p>
          {template.description && (
            <p className="text-xs text-ink-muted mt-0.5">
              {template.description}
            </p>
          )}
          <div className="flex items-center gap-2 mt-1">
            {template.cuisine && (
              <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-ink-light/10 text-ink-muted">
                {template.cuisine}
              </span>
            )}
            {template.meal_types.length > 0 && (
              <span className="text-[10px] text-ink-muted">
                {template.meal_types.join(", ")}
              </span>
            )}
            {template.is_vegetarian && (
              <span className="text-[10px]">🟢 Veg</span>
            )}
          </div>

          {/* Dish pills */}
          <div className="flex flex-wrap gap-1 mt-2">
            {dishes.map((dish) => (
              <span
                key={dish.id}
                className="inline-flex items-center gap-0.5 text-[10px] px-1.5 py-0.5 rounded-full bg-cream text-ink-muted"
              >
                {getDishRoleEmoji(dish.dish_role)}{" "}
                {dish.dish_label || getDishRoleLabel(dish.dish_role)}
              </span>
            ))}
          </div>
        </div>

        {editable && (
          <div className="flex items-center gap-1 shrink-0">
            <button
              onClick={onEdit}
              className="p-1.5 rounded-lg text-ink-muted hover:text-primary hover:bg-cream transition-colors"
              title="Edit template"
            >
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
              </svg>
            </button>
            <button
              onClick={onDelete}
              className="p-1.5 rounded-lg text-ink-muted hover:text-red-500 hover:bg-red-50 transition-colors"
              title="Archive template"
            >
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
              </svg>
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────
// Template Form (create / edit)
// ─────────────────────────────────────────────────

function TemplateForm({
  template,
  saving,
  onSave,
  onCancel,
}: {
  template: ThaliTemplateWithDishes | null;
  saving: boolean;
  onSave: (data: {
    name: string;
    description?: string;
    cuisine?: string;
    mealTypes?: string[];
    isVegetarian?: boolean;
    dishes: Array<{
      dishRole: DishRole;
      dishLabel: string;
      recipeFilter: Record<string, unknown>;
    }>;
  }) => void;
  onCancel: () => void;
}) {
  const isEdit = !!template;

  const [name, setName] = useState(template?.name ?? "");
  const [description, setDescription] = useState(template?.description ?? "");
  const [cuisine, setCuisine] = useState(template?.cuisine ?? "");
  const [mealTypes, setMealTypes] = useState<string[]>(
    template?.meal_types ?? []
  );
  const [isVegetarian, setIsVegetarian] = useState(
    template?.is_vegetarian ?? false
  );

  // Initialize dishes from template or empty
  const initDishes = (): DishEntry[] => {
    if (template?.thali_template_dishes) {
      return template.thali_template_dishes
        .sort((a, b) => a.sort_order - b.sort_order)
        .map((d) => ({
          dishRole: d.dish_role as DishRole,
          dishLabel: d.dish_label,
          tags: ((d.recipe_filter as Record<string, unknown>)?.tags as string[] ?? []).join(", "),
        }));
    }
    // Default: start with main + staple
    return [
      { dishRole: "main", dishLabel: "", tags: "" },
      { dishRole: "staple", dishLabel: "", tags: "" },
    ];
  };

  const [dishes, setDishes] = useState<DishEntry[]>(initDishes);

  function addDish() {
    // Find first unused role
    const usedRoles = new Set(dishes.map((d) => d.dishRole));
    const available = DISH_ROLES.find((r) => !usedRoles.has(r));
    if (!available) return; // All 4 roles already used
    setDishes([...dishes, { dishRole: available, dishLabel: "", tags: "" }]);
  }

  function removeDish(index: number) {
    setDishes(dishes.filter((_, i) => i !== index));
  }

  function updateDish(index: number, field: keyof DishEntry, value: string) {
    setDishes(
      dishes.map((d, i) => (i === index ? { ...d, [field]: value } : d))
    );
  }

  function toggleMealType(mealType: string) {
    setMealTypes((prev) =>
      prev.includes(mealType)
        ? prev.filter((t) => t !== mealType)
        : [...prev, mealType]
    );
  }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!name.trim()) return;
    if (dishes.length === 0) return;

    const dishData = dishes.map((d) => ({
      dishRole: d.dishRole,
      dishLabel: d.dishLabel || getDishRoleLabel(d.dishRole),
      recipeFilter: {
        ...(cuisine ? { cuisine: cuisine.toLowerCase().replace(/\s+/g, "_") } : {}),
        ...(d.tags.trim()
          ? { tags: d.tags.split(",").map((t) => t.trim().toLowerCase()).filter(Boolean) }
          : {}),
        ...(mealTypes.length > 0 ? { meal_types: mealTypes } : {}),
        ...(isVegetarian ? { is_vegetarian: true } : {}),
      },
    }));

    onSave({
      name: name.trim(),
      description: description.trim() || undefined,
      cuisine: cuisine || undefined,
      mealTypes: mealTypes.length > 0 ? mealTypes : undefined,
      isVegetarian: isVegetarian || undefined,
      dishes: dishData,
    });
  }

  return (
    <form
      onSubmit={handleSubmit}
      className="p-4 rounded-xl border border-primary/20 bg-primary/5 space-y-4"
    >
      <h3 className="text-sm font-semibold text-ink">
        {isEdit ? "Edit Template" : "New Thali Template"}
      </h3>

      {/* Name */}
      <div>
        <label className="text-xs font-semibold text-ink-muted block mb-1">
          Template Name *
        </label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="e.g., South Indian Lunch"
          required
          className="w-full px-3 py-2 rounded-lg border border-ink-light/30 bg-surface
            text-sm focus:ring-2 focus:ring-primary/50 focus:border-transparent"
        />
      </div>

      {/* Description */}
      <div>
        <label className="text-xs font-semibold text-ink-muted block mb-1">
          Description
        </label>
        <input
          type="text"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="e.g., Classic sambar rice with poriyal"
          className="w-full px-3 py-2 rounded-lg border border-ink-light/30 bg-surface
            text-sm focus:ring-2 focus:ring-primary/50 focus:border-transparent"
        />
      </div>

      {/* Cuisine + Veg toggle */}
      <div className="flex gap-3">
        <div className="flex-1">
          <label className="text-xs font-semibold text-ink-muted block mb-1">
            Cuisine
          </label>
          <select
            value={cuisine}
            onChange={(e) => setCuisine(e.target.value)}
            className="w-full px-3 py-2 rounded-lg border border-ink-light/30 bg-surface
              text-sm focus:ring-2 focus:ring-primary/50"
          >
            <option value="">Any</option>
            {CUISINES.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
          </select>
        </div>
        <div className="flex items-end pb-1">
          <label className="flex items-center gap-2 cursor-pointer">
            <input
              type="checkbox"
              checked={isVegetarian}
              onChange={(e) => setIsVegetarian(e.target.checked)}
              className="w-4 h-4 rounded border-ink-light/30 text-primary"
            />
            <span className="text-xs text-ink">🟢 Veg only</span>
          </label>
        </div>
      </div>

      {/* Meal types */}
      <div>
        <label className="text-xs font-semibold text-ink-muted block mb-1">
          Best for (meal types)
        </label>
        <div className="flex gap-2">
          {MEAL_TYPES_OPTIONS.map((mt) => (
            <button
              key={mt.value}
              type="button"
              onClick={() => toggleMealType(mt.value)}
              className={`px-2.5 py-1 rounded-full text-xs font-medium transition-colors
                ${
                  mealTypes.includes(mt.value)
                    ? "bg-primary text-white"
                    : "bg-cream text-ink-muted hover:bg-ink-light/10"
                }`}
            >
              {mt.label}
            </button>
          ))}
        </div>
      </div>

      {/* Dishes */}
      <div>
        <label className="text-xs font-semibold text-ink-muted block mb-2">
          Dishes
        </label>
        <div className="space-y-2">
          {dishes.map((dish, i) => (
            <div
              key={i}
              className="flex items-center gap-2 p-2 rounded-lg bg-surface border border-ink-light/10"
            >
              <span className="text-base shrink-0">
                {getDishRoleEmoji(dish.dishRole)}
              </span>
              <select
                value={dish.dishRole}
                onChange={(e) =>
                  updateDish(i, "dishRole", e.target.value)
                }
                className="px-2 py-1 rounded border border-ink-light/20 bg-cream text-xs
                  focus:ring-1 focus:ring-primary/40 shrink-0"
              >
                {DISH_ROLES.map((r) => (
                  <option key={r} value={r}>
                    {getDishRoleLabel(r)}
                  </option>
                ))}
              </select>
              <input
                type="text"
                value={dish.dishLabel}
                onChange={(e) => updateDish(i, "dishLabel", e.target.value)}
                placeholder="Label (e.g., Dal)"
                className="flex-1 px-2 py-1 rounded border border-ink-light/20 bg-surface text-xs
                  focus:ring-1 focus:ring-primary/40 min-w-0"
              />
              <input
                type="text"
                value={dish.tags}
                onChange={(e) => updateDish(i, "tags", e.target.value)}
                placeholder="Tags (comma sep)"
                className="flex-1 px-2 py-1 rounded border border-ink-light/20 bg-surface text-xs
                  focus:ring-1 focus:ring-primary/40 min-w-0"
              />
              {dishes.length > 1 && (
                <button
                  type="button"
                  onClick={() => removeDish(i)}
                  className="text-red-400 hover:text-red-600 shrink-0 p-0.5"
                >
                  <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              )}
            </div>
          ))}
        </div>
        {dishes.length < 4 && (
          <button
            type="button"
            onClick={addDish}
            className="mt-2 text-xs text-primary hover:text-primary-dark font-medium"
          >
            + Add dish slot
          </button>
        )}
      </div>

      {/* Actions */}
      <div className="flex gap-2 pt-2">
        <button
          type="submit"
          disabled={saving || !name.trim() || dishes.length === 0}
          className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold
            hover:bg-primary-dark transition-colors disabled:opacity-50"
        >
          {saving ? "Saving..." : isEdit ? "Update Template" : "Create Template"}
        </button>
        <button
          type="button"
          onClick={onCancel}
          className="px-4 py-2 rounded-lg bg-cream text-ink-muted text-sm font-medium
            hover:bg-ink-light/10 transition-colors"
        >
          Cancel
        </button>
      </div>
    </form>
  );
}
