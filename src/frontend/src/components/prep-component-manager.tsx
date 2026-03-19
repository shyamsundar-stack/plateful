"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import type { PrepComponentWithRecipes, Recipe } from "@/lib/types/database";
import {
  createPrepComponent,
  archivePrepComponent,
  linkPrepToRecipe,
  unlinkPrepFromRecipe,
} from "@/lib/actions/prep-actions";

export default function PrepComponentManager({
  components,
  recipes,
}: {
  components: PrepComponentWithRecipes[];
  recipes: Recipe[];
}) {
  const [showCreateForm, setShowCreateForm] = useState(false);

  return (
    <div>
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-sm font-semibold text-ink">
          Custom Prep Components
        </h3>
        <button
          onClick={() => setShowCreateForm(!showCreateForm)}
          className="px-3 py-1.5 rounded-lg text-xs font-medium bg-primary/10
            text-primary hover:bg-primary/20 transition-colors"
        >
          + New Component
        </button>
      </div>

      <p className="text-xs text-ink-muted mb-4">
        Create reusable prep items like &ldquo;Onion Base Gravy&rdquo; or &ldquo;Boiled
        Lentils&rdquo; and link them to recipes. They&apos;ll show up in your prep plan
        when those recipes are on the menu.
      </p>

      {showCreateForm && (
        <CreatePrepForm
          onDone={() => setShowCreateForm(false)}
        />
      )}

      {components.length > 0 ? (
        <div className="space-y-3">
          {components.map((comp) => (
            <PrepComponentCard
              key={comp.id}
              component={comp}
              allRecipes={recipes}
            />
          ))}
        </div>
      ) : (
        <div className="text-center py-6 bg-surface rounded-xl border border-ink-light/10">
          <p className="text-3xl mb-2">📋</p>
          <p className="text-sm text-ink-muted">
            No custom prep components yet
          </p>
        </div>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Create form
// ---------------------------------------------------------------------------

function CreatePrepForm({ onDone }: { onDone: () => void }) {
  const router = useRouter();
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [prepType, setPrepType] = useState("cook");
  const [estTime, setEstTime] = useState("");
  const [loading, setLoading] = useState(false);

  const prepTypes = [
    { value: "chop", label: "🔪 Chop" },
    { value: "cook", label: "🍳 Cook" },
    { value: "marinate", label: "🥩 Marinate" },
    { value: "grind", label: "⚙️ Grind" },
    { value: "soak", label: "💧 Soak" },
    { value: "other", label: "📋 Other" },
  ];

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!name.trim()) return;

    setLoading(true);
    try {
      await createPrepComponent({
        name: name.trim(),
        description: description.trim() || undefined,
        prep_type: prepType,
        est_time_min: estTime ? parseInt(estTime) : undefined,
      });
      router.refresh();
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
      className="mb-4 bg-surface rounded-xl border border-ink-light/10 p-4"
    >
      <div className="space-y-3">
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Prep component name (e.g., Onion Base Gravy)"
          className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm
            focus:outline-none focus:border-primary/40"
          autoFocus
        />

        <input
          type="text"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="Description (optional)"
          className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm
            focus:outline-none focus:border-primary/40"
        />

        <div className="flex gap-3">
          <select
            value={prepType}
            onChange={(e) => setPrepType(e.target.value)}
            className="px-3 py-2 rounded-lg border border-ink-light/20 text-sm
              focus:outline-none focus:border-primary/40"
          >
            {prepTypes.map((t) => (
              <option key={t.value} value={t.value}>
                {t.label}
              </option>
            ))}
          </select>

          <input
            type="number"
            value={estTime}
            onChange={(e) => setEstTime(e.target.value)}
            placeholder="Est. minutes"
            className="w-28 px-3 py-2 rounded-lg border border-ink-light/20 text-sm
              focus:outline-none focus:border-primary/40"
            min="1"
          />
        </div>

        <div className="flex gap-2 justify-end">
          <button
            type="button"
            onClick={onDone}
            className="px-4 py-2 rounded-lg text-sm text-ink-muted hover:text-ink transition-colors"
          >
            Cancel
          </button>
          <button
            type="submit"
            disabled={loading || !name.trim()}
            className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-medium
              hover:bg-primary/90 disabled:opacity-50 transition-colors"
          >
            {loading ? "Creating..." : "Create"}
          </button>
        </div>
      </div>
    </form>
  );
}

// ---------------------------------------------------------------------------
// Prep component card with recipe linking
// ---------------------------------------------------------------------------

function PrepComponentCard({
  component,
  allRecipes,
}: {
  component: PrepComponentWithRecipes;
  allRecipes: Recipe[];
}) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  const [showLinkRecipe, setShowLinkRecipe] = useState(false);

  const linkedRecipeIds = new Set(
    component.recipe_prep_components.map((rpc) => rpc.recipe_id)
  );
  const unlinkedRecipes = allRecipes.filter(
    (r) => !linkedRecipeIds.has(r.id)
  );

  function handleArchive() {
    startTransition(async () => {
      try {
        await archivePrepComponent(component.id);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  function handleLink(recipeId: string) {
    startTransition(async () => {
      try {
        await linkPrepToRecipe(component.id, recipeId);
        setShowLinkRecipe(false);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  function handleUnlink(recipeId: string) {
    startTransition(async () => {
      try {
        await unlinkPrepFromRecipe(component.id, recipeId);
        router.refresh();
      } catch {
        // Silently fail
      }
    });
  }

  const PREP_TYPE_LABELS: Record<string, string> = {
    chop: "🔪 Chop",
    cook: "🍳 Cook",
    marinate: "🥩 Marinate",
    grind: "⚙️ Grind",
    soak: "💧 Soak",
    other: "📋 Other",
  };

  return (
    <div
      className={`bg-surface rounded-xl border border-ink-light/10 p-4 ${
        isPending ? "opacity-50" : ""
      }`}
    >
      <div className="flex items-start justify-between">
        <div>
          <h4 className="text-sm font-semibold text-ink">{component.name}</h4>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-[10px] px-1.5 py-0.5 rounded bg-ink-light/10 text-ink-muted">
              {PREP_TYPE_LABELS[component.prep_type] ?? component.prep_type}
            </span>
            {component.est_time_min && (
              <span className="text-[10px] text-ink-muted">
                ~{component.est_time_min} min
              </span>
            )}
          </div>
          {component.description && (
            <p className="text-xs text-ink-muted mt-1">
              {component.description}
            </p>
          )}
        </div>

        <div className="flex gap-1 shrink-0">
          <button
            onClick={() => setShowLinkRecipe(!showLinkRecipe)}
            className="text-xs px-2 py-1 rounded bg-primary/10 text-primary
              hover:bg-primary/20 transition-colors"
          >
            🔗
          </button>
          <button
            onClick={handleArchive}
            className="text-xs px-2 py-1 rounded bg-ink-light/5 text-ink-muted
              hover:bg-red-50 hover:text-red-600 transition-colors"
          >
            🗑
          </button>
        </div>
      </div>

      {/* Linked recipes */}
      {component.recipe_prep_components.length > 0 && (
        <div className="mt-2 flex flex-wrap gap-1.5">
          {component.recipe_prep_components.map((rpc) => (
            <span
              key={rpc.recipe_id}
              className="inline-flex items-center gap-1 text-[11px] px-2 py-0.5 rounded-full
                bg-secondary/10 text-secondary font-medium"
            >
              {rpc.recipes.title}
              <button
                onClick={() => handleUnlink(rpc.recipe_id)}
                className="hover:text-red-600 transition-colors"
              >
                ×
              </button>
            </span>
          ))}
        </div>
      )}

      {/* Link recipe dropdown */}
      {showLinkRecipe && (
        <div className="mt-3 bg-cream/50 rounded-lg p-2 max-h-40 overflow-y-auto">
          {unlinkedRecipes.length > 0 ? (
            unlinkedRecipes.map((r) => (
              <button
                key={r.id}
                onClick={() => handleLink(r.id)}
                className="w-full text-left px-2 py-1.5 rounded text-xs text-ink
                  hover:bg-primary/10 transition-colors"
              >
                {r.title}
              </button>
            ))
          ) : (
            <p className="text-xs text-ink-muted text-center py-2">
              All recipes linked
            </p>
          )}
        </div>
      )}
    </div>
  );
}
