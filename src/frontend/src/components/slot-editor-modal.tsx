"use client";

import { useState, useMemo } from "react";
import { useRouter } from "next/navigation";
import {
  updateMealSlot,
  updateSlotParticipant,
  setSlotDishes,
} from "@/lib/actions/planner-actions";
import { logRecipePreference } from "@/lib/actions/preference-actions";
import { trackEvent } from "@/lib/actions/analytics-actions";
import { getConflictsForRecipe, getPrefTypeEmoji, sortConflictsBySeverity } from "@/lib/dietary";
import { rankRecipesByPreference, sortRecipesByPreference } from "@/lib/preferences";
import { isMultiDishSlot, getDishRoleLabel, getDishRoleColor } from "@/lib/meal-utils";
import ThaliTemplatePicker from "@/components/thali-template-picker";
import type {
  MealSlotWithDishes,
  MealSlotParticipantWithMember,
  Recipe,
  HouseholdMember,
  DietaryConflictMap,
  MemberDietaryPref,
  RecipePreference,
  RecipePreferenceScore,
  DietaryConflict,
} from "@/lib/types/database";

const DAY_NAMES = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
];

const SHORT_DAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

const MEAL_LABELS: Record<string, string> = {
  breakfast: "Breakfast",
  lunch: "Lunch",
  dinner: "Dinner",
  snack: "Snack",
};

const MEAL_SHORT: Record<string, string> = {
  breakfast: "B",
  lunch: "L",
  dinner: "D",
  snack: "S",
};

const MEAL_ORDER = ["breakfast", "lunch", "dinner", "snack"];

const MODES = [
  { value: "cook", label: "Cook", icon: "🍳" },
  { value: "eat_outside", label: "Eat Out", icon: "🍽️" },
  { value: "leftover", label: "Leftover", icon: "♻️" },
  { value: "skip", label: "Skip", icon: "⏭️" },
] as const;

type DishRole = "main" | "staple" | "side" | "accompaniment";

const DISH_ROLES: { role: DishRole; label: string; emoji: string; required: boolean }[] = [
  { role: "main", label: "Main (Protein/Gravy)", emoji: "🍛", required: true },
  { role: "staple", label: "Staple (Carb Base)", emoji: "🫓", required: false },
  { role: "side", label: "Side (Vegetable)", emoji: "🥗", required: false },
  { role: "accompaniment", label: "Extra (Raita/Chutney)", emoji: "🫙", required: false },
];

type CookTab = "single" | "build" | "template";

// Portion presets
const PORTION_OPTIONS = [
  { value: 0.5, label: "½x" },
  { value: 0.75, label: "¾x" },
  { value: 1.0, label: "1x" },
  { value: 1.5, label: "1½x" },
  { value: 2.0, label: "2x" },
];

export default function SlotEditorModal({
  slot,
  participants,
  recipes,
  allSlots,
  members,
  dietaryConflictMap,
  dietaryPrefs: _dietaryPrefs,
  recipePreferences,
  weekStart,
  onClose,
}: {
  slot: MealSlotWithDishes;
  participants: MealSlotParticipantWithMember[];
  recipes: Recipe[];
  allSlots: MealSlotWithDishes[];
  members: HouseholdMember[];
  dietaryConflictMap: DietaryConflictMap;
  dietaryPrefs: MemberDietaryPref[];
  recipePreferences: RecipePreference[];
  weekStart?: string;
  onClose: () => void;
}) {
  void _dietaryPrefs;
  void members;

  const router = useRouter();
  const [currentMode, setCurrentMode] = useState(slot.meal_mode);
  const [currentRecipeId, setCurrentRecipeId] = useState(slot.recipe_id);
  const [currentLeftoverSourceId, setCurrentLeftoverSourceId] = useState(
    slot.leftover_source_id
  );
  const [searchQuery, setSearchQuery] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Determine initial cook tab based on current slot state
  const initialTab: CookTab = isMultiDishSlot(slot) ? "build" : "single";
  const [cookTab, setCookTab] = useState<CookTab>(initialTab);

  // Build-a-Meal state: 4 role slots with optional recipe + portion
  type DishSlotState = {
    recipeId: string | null;
    portionFactor: number;
    searchQuery: string;
  };

  const buildInitialDishes = (): Record<DishRole, DishSlotState> => {
    const base: Record<DishRole, DishSlotState> = {
      main: { recipeId: null, portionFactor: 1.0, searchQuery: "" },
      staple: { recipeId: null, portionFactor: 1.0, searchQuery: "" },
      side: { recipeId: null, portionFactor: 1.0, searchQuery: "" },
      accompaniment: { recipeId: null, portionFactor: 1.0, searchQuery: "" },
    };

    // Pre-fill from existing multi-dish data
    if (slot.meal_slot_dishes && slot.meal_slot_dishes.length > 0) {
      for (const dish of slot.meal_slot_dishes) {
        const role = dish.dish_role as DishRole;
        if (base[role]) {
          base[role] = {
            recipeId: dish.recipe_id,
            portionFactor: dish.portion_factor,
            searchQuery: "",
          };
        }
      }
    } else if (slot.recipe_id) {
      // Legacy single-recipe → populate as main
      base.main.recipeId = slot.recipe_id;
    }

    return base;
  };

  const [buildDishes, setBuildDishes] = useState<Record<DishRole, DishSlotState>>(buildInitialDishes);

  const d = new Date(slot.slot_date + "T00:00:00");
  const dayName = DAY_NAMES[d.getDay()];
  const mealLabel = MEAL_LABELS[slot.meal_type] ?? slot.meal_type;

  // Get participating member IDs for conflict filtering
  const participatingMemberIds = useMemo(
    () => new Set(participants.filter((p) => p.is_participating).map((p) => p.member_id)),
    [participants]
  );

  // Compute preference scores for all recipes
  const preferenceScores = useMemo(
    () => rankRecipesByPreference(recipes, recipePreferences, slot.meal_type),
    [recipes, recipePreferences, slot.meal_type]
  );

  // Sort recipes by preference then filter by search
  const sortedRecipes = useMemo(
    () => sortRecipesByPreference(recipes, preferenceScores),
    [recipes, preferenceScores]
  );

  const filteredRecipes = sortedRecipes.filter((r) =>
    r.title.toLowerCase().includes(searchQuery.toLowerCase())
  );

  // Current recipe info (single recipe tab)
  const currentRecipe = currentRecipeId
    ? recipes.find((r) => r.id === currentRecipeId) ?? null
    : null;

  // Get dietary conflicts for current recipe
  const currentRecipeConflicts = useMemo(() => {
    if (!currentRecipeId) return [];
    return sortConflictsBySeverity(
      getConflictsForRecipe(currentRecipeId, dietaryConflictMap, participatingMemberIds)
    );
  }, [currentRecipeId, dietaryConflictMap, participatingMemberIds]);

  // Leftover source candidates
  const leftoverSources = allSlots
    .filter(
      (s) =>
        s.id !== slot.id &&
        s.meal_mode === "cook" &&
        s.recipes !== null &&
        s.recipe_id !== null
    )
    .sort((a, b) => {
      const dateCompare = a.slot_date.localeCompare(b.slot_date);
      if (dateCompare !== 0) return dateCompare;
      return MEAL_ORDER.indexOf(a.meal_type) - MEAL_ORDER.indexOf(b.meal_type);
    });

  const currentLeftoverSource = currentLeftoverSourceId
    ? allSlots.find((s) => s.id === currentLeftoverSourceId) ?? null
    : null;

  function formatSlotLabel(s: MealSlotWithDishes): string {
    const sd = new Date(s.slot_date + "T00:00:00");
    return `${SHORT_DAYS[sd.getDay()]} ${MEAL_SHORT[s.meal_type] ?? s.meal_type}`;
  }

  /** Get conflicts for a recipe in the picker list */
  function getRecipeConflicts(recipeId: string): DietaryConflict[] {
    return getConflictsForRecipe(recipeId, dietaryConflictMap, participatingMemberIds);
  }

  // ---------- HANDLERS ----------

  async function handleModeChange(mode: string) {
    setCurrentMode(mode as typeof currentMode);
    setSaving(true);
    setError(null);
    try {
      if (mode === "eat_outside" || mode === "skip") {
        await updateMealSlot(slot.id, {
          meal_mode: mode,
          recipe_id: null,
          leftover_source_id: null,
        });
        setCurrentRecipeId(null);
        setCurrentLeftoverSourceId(null);
      } else if (mode === "leftover") {
        await updateMealSlot(slot.id, {
          meal_mode: mode,
          recipe_id: null,
          leftover_source_id: null,
        });
        setCurrentRecipeId(null);
        setCurrentLeftoverSourceId(null);
      } else if (mode === "cook") {
        await updateMealSlot(slot.id, {
          meal_mode: mode,
          leftover_source_id: null,
        });
        setCurrentLeftoverSourceId(null);
      } else {
        await updateMealSlot(slot.id, { meal_mode: mode });
      }
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to update");
    } finally {
      setSaving(false);
    }
  }

  // Single-recipe tab: select recipe
  async function handleRecipeSelect(recipeId: string) {
    setCurrentRecipeId(recipeId);
    setSaving(true);
    setError(null);
    try {
      await updateMealSlot(slot.id, {
        recipe_id: recipeId,
        meal_mode: "cook",
      });
      // Also write into junction table as 'main' for dual-write compat
      await setSlotDishes(slot.id, [{ recipeId, dishRole: "main" }]);
      setCurrentMode("cook");
      trackEvent("meal_assigned", { slot_id: slot.id, recipe_id: recipeId, meal_type: slot.meal_type }).catch(() => {});

      const activeMemberIds = participants
        .filter((p) => p.is_participating)
        .map((p) => p.member_id);
      if (activeMemberIds.length > 0) {
        logRecipePreference(recipeId, activeMemberIds, "accept", slot.meal_type, weekStart).catch(() => {});
      }

      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to assign recipe");
    } finally {
      setSaving(false);
    }
  }

  async function handleRemoveRecipe() {
    const removedRecipeId = currentRecipeId;
    setCurrentRecipeId(null);
    setSaving(true);
    setError(null);
    try {
      await updateMealSlot(slot.id, { recipe_id: null });
      // Clear junction table too
      await setSlotDishes(slot.id, []);
      trackEvent("meal_removed", { slot_id: slot.id, recipe_id: removedRecipeId, meal_type: slot.meal_type }).catch(() => {});

      if (removedRecipeId) {
        const activeMemberIds = participants
          .filter((p) => p.is_participating)
          .map((p) => p.member_id);
        if (activeMemberIds.length > 0) {
          logRecipePreference(removedRecipeId, activeMemberIds, "reject", slot.meal_type, weekStart).catch(() => {});
        }
      }

      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to remove recipe");
    } finally {
      setSaving(false);
    }
  }

  // Build-a-Meal tab: save all dishes
  async function handleSaveBuildMeal() {
    const dishesToSave = DISH_ROLES
      .filter((dr) => buildDishes[dr.role].recipeId)
      .map((dr) => ({
        recipeId: buildDishes[dr.role].recipeId!,
        dishRole: dr.role,
        portionFactor: buildDishes[dr.role].portionFactor,
      }));

    if (dishesToSave.length === 0) {
      setError("Add at least one dish before saving.");
      return;
    }

    setSaving(true);
    setError(null);
    try {
      await setSlotDishes(slot.id, dishesToSave);
      // Ensure meal_mode is cook
      await updateMealSlot(slot.id, { meal_mode: "cook" });
      setCurrentMode("cook");
      trackEvent("multi_dish_assigned", { slot_id: slot.id, dish_count: dishesToSave.length, meal_type: slot.meal_type }).catch(() => {});
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save meal");
    } finally {
      setSaving(false);
    }
  }

  // Template tab: apply resolved dishes
  async function handleApplyTemplate(
    resolvedDishes: Array<{
      dishRole: DishRole;
      recipeId: string;
      portionFactor?: number;
    }>
  ) {
    setSaving(true);
    setError(null);
    try {
      await setSlotDishes(slot.id, resolvedDishes);
      await updateMealSlot(slot.id, { meal_mode: "cook" });
      setCurrentMode("cook");

      // Also populate the build tab state with applied template dishes
      const newBuild = { ...buildInitialDishes() };
      for (const dish of resolvedDishes) {
        newBuild[dish.dishRole] = {
          recipeId: dish.recipeId,
          portionFactor: dish.portionFactor ?? 1.0,
          searchQuery: "",
        };
      }
      setBuildDishes(newBuild);
      setCookTab("build");

      trackEvent("template_applied", { slot_id: slot.id, dish_count: resolvedDishes.length, meal_type: slot.meal_type }).catch(() => {});
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to apply template");
    } finally {
      setSaving(false);
    }
  }

  async function handleLeftoverSourceSelect(sourceSlotId: string) {
    setCurrentLeftoverSourceId(sourceSlotId);
    setSaving(true);
    setError(null);
    try {
      await updateMealSlot(slot.id, {
        meal_mode: "leftover",
        leftover_source_id: sourceSlotId,
        recipe_id: null,
      });
      setCurrentMode("leftover");
      router.refresh();
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to link leftover"
      );
    } finally {
      setSaving(false);
    }
  }

  async function handleRemoveLeftoverSource() {
    setCurrentLeftoverSourceId(null);
    setSaving(true);
    setError(null);
    try {
      await updateMealSlot(slot.id, { leftover_source_id: null });
      router.refresh();
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to remove leftover link"
      );
    } finally {
      setSaving(false);
    }
  }

  async function handleParticipantToggle(
    participantId: string,
    isParticipating: boolean
  ) {
    try {
      await updateSlotParticipant(participantId, isParticipating);
      router.refresh();
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to update participant"
      );
    }
  }

  // ---------- BUILD-A-MEAL HELPERS ----------

  function updateDishRecipe(role: DishRole, recipeId: string | null) {
    setBuildDishes((prev) => ({
      ...prev,
      [role]: { ...prev[role], recipeId, searchQuery: "" },
    }));
  }

  function updateDishPortion(role: DishRole, portionFactor: number) {
    setBuildDishes((prev) => ({
      ...prev,
      [role]: { ...prev[role], portionFactor },
    }));
  }

  function updateDishSearch(role: DishRole, query: string) {
    setBuildDishes((prev) => ({
      ...prev,
      [role]: { ...prev[role], searchQuery: query },
    }));
  }

  function clearDish(role: DishRole) {
    setBuildDishes((prev) => ({
      ...prev,
      [role]: { recipeId: null, portionFactor: 1.0, searchQuery: "" },
    }));
  }

  // Count non-empty dishes in build state
  const buildDishCount = DISH_ROLES.filter(
    (dr) => buildDishes[dr.role].recipeId
  ).length;

  // Check if build state differs from saved state
  const buildHasChanges = useMemo(() => {
    const currentDishMap = new Map(
      (slot.meal_slot_dishes ?? []).map((d) => [d.dish_role, { recipeId: d.recipe_id, portionFactor: d.portion_factor }])
    );

    for (const dr of DISH_ROLES) {
      const saved = currentDishMap.get(dr.role);
      const current = buildDishes[dr.role];
      if (saved && !current.recipeId) return true;
      if (!saved && current.recipeId) return true;
      if (saved && current.recipeId) {
        if (saved.recipeId !== current.recipeId) return true;
        if (saved.portionFactor !== current.portionFactor) return true;
      }
    }
    return false;
  }, [slot.meal_slot_dishes, buildDishes]);

  // ---------- RENDER ----------

  return (
    <div className="fixed inset-0 z-50 flex items-end md:items-center justify-center">
      {/* Backdrop */}
      <div
        className="absolute inset-0 bg-black/40"
        onClick={onClose}
      />

      {/* Modal panel */}
      <div className="relative w-full md:max-w-lg bg-surface rounded-t-2xl md:rounded-xl max-h-[85vh] overflow-y-auto">
        {/* Header */}
        <div className="sticky top-0 bg-surface px-4 py-3 border-b border-ink-light/10 flex items-center justify-between z-10">
          <h3 className="font-semibold text-ink">
            {dayName} {mealLabel}
          </h3>
          <button
            onClick={onClose}
            className="p-1 rounded-lg text-ink-muted hover:text-ink hover:bg-cream transition-colors"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <div className="p-4 space-y-5">
          {/* Error message */}
          {error && (
            <div className="p-2 rounded-lg bg-red-50 text-red-600 text-sm">
              {error}
            </div>
          )}

          {/* Meal Mode Selector */}
          <div>
            <label className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2 block">
              Meal Type
            </label>
            <div className="grid grid-cols-4 gap-2">
              {MODES.map((mode) => (
                <button
                  key={mode.value}
                  onClick={() => handleModeChange(mode.value)}
                  disabled={saving}
                  className={`px-2 py-2 rounded-lg text-sm font-medium transition-colors text-center
                    ${
                      currentMode === mode.value
                        ? "bg-primary text-white"
                        : "bg-cream text-ink-muted hover:bg-ink-light/10"
                    }
                    disabled:opacity-50`}
                >
                  <span className="block text-base mb-0.5">{mode.icon}</span>
                  <span className="text-xs">{mode.label}</span>
                </button>
              ))}
            </div>
          </div>

          {/* Cook mode: 3-tab interface */}
          {currentMode === "cook" && (
            <div>
              {/* Cook sub-tabs */}
              <div className="flex border-b border-ink-light/10 mb-3">
                {(
                  [
                    { key: "single", label: "Single Recipe" },
                    { key: "build", label: "Build a Meal" },
                    { key: "template", label: "Use Template" },
                  ] as const
                ).map((tab) => (
                  <button
                    key={tab.key}
                    onClick={() => setCookTab(tab.key)}
                    className={`flex-1 px-2 py-2.5 text-xs font-semibold transition-colors
                      ${
                        cookTab === tab.key
                          ? "text-primary border-b-2 border-primary"
                          : "text-ink-muted hover:text-ink"
                      }`}
                  >
                    {tab.label}
                  </button>
                ))}
              </div>

              {/* Tab 1: Single Recipe (existing picker) */}
              {cookTab === "single" && (
                <SingleRecipeTab
                  currentRecipe={currentRecipe}
                  currentRecipeConflicts={currentRecipeConflicts}
                  filteredRecipes={filteredRecipes}
                  searchQuery={searchQuery}
                  onSearchChange={setSearchQuery}
                  preferenceScores={preferenceScores}
                  saving={saving}
                  slotMealType={slot.meal_type}
                  onRecipeSelect={handleRecipeSelect}
                  onRemoveRecipe={handleRemoveRecipe}
                  getRecipeConflicts={getRecipeConflicts}
                />
              )}

              {/* Tab 2: Build a Meal */}
              {cookTab === "build" && (
                <BuildMealTab
                  buildDishes={buildDishes}
                  recipes={recipes}
                  preferenceScores={preferenceScores}
                  saving={saving}
                  buildDishCount={buildDishCount}
                  buildHasChanges={buildHasChanges}
                  dietaryConflictMap={dietaryConflictMap}
                  participatingMemberIds={participatingMemberIds}
                  onUpdateRecipe={updateDishRecipe}
                  onUpdatePortion={updateDishPortion}
                  onUpdateSearch={updateDishSearch}
                  onClearDish={clearDish}
                  onSave={handleSaveBuildMeal}
                />
              )}

              {/* Tab 3: Use Template */}
              {cookTab === "template" && (
                <ThaliTemplatePicker
                  slotMealType={slot.meal_type}
                  recipes={recipes}
                  saving={saving}
                  onApply={handleApplyTemplate}
                />
              )}
            </div>
          )}

          {/* Leftover Source Picker (only for leftover mode) */}
          {currentMode === "leftover" && (
            <div>
              <label className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2 block">
                Leftover from
              </label>

              {currentLeftoverSource && currentLeftoverSource.recipes ? (
                <div className="p-3 rounded-lg bg-accent/10 border border-accent/30">
                  <div className="flex items-start justify-between">
                    <div>
                      <p className="text-sm font-medium text-ink">
                        {currentLeftoverSource.recipes.title}
                      </p>
                      <p className="text-xs text-ink-muted mt-0.5">
                        {formatSlotLabel(currentLeftoverSource)}
                      </p>
                    </div>
                    <button
                      onClick={handleRemoveLeftoverSource}
                      disabled={saving}
                      className="text-xs text-red-500 hover:text-red-700 font-medium disabled:opacity-50"
                    >
                      Remove
                    </button>
                  </div>
                </div>
              ) : (
                <div className="max-h-48 overflow-y-auto rounded-lg border border-ink-light/10">
                  {leftoverSources.length > 0 ? (
                    leftoverSources.map((source) => (
                      <button
                        key={source.id}
                        onClick={() => handleLeftoverSourceSelect(source.id)}
                        disabled={saving}
                        className="w-full text-left px-3 py-2 hover:bg-cream transition-colors
                          border-b border-ink-light/5 last:border-b-0 disabled:opacity-50"
                      >
                        <div className="flex items-center gap-2">
                          <span className="text-xs font-bold text-ink-muted bg-ink-light/10 px-1.5 py-0.5 rounded">
                            {formatSlotLabel(source)}
                          </span>
                          <p className="text-sm font-medium text-ink flex-1">
                            {source.recipes?.title}
                          </p>
                        </div>
                      </button>
                    ))
                  ) : (
                    <div className="px-3 py-4 text-center text-xs text-ink-muted">
                      No cooked meals with recipes this week to use as leftover source.
                      Assign recipes to cook slots first!
                    </div>
                  )}
                </div>
              )}
            </div>
          )}

          {/* Participants */}
          <div>
            <label className="text-xs font-semibold text-ink-muted uppercase tracking-wide mb-2 block">
              Who&apos;s eating?
            </label>
            <div className="space-y-2">
              {participants.map((p) => (
                <label
                  key={p.id}
                  className="flex items-center justify-between px-3 py-2 rounded-lg bg-cream/50 cursor-pointer hover:bg-cream transition-colors"
                >
                  <span className="text-sm text-ink">
                    {p.household_members.name}
                  </span>
                  <input
                    type="checkbox"
                    checked={p.is_participating}
                    onChange={(e) =>
                      handleParticipantToggle(p.id, e.target.checked)
                    }
                    className="w-5 h-5 rounded border-ink-light/30 text-primary
                      focus:ring-2 focus:ring-primary/50 cursor-pointer"
                  />
                </label>
              ))}
              {participants.length === 0 && (
                <p className="text-xs text-ink-muted text-center py-2">
                  No household members found
                </p>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

// ============================================================
// Tab 1: Single Recipe Picker (extracted from original modal)
// ============================================================

function SingleRecipeTab({
  currentRecipe,
  currentRecipeConflicts,
  filteredRecipes,
  searchQuery,
  onSearchChange,
  preferenceScores,
  saving,
  slotMealType,
  onRecipeSelect,
  onRemoveRecipe,
  getRecipeConflicts,
}: {
  currentRecipe: Recipe | null;
  currentRecipeConflicts: DietaryConflict[];
  filteredRecipes: Recipe[];
  searchQuery: string;
  onSearchChange: (q: string) => void;
  preferenceScores: Map<string, RecipePreferenceScore>;
  saving: boolean;
  slotMealType: string;
  onRecipeSelect: (recipeId: string) => void;
  onRemoveRecipe: () => void;
  getRecipeConflicts: (recipeId: string) => DietaryConflict[];
}) {
  if (currentRecipe) {
    return (
      <div className="space-y-2">
        <div className="p-3 rounded-lg bg-secondary/5 border border-secondary/20">
          <div className="flex items-start justify-between">
            <div>
              <p className="text-sm font-medium text-ink">
                {currentRecipe.title}
              </p>
              <div className="flex items-center gap-2 mt-1">
                {currentRecipe.cuisine && (
                  <span className="text-xs text-ink-muted">
                    {currentRecipe.cuisine}
                  </span>
                )}
                {currentRecipe.total_time_min && (
                  <span className="text-xs text-ink-muted">
                    {currentRecipe.total_time_min}m
                  </span>
                )}
                {currentRecipe.is_vegetarian && (
                  <span className="text-xs">🟢 Veg</span>
                )}
              </div>
            </div>
            <button
              onClick={onRemoveRecipe}
              disabled={saving}
              className="text-xs text-red-500 hover:text-red-700 font-medium disabled:opacity-50"
            >
              Remove
            </button>
          </div>
        </div>

        {currentRecipeConflicts.length > 0 && (
          <div className="p-2.5 rounded-lg bg-red-50 border border-red-200">
            <p className="text-xs font-semibold text-red-700 mb-1">
              🚨 Dietary Conflicts
            </p>
            {currentRecipeConflicts.map((conflict, i) => (
              <p key={i} className="text-xs text-red-600">
                {getPrefTypeEmoji(conflict.prefType)}{" "}
                <span className="font-medium">{conflict.ingredientName}</span>
                {" — "}
                {conflict.memberName} ({conflict.prefType === "allergy" ? "allergy" : conflict.prefType === "hard_no" ? "cannot eat" : "dislikes"})
              </p>
            ))}
          </div>
        )}
      </div>
    );
  }

  return (
    <div>
      <input
        type="text"
        value={searchQuery}
        onChange={(e) => onSearchChange(e.target.value)}
        placeholder="Search recipes..."
        className="w-full px-3 py-2 rounded-lg border border-ink-light/30 bg-surface
          text-sm focus:ring-2 focus:ring-primary/50 focus:border-transparent"
      />

      <div className="mt-2 max-h-48 overflow-y-auto rounded-lg border border-ink-light/10">
        {filteredRecipes.length > 0 ? (
          filteredRecipes.map((recipe) => {
            const conflicts = getRecipeConflicts(recipe.id);
            const hasConflict = conflicts.length > 0;
            const hasAllergy = conflicts.some((c) => c.prefType === "allergy");
            const score = preferenceScores.get(recipe.id);

            return (
              <button
                key={recipe.id}
                onClick={() => onRecipeSelect(recipe.id)}
                disabled={saving}
                className={`w-full text-left px-3 py-2 hover:bg-cream transition-colors
                  border-b border-ink-light/5 last:border-b-0 disabled:opacity-50
                  ${hasAllergy ? "bg-red-50/50" : ""}`}
              >
                <div className="flex items-center gap-2">
                  {score?.isRecommended && (
                    <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-accent/20 text-accent-dark font-semibold shrink-0">
                      ⭐
                    </span>
                  )}
                  <p className="text-sm font-medium text-ink flex-1">
                    {recipe.title}
                  </p>
                  {hasConflict && (
                    <span
                      className="text-[10px] px-1.5 py-0.5 rounded-full bg-red-100 text-red-600 font-semibold shrink-0"
                      title={conflicts.map((c) => `${c.memberName}: ${c.prefType} - ${c.ingredientName}`).join(", ")}
                    >
                      {hasAllergy ? "🚨" : "⚠️"} {conflicts.length}
                    </span>
                  )}
                  {recipe.status === "draft" && (
                    <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-draft/10 text-draft font-semibold">
                      Draft
                    </span>
                  )}
                </div>
                <div className="flex items-center gap-2 mt-0.5">
                  {recipe.cuisine && (
                    <span className="text-xs text-ink-muted">
                      {recipe.cuisine}
                    </span>
                  )}
                  {recipe.is_vegetarian && (
                    <span className="text-[10px]">🟢</span>
                  )}
                  {recipe.meal_types?.includes(slotMealType) && (
                    <span className="text-[10px] text-secondary font-medium">
                      {MEAL_LABELS[slotMealType] ?? slotMealType}
                    </span>
                  )}
                </div>
              </button>
            );
          })
        ) : (
          <div className="px-3 py-4 text-center text-xs text-ink-muted">
            {filteredRecipes.length === 0 && searchQuery
              ? "No recipes match your search"
              : "No recipes yet. Add recipes first!"}
          </div>
        )}
      </div>
    </div>
  );
}

// ============================================================
// Tab 2: Build a Meal (multi-dish builder)
// ============================================================

function BuildMealTab({
  buildDishes,
  recipes,
  preferenceScores,
  saving,
  buildDishCount,
  buildHasChanges,
  dietaryConflictMap,
  participatingMemberIds,
  onUpdateRecipe,
  onUpdatePortion,
  onUpdateSearch,
  onClearDish,
  onSave,
}: {
  buildDishes: Record<DishRole, { recipeId: string | null; portionFactor: number; searchQuery: string }>;
  recipes: Recipe[];
  preferenceScores: Map<string, RecipePreferenceScore>;
  saving: boolean;
  buildDishCount: number;
  buildHasChanges: boolean;
  dietaryConflictMap: DietaryConflictMap;
  participatingMemberIds: Set<string>;
  onUpdateRecipe: (role: DishRole, recipeId: string | null) => void;
  onUpdatePortion: (role: DishRole, portion: number) => void;
  onUpdateSearch: (role: DishRole, query: string) => void;
  onClearDish: (role: DishRole) => void;
  onSave: () => void;
}) {
  return (
    <div className="space-y-3">
      <p className="text-xs text-ink-muted">
        Build a complete meal by adding dishes for each role. Only Main is required.
      </p>

      {DISH_ROLES.map((dr) => {
        const state = buildDishes[dr.role];
        const selectedRecipe = state.recipeId
          ? recipes.find((r) => r.id === state.recipeId) ?? null
          : null;

        // Conflicts for this dish
        const conflicts = state.recipeId
          ? getConflictsForRecipe(state.recipeId, dietaryConflictMap, participatingMemberIds)
          : [];

        return (
          <div
            key={dr.role}
            className="rounded-lg border border-ink-light/10 overflow-hidden"
          >
            {/* Role header */}
            <div className={`px-3 py-2 flex items-center gap-2 ${getDishRoleColor(dr.role)} bg-opacity-20`}>
              <span className="text-sm">{dr.emoji}</span>
              <span className="text-xs font-semibold flex-1">
                {getDishRoleLabel(dr.role)}
                {dr.required && <span className="text-red-400 ml-0.5">*</span>}
              </span>
              {selectedRecipe && (
                <button
                  onClick={() => onClearDish(dr.role)}
                  className="text-[10px] text-red-500 hover:text-red-700 font-medium"
                >
                  Clear
                </button>
              )}
            </div>

            {/* Selected recipe or picker */}
            <div className="px-3 py-2">
              {selectedRecipe ? (
                <div>
                  <div className="flex items-center gap-2">
                    <p className="text-sm font-medium text-ink flex-1 line-clamp-1">
                      {selectedRecipe.title}
                    </p>
                    {selectedRecipe.is_vegetarian && (
                      <span className="text-[10px]">🟢</span>
                    )}
                  </div>

                  {/* Portion factor selector */}
                  <div className="flex items-center gap-1 mt-1.5">
                    <span className="text-[10px] text-ink-muted mr-1">Portion:</span>
                    {PORTION_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => onUpdatePortion(dr.role, opt.value)}
                        className={`px-1.5 py-0.5 rounded text-[10px] font-medium transition-colors
                          ${
                            state.portionFactor === opt.value
                              ? "bg-primary text-white"
                              : "bg-cream text-ink-muted hover:bg-ink-light/10"
                          }`}
                      >
                        {opt.label}
                      </button>
                    ))}
                  </div>

                  {/* Dietary conflicts */}
                  {conflicts.length > 0 && (
                    <div className="mt-1.5 px-2 py-1 rounded bg-red-50 border border-red-200">
                      {conflicts.slice(0, 2).map((c, i) => (
                        <p key={i} className="text-[10px] text-red-600">
                          {getPrefTypeEmoji(c.prefType)} {c.ingredientName} — {c.memberName}
                        </p>
                      ))}
                      {conflicts.length > 2 && (
                        <p className="text-[10px] text-red-500">+{conflicts.length - 2} more</p>
                      )}
                    </div>
                  )}
                </div>
              ) : (
                <DishRecipePicker
                  searchQuery={state.searchQuery}
                  onSearchChange={(q) => onUpdateSearch(dr.role, q)}
                  recipes={recipes}
                  preferenceScores={preferenceScores}
                  onSelect={(recipeId) => onUpdateRecipe(dr.role, recipeId)}
                  saving={saving}
                />
              )}
            </div>
          </div>
        );
      })}

      {/* Save button */}
      <button
        onClick={onSave}
        disabled={saving || buildDishCount === 0 || !buildHasChanges}
        className="w-full py-2.5 rounded-lg bg-primary text-white text-sm font-semibold
          hover:bg-primary-dark transition-colors disabled:opacity-50 disabled:cursor-not-allowed
          flex items-center justify-center gap-1.5"
      >
        {saving ? (
          <>
            <svg className="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z" />
            </svg>
            Saving...
          </>
        ) : (
          <>Save Meal ({buildDishCount} {buildDishCount === 1 ? "dish" : "dishes"})</>
        )}
      </button>
    </div>
  );
}

// Mini recipe picker for Build-a-Meal dish slots
function DishRecipePicker({
  searchQuery,
  onSearchChange,
  recipes,
  preferenceScores,
  onSelect,
  saving,
}: {
  searchQuery: string;
  onSearchChange: (q: string) => void;
  recipes: Recipe[];
  preferenceScores: Map<string, RecipePreferenceScore>;
  onSelect: (recipeId: string) => void;
  saving: boolean;
}) {
  const sorted = useMemo(
    () => sortRecipesByPreference(recipes, preferenceScores),
    [recipes, preferenceScores]
  );
  const filtered = sorted.filter((r) =>
    r.title.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div>
      <input
        type="text"
        value={searchQuery}
        onChange={(e) => onSearchChange(e.target.value)}
        placeholder="Search recipes..."
        className="w-full px-2 py-1.5 rounded-md border border-ink-light/20 bg-surface
          text-xs focus:ring-1 focus:ring-primary/40 focus:border-transparent"
      />
      {searchQuery && (
        <div className="mt-1 max-h-32 overflow-y-auto rounded-md border border-ink-light/10">
          {filtered.length > 0 ? (
            filtered.slice(0, 8).map((recipe) => {
              const score = preferenceScores.get(recipe.id);
              return (
                <button
                  key={recipe.id}
                  onClick={() => onSelect(recipe.id)}
                  disabled={saving}
                  className="w-full text-left px-2 py-1.5 hover:bg-cream transition-colors
                    border-b border-ink-light/5 last:border-b-0 disabled:opacity-50"
                >
                  <div className="flex items-center gap-1">
                    {score?.isRecommended && (
                      <span className="text-[9px]">⭐</span>
                    )}
                    <span className="text-xs text-ink line-clamp-1">{recipe.title}</span>
                    {recipe.is_vegetarian && (
                      <span className="text-[9px] shrink-0">🟢</span>
                    )}
                  </div>
                </button>
              );
            })
          ) : (
            <p className="px-2 py-2 text-[10px] text-ink-muted text-center">
              No matches
            </p>
          )}
        </div>
      )}
    </div>
  );
}
