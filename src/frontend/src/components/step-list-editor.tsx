"use client";

import type { StepRow } from "@/lib/types/database";

type StepListEditorProps = {
  rows: StepRow[];
  onChange: (rows: StepRow[]) => void;
};

export default function StepListEditor({
  rows,
  onChange,
}: StepListEditorProps) {
  function addRow() {
    onChange([
      ...rows,
      {
        _clientId: crypto.randomUUID(),
        instruction: "",
        duration_min: null,
      },
    ]);
  }

  function removeRow(clientId: string) {
    onChange(rows.filter((r) => r._clientId !== clientId));
  }

  function updateRow(clientId: string, updates: Partial<StepRow>) {
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
          className="flex gap-3 items-start"
        >
          {/* Step number */}
          <span className="flex-shrink-0 w-7 h-7 rounded-full bg-primary/10 text-primary font-bold text-sm flex items-center justify-center mt-1">
            {index + 1}
          </span>

          {/* Instruction + duration */}
          <div className="flex-1 space-y-2">
            <textarea
              value={row.instruction}
              onChange={(e) =>
                updateRow(row._clientId, { instruction: e.target.value })
              }
              placeholder={`Step ${index + 1} instructions...`}
              rows={2}
              className="w-full px-3 py-2 rounded-lg border border-ink-light/30 text-sm text-ink placeholder:text-ink-light focus:outline-none focus:ring-1 focus:ring-primary/50 resize-none"
            />
            <div className="flex items-center gap-2">
              <label className="text-xs text-ink-muted">Duration:</label>
              <input
                type="number"
                value={row.duration_min ?? ""}
                onChange={(e) =>
                  updateRow(row._clientId, {
                    duration_min: e.target.value
                      ? parseInt(e.target.value)
                      : null,
                  })
                }
                placeholder="min"
                min="0"
                className="w-16 px-2 py-1 rounded border border-ink-light/30 text-xs text-ink focus:outline-none focus:ring-1 focus:ring-primary/50"
              />
              <span className="text-xs text-ink-light">min</span>
            </div>
          </div>

          {/* Reorder + Remove */}
          <div className="flex flex-col gap-0.5 mt-1">
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
              title="Remove step"
            >
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                <line x1="18" y1="6" x2="6" y2="18" />
                <line x1="6" y1="6" x2="18" y2="18" />
              </svg>
            </button>
          </div>
        </div>
      ))}

      {/* Add step button */}
      <button
        type="button"
        onClick={addRow}
        className="w-full py-2 rounded-lg border-2 border-dashed border-ink-light/30 text-sm text-ink-muted hover:border-primary/50 hover:text-primary transition-colors"
      >
        + Add Step
      </button>
    </div>
  );
}
