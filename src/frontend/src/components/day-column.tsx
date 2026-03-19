"use client";

import MealSlotCard from "@/components/meal-slot-card";
import { getSlotRecipeIds } from "@/lib/meal-utils";
import type {
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  PregnancyAlert,
  DietaryConflictMap,
} from "@/lib/types/database";

const DAY_NAMES = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const MEAL_ORDER = ["breakfast", "lunch", "dinner", "snack"];

export default function DayColumn({
  date,
  isToday,
  slots,
  participantsBySlot,
  allSlots,
  pregnancyAlertsBySlot,
  dietaryConflictMap,
  repeatedSlotIds,
  onSlotClick,
}: {
  date: string;
  isToday: boolean;
  slots: MealSlotWithDishes[];
  participantsBySlot: Map<string, MealSlotParticipantWithMember[]>;
  allSlots: MealSlotWithDishes[];
  pregnancyAlertsBySlot: Record<string, PregnancyAlert[]>;
  dietaryConflictMap: DietaryConflictMap;
  repeatedSlotIds?: Set<string>;
  onSlotClick: (slotId: string) => void;
}) {
  const d = new Date(date + "T00:00:00");
  const dayName = DAY_NAMES[d.getDay()];
  const dayNum = d.getDate();

  // Sort slots by meal order
  const sortedSlots = [...slots].sort(
    (a, b) => MEAL_ORDER.indexOf(a.meal_type) - MEAL_ORDER.indexOf(b.meal_type)
  );

  return (
    <div
      className={`bg-surface rounded-xl border overflow-hidden ${
        isToday
          ? "border-primary/40 ring-2 ring-primary/20"
          : "border-ink-light/10"
      }`}
    >
      {/* Day header */}
      <div
        className={`px-3 py-2 flex items-center gap-2 ${
          isToday ? "bg-primary/5" : "bg-cream"
        }`}
      >
        <span
          className={`text-sm font-semibold ${
            isToday ? "text-primary" : "text-ink"
          }`}
        >
          {dayName}
        </span>
        <span
          className={`text-xs px-1.5 py-0.5 rounded-full ${
            isToday
              ? "bg-primary text-white font-bold"
              : "text-ink-muted"
          }`}
        >
          {dayNum}
        </span>
      </div>

      {/* Meal slots */}
      <div>
        {sortedSlots.length > 0 ? (
          sortedSlots.map((slot) => (
            <MealSlotCard
              key={slot.id}
              slot={slot}
              participants={participantsBySlot.get(slot.id) ?? []}
              allSlots={allSlots}
              hasPregnancyAlert={
                (pregnancyAlertsBySlot[slot.id]?.length ?? 0) > 0
              }
              hasDietaryConflict={
                getSlotRecipeIds(slot).some(
                  (rid) => (dietaryConflictMap[rid]?.length ?? 0) > 0
                )
              }
              isRepeated={repeatedSlotIds?.has(slot.id) ?? false}
              onClick={() => onSlotClick(slot.id)}
            />
          ))
        ) : (
          // Placeholder if no slots for this day (shouldn't happen normally)
          <div className="px-3 py-4 text-center text-xs text-ink-muted">
            No meals
          </div>
        )}
      </div>
    </div>
  );
}
