"use client";

import type { PrepBlock } from "@/lib/types/database";

const DAY_NAMES = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

export default function PrepBlockCard({ block }: { block: PrepBlock }) {
  return (
    <div className="bg-surface rounded-xl border border-ink-light/10 overflow-hidden">
      {/* Block header */}
      <div className="px-4 py-3 bg-cream/50 flex items-center justify-between">
        <h3 className="text-sm font-semibold text-ink">{block.label}</h3>
        <span className="text-xs text-ink-muted font-medium">
          ~{block.totalTimeMin} min
        </span>
      </div>

      {/* Auto-detected items */}
      {block.items.length > 0 && (
        <div className="divide-y divide-ink-light/5">
          {block.items.map((item, idx) => {
            const days = item.slotDates.map((d) => {
              const date = new Date(d + "T00:00:00");
              return DAY_NAMES[date.getDay()];
            });

            return (
              <div key={idx} className="px-4 py-3">
                <div className="flex items-center justify-between">
                  <div className="flex-1">
                    <p className="text-sm font-medium text-ink">
                      {formatPrepAction(item.prepType)} {item.ingredientName}
                    </p>
                    <p className="text-xs text-ink-muted mt-0.5">
                      Used in: {item.recipeSources.join(", ")}
                    </p>
                  </div>
                  <div className="text-right shrink-0 ml-3">
                    <p className="text-sm font-semibold text-primary">
                      {item.displayQuantity}
                      <span className="text-xs font-normal text-ink-muted ml-0.5">
                        {item.displayUnit}
                      </span>
                    </p>
                    <div className="flex gap-1 justify-end mt-0.5">
                      {days.map((day, i) => (
                        <span
                          key={i}
                          className="text-[10px] px-1.5 py-0.5 rounded bg-primary/10 text-primary font-medium"
                        >
                          {day}
                        </span>
                      ))}
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Manual prep items */}
      {block.manualItems.length > 0 && (
        <div className="divide-y divide-ink-light/5 border-t border-ink-light/10">
          {block.manualItems.map((comp) => {
            const linkedRecipes = comp.recipe_prep_components
              .map((rpc) => rpc.recipes.title)
              .join(", ");

            return (
              <div key={comp.id} className="px-4 py-3">
                <div className="flex items-center justify-between">
                  <div className="flex-1">
                    <p className="text-sm font-medium text-ink">
                      {comp.name}
                      <span className="ml-1.5 text-[10px] px-1.5 py-0.5 rounded bg-accent/10 text-accent-dark font-medium">
                        custom
                      </span>
                    </p>
                    {comp.description && (
                      <p className="text-xs text-ink-muted mt-0.5">
                        {comp.description}
                      </p>
                    )}
                    {linkedRecipes && (
                      <p className="text-xs text-ink-muted mt-0.5">
                        Used in: {linkedRecipes}
                      </p>
                    )}
                  </div>
                  {comp.est_time_min && (
                    <span className="text-xs text-ink-muted font-medium shrink-0 ml-3">
                      ~{comp.est_time_min} min
                    </span>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

function formatPrepAction(prepType: string): string {
  switch (prepType) {
    case "chop":
      return "Chop";
    case "cook":
      return "Cook";
    case "marinate":
      return "Marinate";
    case "grind":
      return "Grind";
    case "soak":
      return "Soak";
    default:
      return "Prep";
  }
}
