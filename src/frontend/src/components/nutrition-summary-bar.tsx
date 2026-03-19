"use client";

import Link from "next/link";
import type { WeekNutrition } from "@/lib/types/database";

export default function NutritionSummaryBar({
  weekNutrition,
  currentMonday,
}: {
  weekNutrition: WeekNutrition | null;
  currentMonday: string;
}) {
  if (!weekNutrition) return null;

  const { avgCalories, avgProtein, avgCarbs, avgFat, imbalancedDayCount, pregnancyAlertCount } =
    weekNutrition;

  // Don't show bar if all zeros (no recipes assigned yet)
  if (avgCalories === 0 && avgProtein === 0 && avgCarbs === 0 && avgFat === 0) {
    return null;
  }

  return (
    <Link
      href={`/nutrition?week=${currentMonday}`}
      className="block mt-4 px-4 py-3 bg-surface border border-accent/20 rounded-xl
        hover:border-primary/30 hover:shadow-sm transition-all group"
    >
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4 flex-wrap">
          {/* Macro summary */}
          <div className="flex items-center gap-3 text-sm">
            <span className="text-ink-muted">This week avg:</span>
            <MacroPill label="Cal" value={avgCalories} unit="" color="text-ink" />
            <MacroPill label="P" value={avgProtein} unit="g" color="text-blue-600" />
            <MacroPill label="C" value={avgCarbs} unit="g" color="text-amber-600" />
            <MacroPill label="F" value={avgFat} unit="g" color="text-orange-600" />
          </div>

          {/* Flags */}
          <div className="flex items-center gap-2">
            {imbalancedDayCount > 0 && (
              <span className="text-xs px-2 py-0.5 rounded-full bg-red-50 text-red-700 font-medium">
                📉 {imbalancedDayCount} {imbalancedDayCount === 1 ? "day" : "days"} low
              </span>
            )}
            {pregnancyAlertCount > 0 && (
              <span className="text-xs px-2 py-0.5 rounded-full bg-amber-50 text-amber-700 font-medium">
                ⚠️ {pregnancyAlertCount} pregnancy {pregnancyAlertCount === 1 ? "alert" : "alerts"}
              </span>
            )}
          </div>
        </div>

        {/* Arrow */}
        <span className="text-ink-muted group-hover:text-primary transition-colors text-sm shrink-0 ml-2">
          Details →
        </span>
      </div>
    </Link>
  );
}

function MacroPill({
  label,
  value,
  unit,
  color,
}: {
  label: string;
  value: number;
  unit: string;
  color: string;
}) {
  return (
    <span className={`font-semibold ${color}`}>
      <span className="text-ink-muted font-normal text-xs">{label}</span>{" "}
      {Math.round(value)}
      {unit && <span className="text-xs font-normal">{unit}</span>}
    </span>
  );
}
