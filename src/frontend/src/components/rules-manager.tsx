"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import type {
  MealRule,
  FestivalCalendarEntry,
  HouseholdMember,
} from "@/lib/types/database";
import {
  createMealRule,
  deleteMealRule,
  toggleMealRule,
} from "@/lib/actions/rule-actions";
import ConfirmDialog from "./confirm-dialog";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const CONDITION_TYPES = [
  { value: "day_of_week", label: "Day of week" },
  { value: "meal_type", label: "Meal type" },
  { value: "date_range", label: "Date range" },
  { value: "festival", label: "Festival" },
] as const;

const ACTION_TYPES = [
  { value: "set_dietary_mode", label: "Set dietary mode" },
  { value: "prefer_cuisine", label: "Prefer cuisine" },
  { value: "exclude_ingredient", label: "Exclude ingredient" },
  { value: "include_tag", label: "Include tag" },
] as const;

const DAY_NAMES: Record<number, string> = {
  1: "Mon", 2: "Tue", 3: "Wed", 4: "Thu", 5: "Fri", 6: "Sat", 7: "Sun",
};

const DIETARY_MODES = ["vegetarian", "vegan", "eggetarian", "non_vegetarian"];

// ---------------------------------------------------------------------------
// Human-readable rule description
// ---------------------------------------------------------------------------

function describeRule(rule: MealRule, festivals: FestivalCalendarEntry[]): string {
  let condition = "";
  switch (rule.condition_type) {
    case "day_of_week": {
      const days = rule.condition_value.split(",").map((d) => DAY_NAMES[parseInt(d.trim())] ?? d);
      condition = `on ${days.join(", ")}`;
      break;
    }
    case "meal_type":
      condition = `for ${rule.condition_value}`;
      break;
    case "date_range": {
      const [start, end] = rule.condition_value.split("|");
      condition = `${start} to ${end}`;
      break;
    }
    case "festival": {
      const fest = festivals.find((f) => f.name.toLowerCase() === rule.condition_value.toLowerCase());
      condition = `during ${fest?.display_name ?? rule.condition_value}`;
      break;
    }
  }

  let action = "";
  switch (rule.action_type) {
    case "set_dietary_mode":
      action = `→ ${rule.action_value}`;
      break;
    case "prefer_cuisine":
      action = `→ prefer ${rule.action_value} cuisine`;
      break;
    case "exclude_ingredient":
      action = `→ exclude ${rule.action_value}`;
      break;
    case "include_tag":
      action = `→ boost "${rule.action_value}" tag`;
      break;
  }

  return `${condition} ${action}`;
}

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

type RulesManagerProps = {
  rules: MealRule[];
  festivals: FestivalCalendarEntry[];
  members: HouseholdMember[];
};

export default function RulesManager({
  rules: initialRules,
  festivals,
  members,
}: RulesManagerProps) {
  const router = useRouter();
  const [rules, setRules] = useState(initialRules);
  const [showAddForm, setShowAddForm] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [deleteRuleId, setDeleteRuleId] = useState<string | null>(null);

  // Form state for new rule
  const [ruleName, setRuleName] = useState("");
  const [memberId, setMemberId] = useState<string>("");
  const [conditionType, setConditionType] = useState<MealRule["condition_type"]>("day_of_week");
  const [conditionValue, setConditionValue] = useState("");
  const [actionType, setActionType] = useState<MealRule["action_type"]>("set_dietary_mode");
  const [actionValue, setActionValue] = useState("vegetarian");

  // Day checkboxes
  const [selectedDays, setSelectedDays] = useState<number[]>([]);

  function resetForm() {
    setRuleName("");
    setMemberId("");
    setConditionType("day_of_week");
    setConditionValue("");
    setActionType("set_dietary_mode");
    setActionValue("vegetarian");
    setSelectedDays([]);
    setShowAddForm(false);
  }

  function toggleDay(day: number) {
    setSelectedDays((prev) =>
      prev.includes(day) ? prev.filter((d) => d !== day) : [...prev, day].sort()
    );
  }

  async function handleCreate() {
    let finalConditionValue = conditionValue;

    if (conditionType === "day_of_week") {
      if (selectedDays.length === 0) {
        setError("Select at least one day");
        return;
      }
      finalConditionValue = selectedDays.join(",");
    }

    if (!ruleName.trim()) {
      setError("Give your rule a name");
      return;
    }
    if (!finalConditionValue.trim()) {
      setError("Condition value is required");
      return;
    }
    if (!actionValue.trim()) {
      setError("Action value is required");
      return;
    }

    setSaving(true);
    setError(null);
    try {
      const newRule = await createMealRule({
        rule_name: ruleName,
        member_id: memberId || null,
        condition_type: conditionType,
        condition_value: finalConditionValue,
        action_type: actionType,
        action_value: actionValue,
      });
      setRules((prev) => [...prev, newRule]);
      resetForm();
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to create rule");
    } finally {
      setSaving(false);
    }
  }

  async function handleToggle(ruleId: string, isActive: boolean) {
    try {
      await toggleMealRule(ruleId, !isActive);
      setRules((prev) =>
        prev.map((r) => (r.id === ruleId ? { ...r, is_active: !isActive } : r))
      );
    } catch {
      setError("Failed to toggle rule");
    }
  }

  async function handleDelete() {
    if (!deleteRuleId) return;
    try {
      await deleteMealRule(deleteRuleId);
      setRules((prev) => prev.filter((r) => r.id !== deleteRuleId));
      router.refresh();
    } catch {
      setError("Failed to delete rule");
    }
    setDeleteRuleId(null);
  }

  return (
    <section className="bg-surface rounded-xl border border-ink-light/10 p-5">
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-lg font-bold text-ink flex items-center gap-2">
          <span>📋</span> Meal Rules
        </h2>
        <button
          type="button"
          onClick={() => setShowAddForm(!showAddForm)}
          className="px-3 py-1.5 rounded-lg bg-primary/10 text-primary text-xs font-medium hover:bg-primary/20 transition-colors"
        >
          {showAddForm ? "Cancel" : "+ Add Rule"}
        </button>
      </div>

      <p className="text-xs text-ink-muted mb-4">
        Set conditional preferences: IF a condition is met THEN apply an action to meal suggestions.
      </p>

      {error && (
        <div className="p-2 rounded-lg bg-red-50 text-red-600 text-xs mb-3">{error}</div>
      )}

      {/* Existing rules */}
      {rules.length > 0 ? (
        <div className="space-y-2 mb-4">
          {rules.map((rule) => (
            <div
              key={rule.id}
              className={`flex items-center justify-between px-3 py-3 rounded-lg transition-colors ${
                rule.is_active ? "bg-cream/50" : "bg-cream/20 opacity-60"
              }`}
            >
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-medium text-ink truncate">{rule.rule_name}</span>
                  {rule.member_id && (
                    <span className="text-[10px] px-1.5 py-0.5 rounded bg-primary/10 text-primary-dark">
                      {members.find((m) => m.id === rule.member_id)?.name ?? "Member"}
                    </span>
                  )}
                </div>
                <p className="text-xs text-ink-muted mt-0.5">
                  {describeRule(rule, festivals)}
                </p>
              </div>
              <div className="flex items-center gap-2 ml-3 flex-shrink-0">
                {/* Toggle switch */}
                <button
                  type="button"
                  onClick={() => handleToggle(rule.id, rule.is_active)}
                  className={`relative w-10 h-5 rounded-full transition-colors ${
                    rule.is_active ? "bg-primary" : "bg-ink-light/30"
                  }`}
                >
                  <span
                    className={`absolute top-0.5 w-4 h-4 rounded-full bg-white shadow transition-transform ${
                      rule.is_active ? "left-5" : "left-0.5"
                    }`}
                  />
                </button>
                {/* Delete */}
                <button
                  type="button"
                  onClick={() => setDeleteRuleId(rule.id)}
                  className="text-xs text-red-500 hover:text-red-700 transition-colors"
                >
                  ×
                </button>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="text-center py-6 bg-cream/30 rounded-lg mb-4">
          <p className="text-xs text-ink-muted">
            No meal rules yet. Add rules like &ldquo;Thursdays = Vegetarian&rdquo; or &ldquo;During Navratri = Veg only&rdquo;.
          </p>
        </div>
      )}

      {/* Add rule form */}
      {showAddForm && (
        <div className="border border-ink-light/10 rounded-lg p-4 space-y-3 bg-cream/20">
          {/* Rule name */}
          <div>
            <label className="text-xs font-medium text-ink-muted block mb-1">Rule Name</label>
            <input
              type="text"
              value={ruleName}
              onChange={(e) => setRuleName(e.target.value)}
              placeholder='e.g., "Thursday Veg" or "Navratri Fasting"'
              className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
            />
          </div>

          {/* Apply to */}
          <div>
            <label className="text-xs font-medium text-ink-muted block mb-1">Apply To</label>
            <select
              value={memberId}
              onChange={(e) => setMemberId(e.target.value)}
              className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
            >
              <option value="">Everyone</option>
              {members.map((m) => (
                <option key={m.id} value={m.id}>{m.name}</option>
              ))}
            </select>
          </div>

          {/* IF condition */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div>
              <label className="text-xs font-medium text-ink-muted block mb-1">IF (Condition)</label>
              <select
                value={conditionType}
                onChange={(e) => {
                  setConditionType(e.target.value as MealRule["condition_type"]);
                  setConditionValue("");
                  setSelectedDays([]);
                }}
                className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
              >
                {CONDITION_TYPES.map((ct) => (
                  <option key={ct.value} value={ct.value}>{ct.label}</option>
                ))}
              </select>
            </div>

            <div>
              <label className="text-xs font-medium text-ink-muted block mb-1">Condition Value</label>
              {conditionType === "day_of_week" ? (
                <div className="flex gap-1 flex-wrap">
                  {[1, 2, 3, 4, 5, 6, 7].map((day) => (
                    <button
                      key={day}
                      type="button"
                      onClick={() => toggleDay(day)}
                      className={`px-2 py-1.5 rounded text-xs font-medium transition-colors ${
                        selectedDays.includes(day)
                          ? "bg-primary text-white"
                          : "bg-surface text-ink-muted border border-ink-light/20 hover:border-primary/50"
                      }`}
                    >
                      {DAY_NAMES[day]}
                    </button>
                  ))}
                </div>
              ) : conditionType === "meal_type" ? (
                <select
                  value={conditionValue}
                  onChange={(e) => setConditionValue(e.target.value)}
                  className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
                >
                  <option value="">Select meal...</option>
                  <option value="breakfast">Breakfast</option>
                  <option value="lunch">Lunch</option>
                  <option value="dinner">Dinner</option>
                  <option value="snack">Snack</option>
                </select>
              ) : conditionType === "festival" ? (
                <select
                  value={conditionValue}
                  onChange={(e) => setConditionValue(e.target.value)}
                  className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
                >
                  <option value="">Select festival...</option>
                  {festivals.map((f) => (
                    <option key={f.id} value={f.name}>{f.display_name}</option>
                  ))}
                </select>
              ) : (
                <input
                  type="text"
                  value={conditionValue}
                  onChange={(e) => setConditionValue(e.target.value)}
                  placeholder="e.g., 2026-03-01|2026-03-15"
                  className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
                />
              )}
            </div>
          </div>

          {/* THEN action */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div>
              <label className="text-xs font-medium text-ink-muted block mb-1">THEN (Action)</label>
              <select
                value={actionType}
                onChange={(e) => {
                  setActionType(e.target.value as MealRule["action_type"]);
                  if (e.target.value === "set_dietary_mode") setActionValue("vegetarian");
                  else setActionValue("");
                }}
                className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
              >
                {ACTION_TYPES.map((at) => (
                  <option key={at.value} value={at.value}>{at.label}</option>
                ))}
              </select>
            </div>

            <div>
              <label className="text-xs font-medium text-ink-muted block mb-1">Action Value</label>
              {actionType === "set_dietary_mode" ? (
                <select
                  value={actionValue}
                  onChange={(e) => setActionValue(e.target.value)}
                  className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
                >
                  {DIETARY_MODES.map((dm) => (
                    <option key={dm} value={dm}>{dm.replace(/_/g, " ")}</option>
                  ))}
                </select>
              ) : (
                <input
                  type="text"
                  value={actionValue}
                  onChange={(e) => setActionValue(e.target.value)}
                  placeholder={
                    actionType === "prefer_cuisine"
                      ? "e.g., arabian"
                      : actionType === "exclude_ingredient"
                      ? "e.g., chicken"
                      : "e.g., jain"
                  }
                  className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40"
                />
              )}
            </div>
          </div>

          {/* Create button */}
          <button
            type="button"
            onClick={handleCreate}
            disabled={saving}
            className="w-full py-2.5 rounded-lg bg-primary text-white text-sm font-semibold hover:bg-primary-dark transition-colors disabled:opacity-50"
          >
            {saving ? "Creating..." : "Create Rule"}
          </button>
        </div>
      )}

      {/* Delete confirmation */}
      {deleteRuleId && (
        <ConfirmDialog
          title="Delete Rule"
          message="Are you sure you want to delete this meal rule?"
          confirmLabel="Delete"
          confirmVariant="danger"
          onConfirm={handleDelete}
          onCancel={() => setDeleteRuleId(null)}
        />
      )}
    </section>
  );
}
