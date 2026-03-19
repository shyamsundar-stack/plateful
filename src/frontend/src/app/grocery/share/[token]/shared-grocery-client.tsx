"use client";

import { useState, useEffect } from "react";

type GroceryItemData = {
  id: string;
  name: string;
  quantity: number | null;
  unit: string | null;
  serverChecked: boolean;
  recipe_sources: string[] | null;
  formattedQuantity: string | null;
};

type CategoryGroup = {
  category: string;
  label: string;
  items: GroceryItemData[];
};

export default function SharedGroceryClient({
  token,
  categoryGroups,
  totalItems,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  serverCheckedCount: _serverCheckedCount,
}: {
  token: string;
  categoryGroups: CategoryGroup[];
  totalItems: number;
  serverCheckedCount: number;
}) {
  // localStorage key scoped to this specific grocery list
  const storageKey = `plateful-shared-checks-${token}`;

  // Local check state: merged from server + localStorage
  const [localChecks, setLocalChecks] = useState<Record<string, boolean>>({});
  const [loaded, setLoaded] = useState(false);

  // Load localStorage on mount
  useEffect(() => {
    try {
      const stored = localStorage.getItem(storageKey);
      if (stored) {
        setLocalChecks(JSON.parse(stored));
      }
    } catch {
      // localStorage not available — proceed with server state only
    }
    setLoaded(true);
  }, [storageKey]);

  // Save to localStorage on change
  useEffect(() => {
    if (!loaded) return;
    try {
      localStorage.setItem(storageKey, JSON.stringify(localChecks));
    } catch {
      // Silently fail
    }
  }, [localChecks, loaded, storageKey]);

  function isChecked(item: GroceryItemData): boolean {
    // Local override takes precedence, else use server state
    if (localChecks[item.id] !== undefined) {
      return localChecks[item.id];
    }
    return item.serverChecked;
  }

  function toggleItem(itemId: string) {
    setLocalChecks((prev) => {
      const current = prev[itemId] !== undefined
        ? prev[itemId]
        : categoryGroups
            .flatMap((g) => g.items)
            .find((i) => i.id === itemId)?.serverChecked ?? false;
      return { ...prev, [itemId]: !current };
    });
  }

  // Count checked items (local + server merged)
  const allItems = categoryGroups.flatMap((g) => g.items);
  const checkedCount = allItems.filter((item) => isChecked(item)).length;

  return (
    <div className="min-h-screen bg-cream">
      <header className="bg-surface border-b border-ink-light/10 px-4 py-3">
        <div className="max-w-2xl mx-auto flex items-center justify-between">
          <div>
            <h1 className="text-lg font-bold text-primary">🍽️ Plateful</h1>
            <p className="text-xs text-ink-muted">Shared Grocery List</p>
          </div>
          <span className="text-xs bg-secondary/10 text-secondary px-2 py-1 rounded-full font-medium">
            {checkedCount}/{totalItems} bought
          </span>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 py-6">
        {/* Progress bar */}
        <div className="mb-6">
          <div className="h-2 bg-ink-light/10 rounded-full overflow-hidden">
            <div
              className="h-full bg-secondary rounded-full transition-all duration-300"
              style={{
                width: `${totalItems > 0 ? Math.round((checkedCount / totalItems) * 100) : 0}%`,
              }}
            />
          </div>
        </div>

        {/* Category groups */}
        {categoryGroups.map((group) => (
          <div key={group.category} className="mb-4">
            <h3 className="text-sm font-semibold text-ink mb-1.5 px-1">
              {group.label}
            </h3>
            <div className="bg-surface rounded-xl border border-ink-light/10 divide-y divide-ink-light/5">
              {group.items.map((item) => {
                const checked = isChecked(item);
                return (
                  <button
                    key={item.id}
                    onClick={() => toggleItem(item.id)}
                    className={`w-full flex items-center px-3 py-2.5 gap-3 transition-colors text-left ${
                      checked ? "bg-cream/50" : "hover:bg-cream/30"
                    }`}
                  >
                    <span
                      className={`w-5 h-5 rounded-md border-2 flex items-center justify-center shrink-0 transition-colors ${
                        checked
                          ? "bg-secondary border-secondary text-white"
                          : "border-ink-light/30"
                      }`}
                    >
                      {checked && (
                        <svg
                          className="w-3 h-3"
                          fill="none"
                          stroke="currentColor"
                          viewBox="0 0 24 24"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth={3}
                            d="M5 13l4 4L19 7"
                          />
                        </svg>
                      )}
                    </span>

                    <div className="flex-1 min-w-0">
                      <p
                        className={`text-sm font-medium transition-all ${
                          checked
                            ? "line-through text-ink-muted"
                            : "text-ink"
                        }`}
                      >
                        {item.name}
                      </p>
                      {item.recipe_sources && item.recipe_sources.length > 0 && (
                        <p className="text-[10px] text-ink-muted truncate">
                          {item.recipe_sources.join(" · ")}
                        </p>
                      )}
                    </div>

                    {item.formattedQuantity && (
                      <span className="text-xs text-ink-muted font-medium shrink-0">
                        {item.formattedQuantity}
                      </span>
                    )}
                  </button>
                );
              })}
            </div>
          </div>
        ))}

        {totalItems === 0 && (
          <div className="mt-8 text-center">
            <p className="text-4xl mb-2">📝</p>
            <p className="text-sm text-ink-muted">This list is empty.</p>
          </div>
        )}

        {/* Sync note */}
        {Object.keys(localChecks).length > 0 && (
          <p className="text-center text-[10px] text-ink-muted mt-4">
            Your check marks are saved on this device
          </p>
        )}

        {/* Footer */}
        <div className="mt-8 text-center">
          <p className="text-xs text-ink-muted">
            Powered by{" "}
            <span className="font-semibold text-primary">Plateful</span> — Smart
            Meal Planning
          </p>
        </div>
      </main>
    </div>
  );
}
