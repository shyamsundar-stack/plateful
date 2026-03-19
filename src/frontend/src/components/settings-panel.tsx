"use client";

import { useState, useEffect, useCallback } from "react";
import { useRouter } from "next/navigation";
import type { Household, HouseholdMember, MemberDietaryPref } from "@/lib/types/database";
import {
  updateHouseholdName,
  updateMemberProfile,
  addHouseholdMember,
  archiveHouseholdMember,
  fetchDietaryPrefs,
  addDietaryPref,
  deleteDietaryPref,
  fetchParticipationDefaults,
  upsertParticipationDefault,
} from "@/lib/actions/settings-actions";
import ConfirmDialog from "./confirm-dialog";

export default function SettingsPanel({
  household,
  members,
}: {
  household: Household;
  members: HouseholdMember[];
}) {
  const router = useRouter();
  const [hhName, setHhName] = useState(household.name);
  const [hhSaving, setHhSaving] = useState(false);
  const [newMemberName, setNewMemberName] = useState("");
  const [addingMember, setAddingMember] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleHouseholdNameSave() {
    if (!hhName.trim() || hhName.trim() === household.name) return;
    setHhSaving(true);
    setError(null);
    try {
      await updateHouseholdName(household.id, hhName);
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save");
    } finally {
      setHhSaving(false);
    }
  }

  async function handleAddMember() {
    if (!newMemberName.trim()) return;
    setAddingMember(true);
    setError(null);
    try {
      await addHouseholdMember(household.id, newMemberName);
      setNewMemberName("");
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to add member");
    } finally {
      setAddingMember(false);
    }
  }

  return (
    <div className="space-y-8">
      {error && (
        <div className="p-3 rounded-lg bg-red-50 text-red-600 text-sm">
          {error}
        </div>
      )}

      {/* ── Household Name ── */}
      <section className="bg-surface rounded-xl border border-ink-light/10 p-5">
        <h2 className="text-lg font-bold text-ink mb-3 flex items-center gap-2">
          <span>🏠</span> Household
        </h2>
        <div className="flex gap-3 items-end">
          <div className="flex-1">
            <label className="text-xs font-medium text-ink-muted block mb-1">
              Household Name
            </label>
            <input
              type="text"
              value={hhName}
              onChange={(e) => setHhName(e.target.value)}
              className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm
                focus:outline-none focus:border-primary/40"
            />
          </div>
          <button
            onClick={handleHouseholdNameSave}
            disabled={hhSaving || !hhName.trim() || hhName.trim() === household.name}
            className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-medium
              hover:bg-primary/90 disabled:opacity-50 transition-colors shrink-0"
          >
            {hhSaving ? "Saving..." : "Save"}
          </button>
        </div>
      </section>

      {/* ── Members ── */}
      <section>
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-bold text-ink flex items-center gap-2">
            <span>👥</span> Members
          </h2>
        </div>

        <div className="space-y-4">
          {members.map((member) => (
            <MemberCard key={member.id} member={member} />
          ))}
        </div>

        {/* Add member form */}
        <div className="mt-4 bg-surface rounded-xl border border-ink-light/10 p-4">
          <h3 className="text-sm font-semibold text-ink mb-2">Add Member</h3>
          <div className="flex gap-3">
            <input
              type="text"
              value={newMemberName}
              onChange={(e) => setNewMemberName(e.target.value)}
              placeholder="Member name"
              className="flex-1 px-3 py-2 rounded-lg border border-ink-light/20 text-sm
                focus:outline-none focus:border-primary/40"
              onKeyDown={(e) => e.key === "Enter" && handleAddMember()}
            />
            <button
              onClick={handleAddMember}
              disabled={addingMember || !newMemberName.trim()}
              className="px-4 py-2 rounded-lg bg-primary/10 text-primary text-sm font-medium
                hover:bg-primary/20 disabled:opacity-50 transition-colors shrink-0"
            >
              {addingMember ? "Adding..." : "+ Add"}
            </button>
          </div>
        </div>
      </section>

      {/* ── App ── */}
      <section className="bg-surface rounded-xl border border-ink-light/10 p-5">
        <h2 className="text-lg font-bold text-ink mb-3 flex items-center gap-2">
          <span>📱</span> App
        </h2>
        <button
          onClick={() => {
            localStorage.removeItem("plateful-tour-completed");
            router.push("/planner?tour=1");
          }}
          className="px-4 py-2 rounded-lg border border-ink-light/20 text-sm text-ink-muted
            hover:text-ink hover:border-ink-light/40 transition-colors"
        >
          🔄 Replay Feature Tour
        </button>
      </section>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Member profile card with edit form + dietary prefs + participation defaults
// ---------------------------------------------------------------------------

type ParticipationDefault = {
  id: string;
  member_id: string;
  meal_type: string;
  day_of_week: number | null;
  is_participating: boolean;
  serving_factor: number;
};

function MemberCard({ member }: { member: HouseholdMember }) {
  const router = useRouter();
  const [isEditing, setIsEditing] = useState(false);
  const [activeTab, setActiveTab] = useState<"profile" | "dietary" | "meals">("profile");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [showArchiveDialog, setShowArchiveDialog] = useState(false);

  // Profile form state
  const [name, setName] = useState(member.name);
  const [age, setAge] = useState(member.age?.toString() ?? "");
  const [heightCm, setHeightCm] = useState(member.height_cm?.toString() ?? "");
  const [weightKg, setWeightKg] = useState(member.weight_kg?.toString() ?? "");
  const [biologicalSex, setBiologicalSex] = useState<string>(member.biological_sex ?? "");
  const [activityLevel, setActivityLevel] = useState(member.activity_level ?? "");
  const [goal, setGoal] = useState(member.goal ?? "");
  const [dietaryNotes, setDietaryNotes] = useState(member.dietary_notes ?? "");
  const [pregnancyTrimester, setPregnancyTrimester] = useState(member.pregnancy_trimester.toString());
  const [dietaryMode, setDietaryMode] = useState(member.dietary_mode ?? "non_vegetarian");

  // Dietary prefs state (loaded on demand)
  const [dietaryPrefs, setDietaryPrefs] = useState<MemberDietaryPref[]>([]);
  const [prefsLoaded, setPrefsLoaded] = useState(false);
  const [newPrefType, setNewPrefType] = useState<"allergy" | "hard_no" | "dislike" | "prefer">("allergy");
  const [newPrefName, setNewPrefName] = useState("");

  // Participation defaults state (loaded on demand)
  const [partDefaults, setPartDefaults] = useState<ParticipationDefault[]>([]);
  const [partLoaded, setPartLoaded] = useState(false);

  const activityOptions = [
    { value: "", label: "Not set" },
    { value: "sedentary", label: "Sedentary (desk job)" },
    { value: "light", label: "Light (1-3 days/week)" },
    { value: "moderate", label: "Moderate (3-5 days/week)" },
    { value: "active", label: "Active (6-7 days/week)" },
    { value: "very_active", label: "Very active (physical job)" },
  ];

  const goalOptions = [
    { value: "", label: "Not set" },
    { value: "maintain", label: "Maintain weight" },
    { value: "lose", label: "Lose weight" },
    { value: "gain", label: "Gain weight" },
    { value: "muscle", label: "Build muscle" },
  ];

  const PREF_TYPE_LABELS: Record<string, { label: string; color: string }> = {
    allergy: { label: "🚨 Allergy", color: "bg-red-100 text-red-700" },
    hard_no: { label: "🚫 Never", color: "bg-orange-100 text-orange-700" },
    dislike: { label: "👎 Avoid", color: "bg-amber-100 text-amber-700" },
    prefer: { label: "👍 Prefer", color: "bg-green-100 text-green-700" },
  };

  const MEAL_TYPES = ["breakfast", "lunch", "dinner", "snack"] as const;
  const MEAL_LABELS: Record<string, string> = {
    breakfast: "🌅 Breakfast",
    lunch: "☀️ Lunch",
    dinner: "🌙 Dinner",
    snack: "🍪 Snack",
  };

  // Load dietary prefs when tab switches
  const loadPrefs = useCallback(async () => {
    if (prefsLoaded) return;
    try {
      const data = await fetchDietaryPrefs(member.id);
      setDietaryPrefs(data as MemberDietaryPref[]);
      setPrefsLoaded(true);
    } catch {
      // silently fail
    }
  }, [member.id, prefsLoaded]);

  // Load participation defaults when tab switches
  const loadPartDefaults = useCallback(async () => {
    if (partLoaded) return;
    try {
      const data = await fetchParticipationDefaults(member.id);
      setPartDefaults(data as ParticipationDefault[]);
      setPartLoaded(true);
    } catch {
      // silently fail
    }
  }, [member.id, partLoaded]);

  useEffect(() => {
    if (activeTab === "dietary") loadPrefs();
    if (activeTab === "meals") loadPartDefaults();
  }, [activeTab, loadPrefs, loadPartDefaults]);

  async function handleSave() {
    setSaving(true);
    setError(null);
    try {
      await updateMemberProfile(member.id, {
        name: name.trim(),
        age: age ? parseInt(age) : null,
        height_cm: heightCm ? parseFloat(heightCm) : null,
        weight_kg: weightKg ? parseFloat(weightKg) : null,
        biological_sex: biologicalSex ? (biologicalSex as "male" | "female" | "other") : null,
        activity_level: activityLevel || null,
        goal: goal || null,
        dietary_notes: dietaryNotes.trim() || null,
        pregnancy_trimester: parseInt(pregnancyTrimester) || 0,
        dietary_mode: dietaryMode as "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan",
      });
      setIsEditing(false);
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save");
    } finally {
      setSaving(false);
    }
  }

  async function handleArchive() {
    try {
      await archiveHouseholdMember(member.id);
      router.refresh();
    } catch {
      setError("Failed to remove member");
    }
    setShowArchiveDialog(false);
  }

  async function handleAddPref() {
    if (!newPrefName.trim()) return;
    setSaving(true);
    try {
      await addDietaryPref(member.id, {
        pref_type: newPrefType,
        ingredient_name: newPrefName.trim(),
      });
      setNewPrefName("");
      setPrefsLoaded(false);
      loadPrefs();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to add preference");
    } finally {
      setSaving(false);
    }
  }

  async function handleDeletePref(prefId: string) {
    try {
      await deleteDietaryPref(prefId);
      setDietaryPrefs((prev) => prev.filter((p) => p.id !== prefId));
    } catch {
      setError("Failed to delete preference");
    }
  }

  async function handleToggleMealDefault(mealType: string, currentlyParticipating: boolean) {
    const currentDefault = partDefaults.find(
      (d) => d.meal_type === mealType && d.day_of_week === null
    );
    const servingFactor = currentDefault?.serving_factor ?? 1.0;
    try {
      await upsertParticipationDefault(member.id, mealType, !currentlyParticipating, servingFactor);
      setPartLoaded(false);
      loadPartDefaults();
    } catch {
      setError("Failed to update meal default");
    }
  }

  async function handleServingFactorChange(mealType: string, factor: number) {
    const currentDefault = partDefaults.find(
      (d) => d.meal_type === mealType && d.day_of_week === null
    );
    const isParticipating = currentDefault?.is_participating ?? true;
    try {
      await upsertParticipationDefault(member.id, mealType, isParticipating, factor);
      setPartLoaded(false);
      loadPartDefaults();
    } catch {
      setError("Failed to update serving factor");
    }
  }

  function getMealDefault(mealType: string): { participating: boolean; servingFactor: number } {
    const d = partDefaults.find((p) => p.meal_type === mealType && p.day_of_week === null);
    return {
      participating: d?.is_participating ?? true, // default: participating
      servingFactor: d?.serving_factor ?? 1.0,
    };
  }

  const hasProfile = member.age != null && member.height_cm != null && member.weight_kg != null;

  return (
    <div className="bg-surface rounded-xl border border-ink-light/10 overflow-hidden">
      {/* Header — click to expand */}
      <div
        className="px-5 py-4 flex items-center justify-between cursor-pointer hover:bg-cream/30 transition-colors"
        onClick={() => setIsEditing(!isEditing)}
      >
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-lg">
            {member.name.charAt(0).toUpperCase()}
          </div>
          <div>
            <h3 className="text-sm font-semibold text-ink">{member.name}</h3>
            <div className="flex items-center gap-2 text-xs text-ink-muted">
              {member.age && <span>{member.age}y</span>}
              {member.biological_sex && <span>{member.biological_sex}</span>}
              {member.activity_level && <span>{member.activity_level}</span>}
              {!hasProfile && (
                <span className="text-amber-600 font-medium">⚠️ Profile incomplete</span>
              )}
            </div>
          </div>
        </div>
        <span className="text-ink-muted text-sm">{isEditing ? "▲" : "▼"}</span>
      </div>

      {/* Expanded edit area */}
      {isEditing && (
        <div className="px-5 pb-5 border-t border-ink-light/10 pt-4">
          {error && (
            <div className="mb-3 p-2 rounded-lg bg-red-50 text-red-600 text-xs">{error}</div>
          )}

          {/* Tab switcher */}
          <div className="flex gap-1 mb-4 bg-cream/50 rounded-lg p-1">
            {(["profile", "dietary", "meals"] as const).map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`flex-1 px-3 py-1.5 rounded-md text-xs font-medium transition-colors ${
                  activeTab === tab
                    ? "bg-surface text-ink shadow-sm"
                    : "text-ink-muted hover:text-ink"
                }`}
              >
                {tab === "profile" ? "👤 Profile" : tab === "dietary" ? "🥗 Dietary" : "🍽️ Meals"}
              </button>
            ))}
          </div>

          {/* ═══ Profile Tab ═══ */}
          {activeTab === "profile" && (
            <>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="sm:col-span-2">
                  <label className="text-xs font-medium text-ink-muted block mb-1">Name</label>
                  <input type="text" value={name} onChange={(e) => setName(e.target.value)}
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40" />
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Age</label>
                  <input type="number" value={age} onChange={(e) => setAge(e.target.value)}
                    placeholder="e.g., 30" min="1" max="120"
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40" />
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Biological Sex</label>
                  <select value={biologicalSex} onChange={(e) => setBiologicalSex(e.target.value)}
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40">
                    <option value="">Not set</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                  </select>
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Height (cm)</label>
                  <input type="number" value={heightCm} onChange={(e) => setHeightCm(e.target.value)}
                    placeholder="e.g., 170" min="30" max="300" step="0.1"
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40" />
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Weight (kg)</label>
                  <input type="number" value={weightKg} onChange={(e) => setWeightKg(e.target.value)}
                    placeholder="e.g., 70" min="5" max="500" step="0.1"
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40" />
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Activity Level</label>
                  <select value={activityLevel} onChange={(e) => setActivityLevel(e.target.value)}
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40">
                    {activityOptions.map((opt) => <option key={opt.value} value={opt.value}>{opt.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Goal</label>
                  <select value={goal} onChange={(e) => setGoal(e.target.value)}
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40">
                    {goalOptions.map((opt) => <option key={opt.value} value={opt.value}>{opt.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="text-xs font-medium text-ink-muted block mb-1">Dietary Mode</label>
                  <select value={dietaryMode} onChange={(e) => setDietaryMode(e.target.value as "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan")}
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40">
                    <option value="non_vegetarian">Non-Vegetarian</option>
                    <option value="vegetarian">Vegetarian</option>
                    <option value="eggetarian">Eggetarian</option>
                    <option value="vegan">Vegan</option>
                  </select>
                </div>
                {(biologicalSex === "female" || biologicalSex === "other") && (
                  <div>
                    <label className="text-xs font-medium text-ink-muted block mb-1">Pregnancy</label>
                    <select value={pregnancyTrimester} onChange={(e) => setPregnancyTrimester(e.target.value)}
                      className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40">
                      <option value="0">Not pregnant</option>
                      <option value="1">1st Trimester</option>
                      <option value="2">2nd Trimester</option>
                      <option value="3">3rd Trimester</option>
                    </select>
                  </div>
                )}
                <div className="sm:col-span-2">
                  <label className="text-xs font-medium text-ink-muted block mb-1">Dietary Notes</label>
                  <input type="text" value={dietaryNotes} onChange={(e) => setDietaryNotes(e.target.value)}
                    placeholder="e.g., Lactose intolerant, no peanuts"
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40" />
                </div>
              </div>

              <div className="flex items-center justify-between mt-4 pt-3 border-t border-ink-light/10">
                <button onClick={() => setShowArchiveDialog(true)}
                  className="text-xs text-red-500 hover:text-red-700 transition-colors">
                  Remove member
                </button>
                <div className="flex gap-2">
                  <button onClick={() => setIsEditing(false)}
                    className="px-4 py-2 rounded-lg text-sm text-ink-muted hover:text-ink transition-colors">
                    Cancel
                  </button>
                  <button onClick={handleSave} disabled={saving || !name.trim()}
                    className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-medium hover:bg-primary/90 disabled:opacity-50 transition-colors">
                    {saving ? "Saving..." : "Save Changes"}
                  </button>
                </div>
              </div>
            </>
          )}

          {/* ═══ Dietary Preferences Tab ═══ */}
          {activeTab === "dietary" && (
            <div>
              <p className="text-xs text-ink-muted mb-3">
                Add food allergies, restrictions, or preferences. These help flag unsafe recipes during meal planning.
              </p>

              {/* Existing prefs */}
              {dietaryPrefs.length > 0 && (
                <div className="space-y-2 mb-4">
                  {dietaryPrefs.map((pref) => {
                    const label = PREF_TYPE_LABELS[pref.pref_type] ?? { label: pref.pref_type, color: "bg-ink-light/10 text-ink" };
                    return (
                      <div key={pref.id} className="flex items-center justify-between px-3 py-2 rounded-lg bg-cream/50">
                        <div className="flex items-center gap-2">
                          <span className={`text-[10px] px-1.5 py-0.5 rounded font-medium ${label.color}`}>
                            {label.label}
                          </span>
                          <span className="text-sm text-ink">
                            {pref.ingredient_name ?? "Unknown"}
                          </span>
                          {pref.notes && (
                            <span className="text-xs text-ink-muted">({pref.notes})</span>
                          )}
                        </div>
                        <button onClick={() => handleDeletePref(pref.id)}
                          className="text-xs text-red-500 hover:text-red-700 transition-colors">
                          ×
                        </button>
                      </div>
                    );
                  })}
                </div>
              )}

              {dietaryPrefs.length === 0 && prefsLoaded && (
                <div className="text-center py-4 bg-cream/30 rounded-lg mb-4">
                  <p className="text-xs text-ink-muted">No dietary preferences set</p>
                </div>
              )}

              {/* Add new pref */}
              <div className="flex gap-2 items-end">
                <div className="w-32">
                  <label className="text-xs font-medium text-ink-muted block mb-1">Type</label>
                  <select value={newPrefType} onChange={(e) => setNewPrefType(e.target.value as typeof newPrefType)}
                    className="w-full px-2 py-2 rounded-lg border border-ink-light/20 text-xs focus:outline-none focus:border-primary/40">
                    <option value="allergy">🚨 Allergy</option>
                    <option value="hard_no">🚫 Never</option>
                    <option value="dislike">👎 Avoid</option>
                    <option value="prefer">👍 Prefer</option>
                  </select>
                </div>
                <div className="flex-1">
                  <label className="text-xs font-medium text-ink-muted block mb-1">Ingredient</label>
                  <input type="text" value={newPrefName} onChange={(e) => setNewPrefName(e.target.value)}
                    placeholder="e.g., Peanuts, Shellfish"
                    onKeyDown={(e) => e.key === "Enter" && handleAddPref()}
                    className="w-full px-3 py-2 rounded-lg border border-ink-light/20 text-sm focus:outline-none focus:border-primary/40" />
                </div>
                <button onClick={handleAddPref} disabled={saving || !newPrefName.trim()}
                  className="px-3 py-2 rounded-lg bg-primary/10 text-primary text-sm font-medium hover:bg-primary/20 disabled:opacity-50 transition-colors shrink-0">
                  Add
                </button>
              </div>
            </div>
          )}

          {/* ═══ Meal Defaults Tab ═══ */}
          {activeTab === "meals" && (
            <div>
              <p className="text-xs text-ink-muted mb-3">
                Set which meals {member.name} usually eats and their portion size. New week plans will use these defaults.
              </p>

              <div className="space-y-3">
                {MEAL_TYPES.map((mealType) => {
                  const defaults = getMealDefault(mealType);
                  return (
                    <div key={mealType} className="flex items-center justify-between px-3 py-3 rounded-lg bg-cream/50">
                      <div className="flex items-center gap-3">
                        <input
                          type="checkbox"
                          checked={defaults.participating}
                          onChange={() => handleToggleMealDefault(mealType, defaults.participating)}
                          className="w-5 h-5 rounded border-ink-light/30 text-primary focus:ring-2 focus:ring-primary/50 cursor-pointer"
                        />
                        <span className="text-sm font-medium text-ink">
                          {MEAL_LABELS[mealType]}
                        </span>
                      </div>
                      <div className="flex items-center gap-2">
                        <label className="text-xs text-ink-muted">Portion:</label>
                        <select
                          value={defaults.servingFactor.toString()}
                          onChange={(e) => handleServingFactorChange(mealType, parseFloat(e.target.value))}
                          className="px-2 py-1 rounded border border-ink-light/20 text-xs focus:outline-none focus:border-primary/40"
                        >
                          <option value="0.5">½ serving</option>
                          <option value="0.75">¾ serving</option>
                          <option value="1">1 serving</option>
                          <option value="1.25">1¼ servings</option>
                          <option value="1.5">1½ servings</option>
                          <option value="2">2 servings</option>
                        </select>
                      </div>
                    </div>
                  );
                })}
              </div>

              <p className="text-[10px] text-ink-light mt-3">
                These defaults apply to all days. When you create a new week plan, each member&apos;s
                participation will be set automatically based on these settings.
              </p>
            </div>
          )}

          {showArchiveDialog && (
            <ConfirmDialog
              title="Remove Member"
              message={`Are you sure you want to remove "${member.name}" from your household? Their participation data will be preserved but they won't appear in member lists.`}
              confirmLabel="Remove"
              confirmVariant="danger"
              onConfirm={handleArchive}
              onCancel={() => setShowArchiveDialog(false)}
            />
          )}
        </div>
      )}
    </div>
  );
}
