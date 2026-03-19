"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import DayColumn from "@/components/day-column";
import SlotEditorModal from "@/components/slot-editor-modal";
import NutritionSummaryBar from "@/components/nutrition-summary-bar";
import { getMonday } from "@/lib/actions/planner-actions";
import { autoFillWeek } from "@/lib/actions/suggestion-actions";
import type {
  WeekPlan,
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  HouseholdMember,
  Recipe,
  WeekNutrition,
  PregnancyAlert,
  DietaryConflictMap,
  MemberDietaryPref,
  RecipePreference,
} from "@/lib/types/database";

export default function PlannerGrid({
  weekPlan,
  slots,
  participants,
  members,
  recipes,
  weekNutrition,
  pregnancyAlertsBySlot,
  dietaryConflictMap,
  dietaryPrefs,
  recipePreferences,
  repeatedSlotIds,
}: {
  weekPlan: WeekPlan;
  slots: MealSlotWithDishes[];
  participants: MealSlotParticipantWithMember[];
  members: HouseholdMember[];
  recipes: Recipe[];
  weekNutrition?: WeekNutrition | null;
  pregnancyAlertsBySlot?: Record<string, PregnancyAlert[]>;
  dietaryConflictMap?: DietaryConflictMap;
  dietaryPrefs?: MemberDietaryPref[];
  recipePreferences?: RecipePreference[];
  repeatedSlotIds?: string[];
}) {
  const router = useRouter();
  const [selectedSlotId, setSelectedSlotId] = useState<string | null>(null);
  const [filling, setFilling] = useState(false);
  const [fillError, setFillError] = useState<string | null>(null);
  const todayRef = useRef<HTMLDivElement>(null);

  // Auto-scroll to today's column on mount (mobile)
  useEffect(() => {
    if (todayRef.current) {
      todayRef.current.scrollIntoView({ behavior: "smooth", block: "nearest" });
    }
  }, []);

  // Group slots by date
  const slotsByDate = new Map<string, MealSlotWithDishes[]>();
  for (const slot of slots) {
    const existing = slotsByDate.get(slot.slot_date) ?? [];
    existing.push(slot);
    slotsByDate.set(slot.slot_date, existing);
  }

  // Group participants by slot ID
  const participantsBySlot = new Map<string, MealSlotParticipantWithMember[]>();
  for (const p of participants) {
    const existing = participantsBySlot.get(p.meal_slot_id) ?? [];
    existing.push(p);
    participantsBySlot.set(p.meal_slot_id, existing);
  }

  // Build 7 days from the week plan's start_date
  const days: string[] = [];
  const startDate = new Date(weekPlan.start_date + "T00:00:00");
  for (let i = 0; i < 7; i++) {
    const d = new Date(startDate);
    d.setDate(startDate.getDate() + i);
    days.push(`${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`);
  }

  const now = new Date();
  const todayStr = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}-${String(now.getDate()).padStart(2, "0")}`;
  const todayMonday = getMonday();
  const isCurrentWeek = weekPlan.start_date === todayMonday;

  // Check if there are empty cook slots (for auto-fill button visibility)
  const hasEmptyCookSlots = slots.some(
    (s) => s.meal_mode === "cook" && !s.recipe_id
  );

  async function handleAutoFill() {
    setFilling(true);
    setFillError(null);
    try {
      const { filledCount } = await autoFillWeek(weekPlan.id);
      if (filledCount === 0) {
        setFillError("No slots could be filled. Try adding more recipes.");
      }
      router.refresh();
    } catch (err) {
      setFillError(err instanceof Error ? err.message : "Auto-fill failed");
    } finally {
      setFilling(false);
    }
  }

  // Find the selected slot + its participants for the editor
  const selectedSlot = selectedSlotId
    ? slots.find((s) => s.id === selectedSlotId) ?? null
    : null;
  const selectedParticipants = selectedSlotId
    ? participantsBySlot.get(selectedSlotId) ?? []
    : [];

  return (
    <>
      {/* Auto-fill button + error */}
      {hasEmptyCookSlots && (
        <div className="mb-3 flex items-center gap-3 flex-wrap">
          <button
            onClick={handleAutoFill}
            disabled={filling}
            className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold
              hover:bg-primary-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed
              flex items-center gap-1.5"
          >
            {filling ? (
              <>
                <svg className="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" />
                </svg>
                Filling...
              </>
            ) : (
              <>✨ Auto-fill Week</>
            )}
          </button>
          {fillError && (
            <span className="text-xs text-red-500">{fillError}</span>
          )}
        </div>
      )}

      <div className="flex flex-col gap-3 md:grid md:grid-cols-7 md:gap-2">
        {days.map((date) => {
          const isToday = isCurrentWeek && date === todayStr;
          return (
            <div key={date} ref={isToday ? todayRef : undefined}>
              <DayColumn
                date={date}
                isToday={isToday}
                slots={slotsByDate.get(date) ?? []}
                participantsBySlot={participantsBySlot}
                allSlots={slots}
                pregnancyAlertsBySlot={pregnancyAlertsBySlot ?? {}}
                dietaryConflictMap={dietaryConflictMap ?? {}}
                repeatedSlotIds={new Set(repeatedSlotIds ?? [])}
                onSlotClick={(slotId) => setSelectedSlotId(slotId)}
              />
            </div>
          );
        })}
      </div>

      {/* Nutrition Summary Bar — below the week grid */}
      <NutritionSummaryBar
        weekNutrition={weekNutrition ?? null}
        currentMonday={weekPlan.start_date}
      />

      {selectedSlot && (
        <SlotEditorModal
          slot={selectedSlot}
          participants={selectedParticipants}
          recipes={recipes}
          allSlots={slots}
          members={members}
          dietaryConflictMap={dietaryConflictMap ?? {}}
          dietaryPrefs={dietaryPrefs ?? []}
          recipePreferences={recipePreferences ?? []}
          weekStart={weekPlan.start_date}
          onClose={() => setSelectedSlotId(null)}
        />
      )}
    </>
  );
}
