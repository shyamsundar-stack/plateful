// TypeScript types matching Plateful's Supabase schema
// Keep in sync with sql/001-foundation-schema.sql

export type Recipe = {
  id: string;
  household_id: string;
  title: string;
  description: string | null;
  cuisine: string | null;
  cuisine_category: string | null;
  cooking_style: string[] | null;
  dietary_tags: string[] | null;
  meal_types: string[] | null;
  servings: number;
  prep_time_min: number | null;
  cook_time_min: number | null;
  total_time_min: number | null;
  difficulty: "easy" | "medium" | "hard" | null;
  tags: string[] | null;
  source_type: "manual" | "paste_import" | "url_import" | "library_import";
  source_url: string | null;
  source_text: string | null;
  image_url: string | null;
  status: "draft" | "active" | "archived";
  is_vegetarian: boolean | null;
  is_vegan: boolean | null;
  is_batch_friendly: boolean | null;
  leftover_days: number | null;
  rating: number | null;
  is_favorite: boolean;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

export type Household = {
  id: string;
  name: string;
  created_by: string | null;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

export type HouseholdMember = {
  id: string;
  household_id: string;
  name: string;
  age: number | null;
  height_cm: number | null;
  weight_kg: number | null;
  activity_level: string | null;
  goal: string | null;
  dietary_notes: string | null;
  dietary_mode: "vegetarian" | "non_vegetarian" | "eggetarian" | "vegan";
  biological_sex: "male" | "female" | "other" | null;
  pregnancy_trimester: number; // 0 = not pregnant, 1/2/3 = trimester
  is_app_user: boolean;
  auth_user_id: string | null;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

export type Ingredient = {
  id: string;
  household_id: string;
  name: string;
  aliases: string[] | null;
  category: string | null;
  default_unit: string | null;
  calories_per_100g: number | null;
  protein_per_100g: number | null;
  carbs_per_100g: number | null;
  fat_per_100g: number | null;
  fiber_per_100g: number | null;
  is_pregnancy_unsafe: boolean;
  pregnancy_warning: string | null;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

export type RecipeIngredient = {
  id: string;
  recipe_id: string;
  ingredient_id: string;
  quantity: number | null;
  unit: string | null;
  preparation: string | null;
  is_optional: boolean;
  group_name: string | null;
  sort_order: number;
};

export type RecipeStep = {
  id: string;
  recipe_id: string;
  step_number: number;
  instruction: string;
  duration_min: number | null;
};

// Joined type: recipe_ingredient with ingredient name from the ingredients table
export type RecipeIngredientWithName = RecipeIngredient & {
  ingredients: {
    name: string;
    category: string | null;
  };
};

// =============================================================================
// Phase 2: Weekly Planner types
// =============================================================================

export type WeekPlan = {
  id: string;
  household_id: string;
  start_date: string; // DATE as ISO string "2026-03-16"
  status: "draft" | "finalized" | "archived";
  notes: string | null;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

export type MealSlot = {
  id: string;
  week_plan_id: string;
  slot_date: string; // DATE as ISO string
  meal_type: "breakfast" | "lunch" | "dinner" | "snack";
  meal_mode: "cook" | "eat_outside" | "leftover" | "skip";
  recipe_id: string | null;
  leftover_source_id: string | null;
  servings_override: number | null;
  is_locked: boolean;
  notes: string | null;
  manual_calories: number | null;
  manual_protein_g: number | null;
  manual_carbs_g: number | null;
  manual_fat_g: number | null;
  created_at: string;
  updated_at: string;
};

export type MealSlotParticipant = {
  id: string;
  meal_slot_id: string;
  member_id: string;
  is_participating: boolean;
  serving_factor: number;
  created_at: string;
};

export type MemberDietaryPref = {
  id: string;
  member_id: string;
  pref_type: "allergy" | "hard_no" | "dislike" | "prefer";
  ingredient_id: string | null;
  ingredient_name: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
};

export type MemberParticipationDefault = {
  id: string;
  member_id: string;
  meal_type: "breakfast" | "lunch" | "dinner" | "snack";
  day_of_week: number | null; // ISO: 1=Monday, 7=Sunday, null=all days
  is_participating: boolean;
  serving_factor: number;
  created_at: string;
  updated_at: string;
};

// Joined types for planner UI
export type MealSlotWithRecipe = MealSlot & {
  recipes: {
    title: string;
    cuisine: string | null;
    total_time_min: number | null;
    is_vegetarian: boolean | null;
  } | null;
};

export type MealSlotParticipantWithMember = MealSlotParticipant & {
  household_members: { name: string };
};

// =============================================================================
// Client-side form types
// =============================================================================

// Client-side form types (with temporary IDs for new rows)
export type IngredientRow = {
  _clientId: string;
  ingredient_id: string;
  ingredient_name: string;
  quantity: number | null;
  unit: string;
  preparation: string;
  is_optional: boolean;
  group_name: string;
};

export type StepRow = {
  _clientId: string;
  instruction: string;
  duration_min: number | null;
};

// =============================================================================
// Nutrition Dashboard types (Session 10)
// =============================================================================

export type UnitConversion = {
  unit_name: string;
  grams_per_unit: number;
  notes: string | null;
};

/** Nutrition values for a single recipe (per serving) */
export type RecipeNutrition = {
  recipeId: string;
  caloriesPerServing: number;
  proteinPerServing: number;
  carbsPerServing: number;
  fatPerServing: number;
  confidence: number; // 0.0 – 1.0 (tracked / total ingredients)
  servings: number;
};

/** Nutrition for a single member for a single meal slot */
export type SlotMemberNutrition = {
  memberId: string;
  memberName: string;
  calories: number;
  protein: number;
  carbs: number;
  fat: number;
  isPartial: boolean; // true if eat_outside with no manual entry
};

/** Nutrition summary for one day */
export type DayNutrition = {
  date: string;
  totalCalories: number;
  totalProtein: number;
  totalCarbs: number;
  totalFat: number;
  isPartial: boolean; // any eat_outside slot without manual macros
  perMember: SlotMemberNutrition[];
  pregnancyAlerts: PregnancyAlert[];
};

/** Nutrition for the whole week */
export type WeekNutrition = {
  days: DayNutrition[];
  avgCalories: number;
  avgProtein: number;
  avgCarbs: number;
  avgFat: number;
  imbalancedDayCount: number;
  pregnancyAlertCount: number;
};

/** TDEE + macro targets for one member */
export type MemberTargets = {
  memberId: string;
  memberName: string;
  tdee: number | null; // null if profile incomplete
  proteinTarget: number | null;
  carbsTarget: number | null;
  fatTarget: number | null;
};

/** Imbalance flag for a macro on a given day */
export type ImbalanceFlag = {
  macro: "protein" | "carbs" | "fat";
  actual: number;
  target: number;
  level: "red" | "yellow" | "green";
};

/** Pregnancy safety alert */
export type PregnancyAlert = {
  memberName: string;
  memberId: string;
  trimester: number;
  ingredientName: string;
  warning: string;
  slotId: string;
};

/** Swap suggestion for an imbalanced day */
export type SwapSuggestion = {
  slotId: string;
  currentRecipeTitle: string;
  suggestedRecipeId: string;
  suggestedRecipeTitle: string;
  macroDelta: string; // e.g., "+18g protein"
};

/** Recipe ingredient with full ingredient details (for nutrition calc) */
export type RecipeIngredientWithDetails = RecipeIngredient & {
  ingredients: Ingredient;
};

// =============================================================================
// Phase 3: Prep Components + Grocery (Session 11)
// =============================================================================

export type PrepComponent = {
  id: string;
  household_id: string;
  name: string;
  description: string | null;
  prep_type: "chop" | "cook" | "marinate" | "grind" | "soak" | "other";
  est_time_min: number | null;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

export type PrepComponentStep = {
  id: string;
  prep_component_id: string;
  step_number: number;
  instruction: string;
  created_at: string;
  updated_at: string;
};

export type RecipePrepComponent = {
  id: string;
  recipe_id: string;
  prep_component_id: string;
  notes: string | null;
  created_at: string;
};

export type GroceryList = {
  id: string;
  household_id: string;
  week_plan_id: string;
  share_token: string;
  status: "active" | "completed" | "archived";
  notes: string | null;
  created_at: string;
  updated_at: string;
};

export type GroceryItem = {
  id: string;
  grocery_list_id: string;
  ingredient_id: string | null;
  name: string;
  quantity: number | null;
  unit: string | null;
  category: string;
  is_checked: boolean;
  is_already_have: boolean;
  sort_order: number;
  recipe_sources: string[] | null;
  created_at: string;
  updated_at: string;
};

// ---------------------------------------------------------------------------
// Computed types for grocery + prep engines
// ---------------------------------------------------------------------------

/** Aggregated grocery item (before saving to DB) */
export type AggregatedGroceryItem = {
  ingredientId: string | null;
  name: string;
  totalQuantityGrams: number | null;
  displayQuantity: number | null;
  displayUnit: string | null;
  category: string;
  recipeSources: string[];
};

/** Auto-detected prep suggestion (computed, not stored in DB) */
export type AutoPrepSuggestion = {
  ingredientName: string;
  ingredientId: string;
  prepType: "chop" | "cook" | "marinate" | "grind" | "soak" | "other";
  totalQuantityGrams: number;
  displayQuantity: number;
  displayUnit: string;
  recipeSources: string[]; // recipe titles
  slotDates: string[];     // which days need this ingredient
  estTimeMin: number;
};

/** Manual prep component with its linked recipes */
export type PrepComponentWithRecipes = PrepComponent & {
  recipe_prep_components: Array<{
    recipe_id: string;
    recipes: { title: string };
  }>;
};

/** Prep block = group of prep tasks for a time slot (e.g., "Sunday morning") */
export type PrepBlock = {
  label: string;        // e.g., "Chopping" or "Cooking"
  prepType: string;
  items: AutoPrepSuggestion[];
  manualItems: PrepComponentWithRecipes[];
  totalTimeMin: number;
};

// =============================================================================
// Session 14: Dietary Warnings + Preference Learning
// =============================================================================

/** A conflict between a recipe ingredient and a member's dietary preference */
export type DietaryConflict = {
  memberId: string;
  memberName: string;
  ingredientName: string;
  prefType: "allergy" | "hard_no" | "dislike";
};

/** Map of recipe ID → dietary conflicts for participating members */
export type DietaryConflictMap = Record<string, DietaryConflict[]>;

/** A logged recipe preference (accept/reject/skip) */
export type RecipePreference = {
  id: string;
  household_id: string;
  member_id: string;
  recipe_id: string;
  action: "accept" | "reject" | "skip";
  meal_type: string | null;
  week_start: string | null;
  context_notes: string | null;
  created_at: string;
};

/** Preference score for a recipe (computed, not stored) */
export type RecipePreferenceScore = {
  recipeId: string;
  score: number; // higher = more preferred
  acceptCount: number;
  rejectCount: number;
  isRecommended: boolean; // top 3 for this meal type
};

// ──────────────────────────────────────────
// Analytics (Session 15)
// ──────────────────────────────────────────

/** Append-only analytics event */
export type AnalyticsEvent = {
  id: string;
  household_id: string;
  event_type: string;
  event_data: Record<string, unknown> | null;
  created_at: string;
};

// =============================================================================
// Phase 5: Global Recipe Library + Dietary Identity + Rules Engine
// =============================================================================

/** Global (shared) recipe from the curated library */
export type GlobalRecipe = {
  id: string;
  title: string;
  description: string | null;
  cuisine: string | null;
  cuisine_category: string | null;
  cuisine_region: string | null;
  meal_types: string[] | null;
  servings: number;
  prep_time_min: number | null;
  cook_time_min: number | null;
  total_time_min: number | null;
  difficulty: "easy" | "medium" | "hard";
  tags: string[] | null;
  cooking_style: string[] | null;
  dietary_tags: string[] | null;
  image_url: string | null;
  source_url: string | null;
  image_search_query: string | null;
  is_vegetarian: boolean;
  is_vegan: boolean;
  is_eggetarian: boolean;
  is_jain: boolean;
  is_batch_friendly: boolean;
  leftover_days: number;
  protein_category: string | null;
  import_count: number;
  created_at: string;
};

/** Ingredient for a global recipe */
export type GlobalRecipeIngredient = {
  id: string;
  global_recipe_id: string;
  ingredient_name: string;
  global_ingredient_id: string | null;
  quantity: number;
  unit: string;
  preparation: string | null;
  is_optional: boolean;
  group_name: string | null;
  sort_order: number;
};

/** Cooking step for a global recipe */
export type GlobalRecipeStep = {
  id: string;
  global_recipe_id: string;
  step_number: number;
  instruction: string;
  duration_min: number | null;
};

/** Conditional meal preference rule (IF condition THEN action) */
export type MealRule = {
  id: string;
  household_id: string;
  member_id: string | null; // null = applies to all members
  rule_name: string;
  condition_type: "day_of_week" | "meal_type" | "date_range" | "festival";
  condition_value: string;
  action_type: "set_dietary_mode" | "prefer_cuisine" | "exclude_ingredient" | "include_tag";
  action_value: string;
  is_active: boolean;
  priority: number;
  created_at: string;
  updated_at: string;
};

/** Festival calendar entry (shared, no household_id) */
export type FestivalCalendarEntry = {
  id: string;
  name: string;
  display_name: string;
  tradition: "hindu" | "jain" | "sikh" | "buddhist" | "muslim" | "christian" | "general";
  start_date: string;
  end_date: string;
  dietary_mode: "vegetarian" | "vegan" | null;
  description: string | null;
  year: number;
  created_at: string;
};

// =============================================================================
// Phase 6: Multi-Dish Meals + Thali Templates
// =============================================================================

/** A single dish within a multi-dish meal slot */
export type MealSlotDish = {
  id: string;
  meal_slot_id: string;
  recipe_id: string;
  dish_role: "main" | "staple" | "side" | "accompaniment";
  portion_factor: number;
  sort_order: number;
  created_at: string;
};

/** MealSlotDish joined with recipe data for UI display */
export type MealSlotDishWithRecipe = MealSlotDish & {
  recipes: {
    title: string;
    cuisine: string | null;
    total_time_min: number | null;
    is_vegetarian: boolean | null;
  };
};

/** Pre-built meal combination template */
export type ThaliTemplate = {
  id: string;
  household_id: string | null; // NULL = global/seeded template
  name: string;
  description: string | null;
  cuisine: string | null;
  meal_types: string[];
  is_vegetarian: boolean;
  is_archived: boolean;
  created_at: string;
  updated_at: string;
};

/** A dish slot within a thali template */
export type ThaliTemplateDish = {
  id: string;
  template_id: string;
  dish_role: "main" | "staple" | "side" | "accompaniment";
  dish_label: string;
  recipe_filter: Record<string, unknown>;
  sort_order: number;
};

/** ThaliTemplate joined with its dishes for display */
export type ThaliTemplateWithDishes = ThaliTemplate & {
  thali_template_dishes: ThaliTemplateDish[];
};

/** Extended MealSlotWithRecipe that includes multi-dish data */
export type MealSlotWithDishes = MealSlotWithRecipe & {
  meal_slot_dishes: MealSlotDishWithRecipe[];
};
