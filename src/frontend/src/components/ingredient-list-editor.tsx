"use client";

import type { Ingredient, IngredientRow } from "@/lib/types/database";
import IngredientSearch from "./ingredient-search";

type IngredientListEditorProps = {
  rows: IngredientRow[];
  onChange: (rows: IngredientRow[]) => void;
  householdIngredients: Ingredient[];
  householdId: string;
  onNewIngredient: (ingredient: Ingredient) => void;
};

const COMMON_UNITS = [
  "g", "kg", "ml", "l", "tsp", "tbsp", "cup", "piece", "bunch", "sprig",
  "pinch", "handful", "slice", "clove", "inch",
];

export default function IngredientListEditor({
  rows,
  onChange,
  householdIngredients,
  householdId,
  onNewIngredient,
}: IngredientListEditorProps) {
  function addRow() {
    onChange([
      ...rows,
      {
        _clientId: crypto.randomUUID(),
        ingredient_id: "",
        ingredient_name: "",
        quantity: null,
        unit: "",
        preparation: "",
        is_optional: false,
        group_name: "",
      },
    ]);
  }

  function removeRow(clientId: string) {
    onChange(rows.filter((r) => r._clientId !== clientId));
  }

  function updateRow(clientId: string, updates: Partial<IngredientRow>) {
    onChange(
      rows.map((r) =>
        r._clientId === clientId ? { ...r, ...updates } : r
      )
    );
  }

  function moveRow(clientId: string, direction: "up" | "down") {
    const index = rows.findIndex((r) => r._clientId === clientId);
    if (index < 0) return;
    const newIndex = direction === "up" ? index - 1 : index + 1;
    if (newIndex < 0 || newIndex >= rows.length) return;

    const newRows = [...rows];
    [newRows[index], newRows[newIndex]] = [newRows[newIndex], newRows[index]];
    onChange(newRows);
  }

  return (
    <div className="space-y-3">
      {rows.map((row, index) => (
        <div
          key={row._clientId}
          className="bg-surface border border-ink-light/10 rounded-lg p-3 space-y-2"
        >
          {/* Row header: ingredient search + remove */}
          <div className="flex gap-2 items-start">
            <div className="flex-1">
              <IngredientSearch
                ingredients={householdIngredients}
                householdId={householdId}
                value={row.ingredient_name}
                onSelect={(ing) =>
                  updateRow(row._clientId, {
                    ingredient_id: ing.id,
                    ingredient_name: ing.name,
                    unit: row.unit || ing.default_unit || "",
                  })
                }
                onNewIngredient={onNewIngredient}
              />
            </div>

            {/* Reorder + Remove buttons */}
            <div className="flex gap-1">
              <button
                type="button"
                onClick={() => moveRow(row._clientId, "up")}
                disabled={index === 0}
                className="p-1 text-ink-light hover:text-ink disabled:opacity-30 transition-colors"
                title="Move up"
              >
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <polyline points="18 15 12 9 6 15" />
                </svg>
              </button>
              <button
                type="button"
                onClick={() => moveRow(row._clientId, "down")}
                disabled={index === rows.length - 1}
                className="p-1 text-ink-light hover:text-ink disabled:opacity-30 transition-colors"
                title="Move down"
              >
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <polyline points="6 9 12 15 18 9" />
                </svg>
              </button>
              <button
                type="button"
                onClick={() => removeRow(row._clientId)}
                className="p-1 text-red-400 hover:text-red-600 transition-colors"
                title="Remove"
              >
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <line x1="18" y1="6" x2="6" y2="18" />
                  <line x1="6" y1="6" x2="18" y2="18" />
                </svg>
              </button>
            </div>
          </div>

          {/* Quantity + Unit + Preparation row */}
          <div className="flex gap-2">
            <input
              type="number"
              value={row.quantity ?? ""}
              onChange={(e) =>
                updateRow(row._clientId, {
                  quantity: e.target.value ? parseFloat(e.target.value) : null,
                })
              }
              placeholder="Qty"
              min="0"
              step="0.25"
              className="w-20 px-2 py-1.5 rounded border border-ink-light/30 text-sm text-ink focus:outline-none focus:ring-1 focus:ring-primary/50"
            />
            <select
              value={row.unit}
              onChange={(e) =>
                updateRow(row._clientId, { unit: e.target.value })
              }
              className="w-24 px-2 py-1.5 rounded border border-ink-light/30 text-sm text-ink bg-surface focus:outline-none focus:ring-1 focus:ring-primary/50"
            >
              <option value="">Unit</option>
              {COMMON_UNITS.map((u) => (
                <option key={u} value={u}>
                  {u}
                </option>
              ))}
            </select>
            <input
              type="text"
              value={row.preparation}
              onChange={(e) =>
                updateRow(row._clientId, { preparation: e.target.value })
              }
              placeholder="e.g. chopped, minced"
              className="flex-1 px-2 py-1.5 rounded border border-ink-light/30 text-sm text-ink placeholder:text-ink-light focus:outline-none focus:ring-1 focus:ring-primary/50"
            />
          </div>

          {/* Optional + Group name */}
          <div className="flex gap-3 items-center">
            <label className="flex items-center gap-1.5 text-xs text-ink-muted">
              <input
                type="checkbox"
                checked={row.is_optional}
                onChange={(e) =>
                  updateRow(row._clientId, { is_optional: e.target.checked })
                }
                className="rounded border-ink-light/30"
              />
              Optional
            </label>
            <input
              type="text"
              value={row.group_name}
              onChange={(e) =>
                updateRow(row._clientId, { group_name: e.target.value })
              }
              placeholder="Group (e.g. For tempering)"
              className="flex-1 px-2 py-1.5 rounded border border-ink-light/30 text-xs text-ink placeholder:text-ink-light focus:outline-none focus:ring-1 focus:ring-primary/50"
            />
          </div>
        </div>
      ))}

      {/* Add ingredient button */}
      <button
        type="button"
        onClick={addRow}
        className="w-full py-2 rounded-lg border-2 border-dashed border-ink-light/30 text-sm text-ink-muted hover:border-primary/50 hover:text-primary transition-colors"
      >
        + Add Ingredient
      </button>
    </div>
  );
}
