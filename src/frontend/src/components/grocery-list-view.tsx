"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import type { GroceryList, GroceryItem } from "@/lib/types/database";
import {
  toggleGroceryItemChecked,
  toggleAlreadyHave,
  addCustomGroceryItem,
  removeGroceryItem,
  getShareToken,
  completeGroceryList,
} from "@/lib/actions/grocery-actions";
import { getCategoryLabel, getCategoryOrder, formatQuantity } from "@/lib/grocery";

export default function GroceryListView({
  groceryList,
  items,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  weekPlanId: _weekPlanId,
}: {
  groceryList: GroceryList;
  items: GroceryItem[];
  weekPlanId: string;
}) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  const [showAddForm, setShowAddForm] = useState(false);
  const [shareUrl, setShareUrl] = useState<string | null>(null);
  const [showChecked, setShowChecked] = useState(false);

  // Separate checked vs unchecked items
  const uncheckedItems = items.filter((i) => !i.is_checked && !i.is_already_have);
  const checkedItems = items.filter((i) => i.is_checked);
  const alreadyHaveItems = items.filter((i) => i.is_already_have && !i.is_checked);

  // Group unchecked items by category
  const categories = getCategoryOrder();
  const groupedItems = new Map<string, GroceryItem[]>();
  for (const item of uncheckedItems) {
    const existing = groupedItems.get(item.category) ?? [];
    existing.push(item);
    groupedItems.set(item.category, existing);
  }

  const totalItems = items.length;
  const doneItems = checkedItems.length + alreadyHaveItems.length;
  const progress = totalItems > 0 ? Math.round((doneItems / totalItems) * 100) : 0;

  async function handleShare() {
    try {
      const token = await getShareToken(groceryList.id);
      const url = `${window.location.origin}/grocery/share/${token}`;
      setShareUrl(url);
      await navigator.clipboard.writeText(url);
    } catch {
      // Silently fail
    }
  }

  async function handleComplete() {
    startTransition(async () => {
      try {
        await completeGroceryList(groceryList.id);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  return (
    <div className="mt-4">
      {/* Header bar */}
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-lg font-semibold text-ink">Grocery List</h2>
          <p className="text-xs text-ink-muted">
            {uncheckedItems.length} to buy · {alreadyHaveItems.length} already
            have · {checkedItems.length} bought
          </p>
        </div>
        <div className="flex gap-2">
          <button
            onClick={handleShare}
            className="px-3 py-1.5 rounded-lg text-xs font-medium bg-surface
              border border-ink-light/10 hover:bg-cream transition-colors"
          >
            🔗 Share
          </button>
          <button
            onClick={() => setShowAddForm(!showAddForm)}
            className="px-3 py-1.5 rounded-lg text-xs font-medium bg-primary/10
              text-primary hover:bg-primary/20 transition-colors"
          >
            + Add Item
          </button>
        </div>
      </div>

      {/* Share URL notification */}
      {shareUrl && (
        <div className="mb-4 bg-green-50 border border-green-200 rounded-xl px-4 py-3 flex items-center justify-between">
          <div>
            <p className="text-xs font-semibold text-green-800">
              Link copied to clipboard! 📋
            </p>
            <p className="text-xs text-green-700 mt-0.5 break-all">
              {shareUrl}
            </p>
          </div>
          <button
            onClick={() => setShareUrl(null)}
            className="text-green-600 hover:text-green-800 text-sm ml-2"
          >
            ✕
          </button>
        </div>
      )}

      {/* Progress bar */}
      <div className="mb-4">
        <div className="h-2 bg-ink-light/10 rounded-full overflow-hidden">
          <div
            className="h-full bg-secondary rounded-full transition-all duration-300"
            style={{ width: `${progress}%` }}
          />
        </div>
        <p className="text-xs text-ink-muted mt-1 text-right">
          {progress}% complete
        </p>
      </div>

      {/* Add custom item form */}
      {showAddForm && (
        <AddItemForm
          groceryListId={groceryList.id}
          onDone={() => {
            setShowAddForm(false);
            router.refresh();
          }}
        />
      )}

      {/* Category groups */}
      {categories.map((category) => {
        const catItems = groupedItems.get(category);
        if (!catItems || catItems.length === 0) return null;
        return (
          <CategoryGroup
            key={category}
            category={category}
            items={catItems}
          />
        );
      })}

      {uncheckedItems.length === 0 && (
        <div className="mt-8 text-center">
          <p className="text-4xl mb-2">🎉</p>
          <p className="text-sm text-ink-muted">All items done!</p>
        </div>
      )}

      {/* Already have section */}
      {alreadyHaveItems.length > 0 && (
        <div className="mt-6">
          <h3 className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2">
            Already Have ({alreadyHaveItems.length})
          </h3>
          <div className="bg-surface rounded-xl border border-ink-light/10 divide-y divide-ink-light/5">
            {alreadyHaveItems.map((item) => (
              <GroceryItemRow key={item.id} item={item} />
            ))}
          </div>
        </div>
      )}

      {/* Checked/bought section */}
      {checkedItems.length > 0 && (
        <div className="mt-6">
          <button
            onClick={() => setShowChecked(!showChecked)}
            className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2 hover:text-ink transition-colors"
          >
            ✅ Bought ({checkedItems.length}){" "}
            {showChecked ? "▲" : "▼"}
          </button>
          {showChecked && (
            <div className="bg-surface rounded-xl border border-ink-light/10 divide-y divide-ink-light/5">
              {checkedItems.map((item) => (
                <GroceryItemRow key={item.id} item={item} />
              ))}
            </div>
          )}
        </div>
      )}

      {/* Complete list button */}
      {doneItems === totalItems && totalItems > 0 && (
        <div className="mt-6 text-center">
          <button
            onClick={handleComplete}
            disabled={isPending}
            className="px-6 py-3 rounded-xl bg-secondary text-white font-semibold
              hover:bg-secondary/90 disabled:opacity-50 transition-colors shadow-sm"
          >
            {isPending ? "Completing..." : "✅ Mark Shopping Complete"}
          </button>
        </div>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Category group
// ---------------------------------------------------------------------------

function CategoryGroup({
  category,
  items,
}: {
  category: string;
  items: GroceryItem[];
}) {
  return (
    <div className="mb-4">
      <h3 className="text-sm font-semibold text-ink mb-1.5 px-1">
        {getCategoryLabel(category)}
      </h3>
      <div className="bg-surface rounded-xl border border-ink-light/10 divide-y divide-ink-light/5">
        {items.map((item) => (
          <GroceryItemRow key={item.id} item={item} />
        ))}
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Individual item row
// ---------------------------------------------------------------------------

function GroceryItemRow({ item }: { item: GroceryItem }) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();

  function handleCheck() {
    startTransition(async () => {
      try {
        await toggleGroceryItemChecked(item.id, !item.is_checked);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  function handleAlreadyHave() {
    startTransition(async () => {
      try {
        await toggleAlreadyHave(item.id, !item.is_already_have);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  function handleRemove() {
    startTransition(async () => {
      try {
        await removeGroceryItem(item.id);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  const isStrikethrough = item.is_checked || item.is_already_have;

  return (
    <div
      className={`flex items-center px-3 py-2.5 gap-3 group ${
        isPending ? "opacity-50" : ""
      } ${isStrikethrough ? "bg-cream/50" : ""}`}
    >
      {/* Checkbox */}
      <button
        onClick={handleCheck}
        className={`w-5 h-5 rounded-md border-2 flex items-center justify-center shrink-0 transition-colors ${
          item.is_checked
            ? "bg-secondary border-secondary text-white"
            : "border-ink-light/30 hover:border-primary"
        }`}
      >
        {item.is_checked && (
          <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
          </svg>
        )}
      </button>

      {/* Item details */}
      <div className="flex-1 min-w-0">
        <p
          className={`text-sm font-medium ${
            isStrikethrough ? "line-through text-ink-muted" : "text-ink"
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

      {/* Quantity */}
      {item.quantity != null && (
        <span className="text-xs text-ink-muted font-medium shrink-0">
          {formatQuantity(item.quantity, item.unit)}
        </span>
      )}

      {/* Action buttons (visible on hover) */}
      <div className="flex gap-1 opacity-0 group-hover:opacity-100 transition-opacity shrink-0">
        <button
          onClick={handleAlreadyHave}
          className={`text-xs px-1.5 py-0.5 rounded ${
            item.is_already_have
              ? "bg-amber-100 text-amber-700"
              : "bg-ink-light/5 text-ink-muted hover:bg-amber-50 hover:text-amber-700"
          }`}
          title={item.is_already_have ? "Unmark 'already have'" : "Mark as 'already have'"}
        >
          🏠
        </button>
        <button
          onClick={handleRemove}
          className="text-xs px-1.5 py-0.5 rounded bg-ink-light/5 text-ink-muted
            hover:bg-red-50 hover:text-red-600"
          title="Remove item"
        >
          ✕
        </button>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Add custom item form
// ---------------------------------------------------------------------------

function AddItemForm({
  groceryListId,
  onDone,
}: {
  groceryListId: string;
  onDone: () => void;
}) {
  const [name, setName] = useState("");
  const [quantity, setQuantity] = useState("");
  const [unit, setUnit] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!name.trim()) return;

    setLoading(true);
    try {
      await addCustomGroceryItem(
        groceryListId,
        name.trim(),
        quantity ? parseFloat(quantity) : undefined,
        unit || undefined
      );
      setName("");
      setQuantity("");
      setUnit("");
      onDone();
    } catch {
      // Silently fail
    } finally {
      setLoading(false);
    }
  }

  return (
    <form
      onSubmit={handleSubmit}
      className="mb-4 bg-surface rounded-xl border border-ink-light/10 p-3"
    >
      <div className="flex gap-2">
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Item name"
          className="flex-1 px-3 py-2 rounded-lg border border-ink-light/20 text-sm
            focus:outline-none focus:border-primary/40"
          autoFocus
        />
        <input
          type="number"
          value={quantity}
          onChange={(e) => setQuantity(e.target.value)}
          placeholder="Qty"
          className="w-16 px-2 py-2 rounded-lg border border-ink-light/20 text-sm
            focus:outline-none focus:border-primary/40"
          step="any"
        />
        <input
          type="text"
          value={unit}
          onChange={(e) => setUnit(e.target.value)}
          placeholder="Unit"
          className="w-16 px-2 py-2 rounded-lg border border-ink-light/20 text-sm
            focus:outline-none focus:border-primary/40"
        />
        <button
          type="submit"
          disabled={loading || !name.trim()}
          className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-medium
            hover:bg-primary/90 disabled:opacity-50 transition-colors"
        >
          {loading ? "..." : "Add"}
        </button>
      </div>
    </form>
  );
}
