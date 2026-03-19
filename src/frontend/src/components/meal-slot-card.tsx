"use client";

import { useRouter } from "next/navigation";
import { toggleSlotLock } from "@/lib/actions/planner-actions";
import type {
  MealSlotWithRecipe,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
} from "@/lib/types/database";
import { isMultiDishSlot, getDishRoleEmoji } from "@/lib/meal-utils";

const MEAL_LABELS: Record<string, string> = {
  breakfast: "B",
  lunch: "L",
  dinner: "D",
  snack: "S",
};

const MEAL_COLORS: Record<string, string> = {
  breakfast: "bg-accent/60 text-ink",
  lunch: "bg-secondary/60 text-white",
  dinner: "bg-primary/60 text-white",
  snack: "bg-ink-light/40 text-ink",
};

const SHORT_DAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const MEAL_SHORT: Record<string, string> = {
  breakfast: "B",
  lunch: "L",
  dinner: "D",
  snack: "S",
};

export default function MealSlotCard({
  slot,
  participants,
  allSlots,
  hasPregnancyAlert,
  hasDietaryConflict,
  isRepeated,
  onClick,
}: {
  slot: MealSlotWithDishes;
  participants: MealSlotParticipantWithMember[];
  allSlots: (MealSlotWithRecipe | MealSlotWithDishes)[];
  hasPregnancyAlert?: boolean;
  hasDietaryConflict?: boolean;
  isRepeated?: boolean;
  onClick: () => void;
}) {
  const router = useRouter();

  // Find leftover source info if applicable
  const leftoverSource =
    slot.meal_mode === "leftover" && slot.leftover_source_id
      ? allSlots.find((s) => s.id === slot.leftover_source_id) ?? null
      : null;

  function formatSourceLabel(s: MealSlotWithRecipe): string {
    const sd = new Date(s.slot_date + "T00:00:00");
    return `${SHORT_DAYS[sd.getDay()]} ${MEAL_SHORT[s.meal_type] ?? s.meal_type}`;
  }

  async function handleLockToggle(e: React.MouseEvent) {
    e.stopPropagation(); // Don't open the modal
    try {
      await toggleSlotLock(slot.id, !slot.is_locked);
      router.refresh();
    } catch {
      // Silently fail — non-critical
    }
  }

  return (
    <div className="relative group">
      <button
        onClick={onClick}
        aria-label={
          slot.recipes
            ? `Edit ${slot.recipes.title} for ${slot.meal_type}`
            : `Add recipe for ${slot.meal_type}`
        }
        className={`w-full text-left px-2 py-2 border-t border-ink-light/5 cursor-pointer
          hover:bg-cream/50 transition-colors ${getSlotBg(slot)}`}
      >
        <div className="flex items-start gap-1.5">
          {/* Meal type badge */}
          <span
            className={`text-[10px] font-bold rounded px-1 py-0.5 leading-none shrink-0 mt-0.5
              ${MEAL_COLORS[slot.meal_type] ?? "bg-ink-light/20 text-ink-muted"}`}
          >
            {MEAL_LABELS[slot.meal_type] ?? "?"}
          </span>

          {/* Content */}
          <div className="flex-1 min-w-0">
            {slot.meal_mode === "cook" && isMultiDishSlot(slot) && slot.meal_slot_dishes?.length > 0 ? (
              /* Multi-dish display */
              <div>
                {slot.meal_slot_dishes
                  .sort((a, b) => a.sort_order - b.sort_order)
                  .slice(0, 3)
                  .map((dish) => (
                    <p key={dish.id} className="text-xs text-ink leading-tight line-clamp-1">
                      <span className="text-[10px]">{getDishRoleEmoji(dish.dish_role)}</span>{" "}
                      <span className="font-medium">{dish.recipes?.title ?? "?"}</span>
                    </p>
                  ))}
                {slot.meal_slot_dishes.length > 3 && (
                  <p className="text-[10px] text-ink-muted">
                    +{slot.meal_slot_dishes.length - 3} more
                  </p>
                )}
                <div className="flex items-center gap-1 mt-0.5">
                  {isRepeated && (
                    <span className="px-1 py-0.5 rounded text-[9px] font-bold bg-amber-100 text-amber-700" title="Repeated recipe within 3 days">🔁</span>
                  )}
                  {hasDietaryConflict && (
                    <span className="text-red-500 text-[10px]" title="Dietary conflict">🚨</span>
                  )}
                  {hasPregnancyAlert && (
                    <span className="text-amber-500 text-[10px]" title="Pregnancy safety alert">⚠️</span>
                  )}
                </div>
              </div>
            ) : slot.meal_mode === "cook" && slot.recipes ? (
              /* Single dish display (backward compat) */
              <div>
                <p className="text-xs font-medium text-ink leading-tight line-clamp-1">
                  {slot.recipes.title}
                  {isRepeated && (
                    <span className="ml-1 px-1 py-0.5 rounded text-[9px] font-bold bg-amber-100 text-amber-700" title="Repeated recipe within 3 days">🔁</span>
                  )}
                  {hasDietaryConflict && (
                    <span className="ml-1 text-red-500" title="Dietary conflict">🚨</span>
                  )}
                  {hasPregnancyAlert && (
                    <span className="ml-1 text-amber-500" title="Pregnancy safety alert">⚠️</span>
                  )}
                </p>
                <div className="flex items-center gap-1 mt-0.5">
                  {slot.recipes.is_vegetarian && (
                    <span className="text-[10px]">🟢</span>
                  )}
                  {slot.recipes.total_time_min && (
                    <span className="text-[10px] text-ink-muted">
                      {slot.recipes.total_time_min}m
                    </span>
                  )}
                </div>
              </div>
            ) : slot.meal_mode === "cook" ? (
              <p className="text-xs text-primary/70 group-hover:text-primary transition-colors font-medium flex items-center gap-0.5">
                <span className="text-sm leading-none">+</span> Add recipe
              </p>
            ) : slot.meal_mode === "leftover" && leftoverSource?.recipes ? (
              <div>
                <p className="text-xs font-medium text-accent-dark leading-tight line-clamp-1">
                  ♻️ {leftoverSource.recipes.title}
                  {hasDietaryConflict && (
                    <span className="ml-1 text-red-500" title="Dietary conflict">🚨</span>
                  )}
                  {hasPregnancyAlert && (
                    <span className="ml-1 text-amber-500" title="Pregnancy safety alert">⚠️</span>
                  )}
                </p>
                <p className="text-[10px] text-ink-muted mt-0.5">
                  {formatSourceLabel(leftoverSource)}
                </p>
              </div>
            ) : slot.meal_mode === "leftover" ? (
              <p className="text-xs text-ink-muted group-hover:text-accent-dark transition-colors">
                ♻️ Pick source
              </p>
            ) : slot.meal_mode === "eat_outside" ? (
              <p className="text-xs text-accent-dark font-medium">
                🍽️ Eating out
              </p>
            ) : slot.meal_mode === "skip" ? (
              <p className="text-xs text-ink-muted">&mdash; Skip</p>
            ) : null}

            {/* Participant initials — always show to prevent layout shift */}
            {slot.meal_mode !== "skip" && participants.length > 0 && (
              <div className="flex items-center gap-0.5 mt-1">
                {participants.slice(0, 4).map((p) => (
                  <span
                    key={p.id}
                    className={`w-4 h-4 rounded-full text-[8px] font-bold
                      flex items-center justify-center ${
                        p.is_participating
                          ? "bg-secondary/30 text-secondary-dark"
                          : "bg-ink-light/10 text-ink-light"
                      }`}
                    title={`${p.household_members.name}${p.is_participating ? "" : " (not eating)"}`}
                  >
                    {p.household_members.name.charAt(0).toUpperCase()}
                  </span>
                ))}
                {participants.length > 4 && (
                  <span className="text-[9px] text-ink-muted">
                    +{participants.length - 4}
                  </span>
                )}
              </div>
            )}
          </div>

          {/* Lock icon — visible on hover or when locked */}
          <span
            onClick={handleLockToggle}
            role="button"
            aria-label={slot.is_locked ? "Unlock slot" : "Lock slot to repeat weekly"}
            className={`shrink-0 mt-0.5 p-0.5 rounded transition-all cursor-pointer
              ${
                slot.is_locked
                  ? "text-primary opacity-100"
                  : "text-ink-light opacity-0 group-hover:opacity-70 hover:!opacity-100 hover:text-primary"
              }`}
            title={slot.is_locked ? "Locked (repeats weekly)" : "Lock to repeat weekly"}
          >
            {slot.is_locked ? (
              <svg className="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd" />
              </svg>
            ) : (
              <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z" />
              </svg>
            )}
          </span>
        </div>
      </button>
    </div>
  );
}

function getSlotBg(slot: MealSlotWithRecipe): string {
  if (slot.meal_mode === "eat_outside") return "bg-accent/5";
  if (slot.meal_mode === "leftover") return "bg-accent/5";
  if (slot.meal_mode === "skip") return "bg-ink-light/5";
  if (slot.meal_mode === "cook" && !slot.recipes) return "bg-primary/5 hover:bg-primary/10";
  return "";
}
