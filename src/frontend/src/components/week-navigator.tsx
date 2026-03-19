"use client";

import { useRouter } from "next/navigation";
import { shiftWeek, formatWeekRange, getMonday } from "@/lib/actions/planner-actions";

export default function WeekNavigator({
  currentMonday,
  basePath = "/planner",
}: {
  currentMonday: string;
  basePath?: string;
}) {
  const router = useRouter();
  const todayMonday = getMonday();
  const isCurrentWeek = currentMonday === todayMonday;

  function goToWeek(monday: string) {
    router.push(`${basePath}?week=${monday}`);
  }

  return (
    <div className="flex items-center justify-center gap-3 mb-6">
      {/* Previous week */}
      <button
        onClick={() => goToWeek(shiftWeek(currentMonday, -1))}
        className="p-2 rounded-lg text-ink-muted hover:text-ink hover:bg-surface transition-colors"
        aria-label="Previous week"
      >
        <svg
          className="w-5 h-5"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth={2}
            d="M15 19l-7-7 7-7"
          />
        </svg>
      </button>

      {/* Current week label */}
      <div className="text-center">
        <h2 className="text-lg font-semibold text-ink">
          {formatWeekRange(currentMonday)}
        </h2>
        {isCurrentWeek && (
          <p className="text-xs text-secondary font-medium">This week</p>
        )}
      </div>

      {/* Next week */}
      <button
        onClick={() => goToWeek(shiftWeek(currentMonday, 1))}
        className="p-2 rounded-lg text-ink-muted hover:text-ink hover:bg-surface transition-colors"
        aria-label="Next week"
      >
        <svg
          className="w-5 h-5"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth={2}
            d="M9 5l7 7-7 7"
          />
        </svg>
      </button>

      {/* Today button (only show when not on current week) */}
      {!isCurrentWeek && (
        <button
          onClick={() => goToWeek(todayMonday)}
          className="ml-2 px-3 py-1 rounded-full text-xs font-medium text-primary bg-primary/10 hover:bg-primary/20 transition-colors"
        >
          Today
        </button>
      )}
    </div>
  );
}
