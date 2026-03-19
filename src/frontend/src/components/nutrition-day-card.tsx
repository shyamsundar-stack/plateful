"use client";

import type {
  DayNutrition,
  MemberTargets,
  ImbalanceFlag,
  PregnancyAlert,
  SwapSuggestion,
} from "@/lib/types/database";
import { getImbalanceFlags } from "@/lib/nutrition";

const DAY_NAMES = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

export default function NutritionDayCard({
  day,
  memberTargets,
  swapSuggestion,
}: {
  day: DayNutrition;
  memberTargets: Map<string, MemberTargets>;
  swapSuggestion?: SwapSuggestion | null;
}) {
  const d = new Date(day.date + "T00:00:00");
  const dayName = DAY_NAMES[d.getDay()];
  const dayNum = d.getDate();

  // Collect imbalance flags per member
  const allFlags: Array<{
    memberName: string;
    flags: ImbalanceFlag[];
  }> = [];

  for (const mn of day.perMember) {
    const targets = memberTargets.get(mn.memberId);
    if (!targets || targets.tdee == null) continue;
    const flags = getImbalanceFlags(
      { protein: mn.protein, carbs: mn.carbs, fat: mn.fat },
      targets
    );
    if (flags.some((f) => f.level !== "green")) {
      allFlags.push({ memberName: mn.memberName, flags });
    }
  }

  const hasRedFlag = allFlags.some((mf) =>
    mf.flags.some((f) => f.level === "red")
  );
  const hasYellowFlag =
    !hasRedFlag &&
    allFlags.some((mf) => mf.flags.some((f) => f.level === "yellow"));

  return (
    <div
      className={`bg-surface rounded-xl border p-4 ${
        hasRedFlag
          ? "border-red-200"
          : hasYellowFlag
            ? "border-amber-200"
            : "border-ink-light/10"
      }`}
    >
      {/* Day header */}
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center gap-2">
          <span className="text-sm font-semibold text-ink">{dayName}</span>
          <span className="text-xs text-ink-muted">{dayNum}</span>
          {day.isPartial && (
            <span className="text-xs px-1.5 py-0.5 rounded-full bg-ink-light/10 text-ink-muted">
              ❓ Partial data
            </span>
          )}
        </div>
        <div className="flex items-center gap-1">
          {hasRedFlag && (
            <span className="text-xs px-1.5 py-0.5 rounded-full bg-red-50 text-red-700 font-medium">
              🔴
            </span>
          )}
          {hasYellowFlag && (
            <span className="text-xs px-1.5 py-0.5 rounded-full bg-amber-50 text-amber-700 font-medium">
              🟡
            </span>
          )}
          {!hasRedFlag && !hasYellowFlag && !day.isPartial && (
            <span className="text-xs px-1.5 py-0.5 rounded-full bg-green-50 text-green-700 font-medium">
              🟢
            </span>
          )}
        </div>
      </div>

      {/* Macro summary */}
      <div className="grid grid-cols-4 gap-2 mb-3">
        <MacroBox label="Calories" value={day.totalCalories} unit="kcal" />
        <MacroBox label="Protein" value={day.totalProtein} unit="g" color="text-blue-600" />
        <MacroBox label="Carbs" value={day.totalCarbs} unit="g" color="text-amber-600" />
        <MacroBox label="Fat" value={day.totalFat} unit="g" color="text-orange-600" />
      </div>

      {/* Per-member breakdown */}
      {day.perMember.length > 0 && (
        <div className="space-y-2 mb-3">
          {day.perMember.map((mn) => {
            const targets = memberTargets.get(mn.memberId);
            const flags = targets
              ? getImbalanceFlags(
                  { protein: mn.protein, carbs: mn.carbs, fat: mn.fat },
                  targets
                )
              : [];

            return (
              <div
                key={mn.memberId}
                className="bg-cream/50 rounded-lg px-3 py-2"
              >
                <div className="flex items-center justify-between mb-1">
                  <span className="text-xs font-semibold text-ink">
                    {mn.memberName}
                    {mn.isPartial && (
                      <span className="ml-1 text-ink-muted font-normal">
                        (partial)
                      </span>
                    )}
                  </span>
                  <span className="text-xs text-ink-muted">
                    {Math.round(mn.calories)} kcal
                  </span>
                </div>

                {/* Macro bars */}
                <div className="flex gap-3 text-[11px]">
                  <MacroInline
                    label="P"
                    value={mn.protein}
                    target={targets?.proteinTarget ?? null}
                    flag={flags.find((f) => f.macro === "protein")}
                  />
                  <MacroInline
                    label="C"
                    value={mn.carbs}
                    target={targets?.carbsTarget ?? null}
                    flag={flags.find((f) => f.macro === "carbs")}
                  />
                  <MacroInline
                    label="F"
                    value={mn.fat}
                    target={targets?.fatTarget ?? null}
                    flag={flags.find((f) => f.macro === "fat")}
                  />
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Swap suggestion */}
      {swapSuggestion && !day.isPartial && (
        <div className="bg-blue-50 rounded-lg px-3 py-2 mb-3">
          <p className="text-xs text-blue-800">
            💡 Replace{" "}
            <span className="font-semibold">
              {swapSuggestion.currentRecipeTitle}
            </span>{" "}
            →{" "}
            <span className="font-semibold">
              {swapSuggestion.suggestedRecipeTitle}
            </span>{" "}
            <span className="text-blue-600">({swapSuggestion.macroDelta})</span>
          </p>
        </div>
      )}

      {/* Pregnancy alerts */}
      {day.pregnancyAlerts.length > 0 && (
        <PregnancyAlertPanel alerts={day.pregnancyAlerts} />
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Sub-components
// ---------------------------------------------------------------------------

function MacroBox({
  label,
  value,
  unit,
  color,
}: {
  label: string;
  value: number;
  unit: string;
  color?: string;
}) {
  return (
    <div className="text-center">
      <p className={`text-sm font-semibold ${color ?? "text-ink"}`}>
        {Math.round(value)}
        <span className="text-[10px] font-normal text-ink-muted ml-0.5">
          {unit}
        </span>
      </p>
      <p className="text-[10px] text-ink-muted">{label}</p>
    </div>
  );
}

function MacroInline({
  label,
  value,
  target,
  flag,
}: {
  label: string;
  value: number;
  target: number | null;
  flag?: ImbalanceFlag;
}) {
  const flagIcon =
    flag?.level === "red"
      ? "🔴"
      : flag?.level === "yellow"
        ? "🟡"
        : "";

  return (
    <span className="text-ink-muted">
      <span className="font-medium text-ink">{label}</span>{" "}
      {Math.round(value)}g
      {target != null && (
        <span className="text-ink-light">/{target}g</span>
      )}
      {flagIcon && <span className="ml-0.5">{flagIcon}</span>}
    </span>
  );
}

function PregnancyAlertPanel({ alerts }: { alerts: PregnancyAlert[] }) {
  // Group alerts by member
  const byMember = new Map<string, PregnancyAlert[]>();
  for (const alert of alerts) {
    const existing = byMember.get(alert.memberId) ?? [];
    existing.push(alert);
    byMember.set(alert.memberId, existing);
  }

  return (
    <div className="bg-amber-50 border border-amber-200 rounded-lg px-3 py-2">
      {Array.from(byMember.entries()).map(([memberId, memberAlerts]) => {
        const first = memberAlerts[0];
        const trimesterLabel =
          first.trimester > 0 ? ` (Trimester ${first.trimester})` : "";

        return (
          <div key={memberId} className="mb-1 last:mb-0">
            <p className="text-xs font-semibold text-amber-800">
              ⚠️ {first.memberName}
              {trimesterLabel}
            </p>
            <ul className="ml-4 mt-0.5">
              {memberAlerts.map((alert, i) => (
                <li key={i} className="text-xs text-amber-700 list-disc">
                  <span className="font-medium">{alert.ingredientName}</span>
                  {" — "}
                  {alert.warning}
                </li>
              ))}
            </ul>
          </div>
        );
      })}
    </div>
  );
}
