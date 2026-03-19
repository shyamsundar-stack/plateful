# Plateful — Database Schema Reference

## Design Principles
- All tables use UUID primary keys
- All tables have created_at and updated_at timestamps
- Multi-tenant: household_id on every user-facing table
- Soft delete: is_archived flag instead of DELETE
- Nutrition stored per 100g for unit conversion flexibility
- ENUMs use TEXT columns + CHECK constraints (not CREATE TYPE — easier to evolve)
- Foreign keys use ON DELETE RESTRICT by default (prevent accidental cascade)

---

## Phase 1 Tables

### households
Top-level tenant container.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| name | TEXT NOT NULL | e.g. "Shyam's Family" |
| created_by | UUID FK → auth.users | ON DELETE SET NULL |
| is_archived | BOOLEAN | Soft delete |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

### household_members
People in the household. Not all are app users — kids, elderly, etc.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| household_id | UUID FK → households | ON DELETE RESTRICT |
| name | TEXT NOT NULL | Display name |
| age | INT | For nutrition calc |
| height_cm | DECIMAL | Optional |
| weight_kg | DECIMAL | Optional |
| activity_level | TEXT + CHECK | sedentary, light, moderate, active, very_active |
| goal | TEXT + CHECK | maintain, lose_weight, gain_muscle, general_health |
| dietary_notes | TEXT | Free-text dietary info (structured prefs in Phase 2) |
| is_app_user | BOOLEAN | Can they log in? |
| auth_user_id | UUID FK → auth.users | NULL if not an app user. ON DELETE SET NULL |
| is_archived | BOOLEAN | Soft delete |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

### global_ingredients
Pre-seeded template ingredient catalog. Not per-household.
Copied to household `ingredients` table on signup via `copy_global_ingredients()` RPC.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| name | TEXT NOT NULL | Primary name: "onion" |
| aliases | TEXT[] | Array: ["pyaz", "vengayam", "ulli"] |
| category | TEXT + CHECK | vegetable, fruit, grain, protein, dairy, spice, oil, condiment, nut, legume, other |
| default_unit | TEXT NOT NULL | "g", "ml", "piece", etc. |
| calories_per_100g | DECIMAL | |
| protein_per_100g | DECIMAL | |
| carbs_per_100g | DECIMAL | |
| fat_per_100g | DECIMAL | |
| fiber_per_100g | DECIMAL | |
| created_at | TIMESTAMPTZ | |

### ingredients
Per-household ingredient library. Seeded from global_ingredients on household creation.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| household_id | UUID FK → households | ON DELETE RESTRICT |
| name | TEXT NOT NULL | Primary name: "onion" |
| aliases | TEXT[] | Array: ["pyaz", "vengayam", "ulli"] |
| category | TEXT + CHECK | vegetable, fruit, grain, protein, dairy, spice, oil, condiment, nut, legume, other |
| default_unit | TEXT NOT NULL | "g", "ml", "piece", etc. |
| calories_per_100g | DECIMAL | |
| protein_per_100g | DECIMAL | |
| carbs_per_100g | DECIMAL | |
| fat_per_100g | DECIMAL | |
| fiber_per_100g | DECIMAL | |
| is_archived | BOOLEAN | Soft delete |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

### recipes
The recipe library. Source can be manual, pasted text, or URL import.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| household_id | UUID FK → households | ON DELETE RESTRICT |
| title | TEXT NOT NULL | |
| description | TEXT | Short summary |
| cuisine | TEXT | Indian, Chinese, Italian, etc. |
| meal_types | TEXT[] | Array: ["lunch", "dinner"] |
| servings | INT NOT NULL | Base serving count (CHECK > 0) |
| prep_time_min | INT | |
| cook_time_min | INT | |
| total_time_min | INT | GENERATED ALWAYS AS (prep + cook) STORED |
| difficulty | TEXT + CHECK | easy, medium, hard |
| tags | TEXT[] | ["high-protein", "batch-friendly", "quick", "comfort"] |
| source_type | TEXT + CHECK | manual, paste_import, url_import |
| source_url | TEXT | NULL for manual entry |
| source_text | TEXT | Original pasted text (for reference) |
| image_url | TEXT | OCI storage URL |
| status | TEXT + CHECK | draft, active, archived |
| is_vegetarian | BOOLEAN | |
| is_vegan | BOOLEAN | |
| is_batch_friendly | BOOLEAN | Good for weekend batch prep? |
| leftover_days | INT | How many days leftovers last (0 = not suitable) |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

### recipe_ingredients
Junction: which ingredients in which quantities for a recipe.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| recipe_id | UUID FK → recipes | ON DELETE CASCADE |
| ingredient_id | UUID FK → ingredients | ON DELETE RESTRICT |
| quantity | DECIMAL NOT NULL | Amount for base servings |
| unit | TEXT NOT NULL | "g", "ml", "tsp", "cup", "piece", etc. |
| preparation | TEXT | "chopped", "minced", "boiled", etc. |
| is_optional | BOOLEAN | |
| group_name | TEXT | "For the gravy", "For the tempering", etc. |
| sort_order | INT | Display order |
| created_at | TIMESTAMPTZ | |

### recipe_steps
Ordered cooking instructions.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| recipe_id | UUID FK → recipes | ON DELETE CASCADE |
| step_number | INT | UNIQUE per recipe (recipe_id, step_number) |
| instruction | TEXT NOT NULL | |
| duration_min | INT | Optional, for timers |
| created_at | TIMESTAMPTZ | |

---

## Indexes

| Index | Table | Columns | Type | Purpose |
|-------|-------|---------|------|---------|
| idx_household_members_household | household_members | household_id | B-tree | List members by household |
| idx_ingredients_household | ingredients | household_id | B-tree | List ingredients by household |
| idx_recipes_household | recipes | household_id | B-tree | List recipes by household |
| idx_recipes_household_status | recipes | household_id, status | B-tree | Recipe list page filter |
| idx_ingredients_household_name | ingredients | household_id, lower(name) | B-tree | Ingredient name search |
| idx_ingredients_aliases | ingredients | aliases | GIN | Alias array search |
| idx_recipe_ingredients_recipe | recipe_ingredients | recipe_id | B-tree | Recipe detail page |
| idx_recipe_steps_recipe | recipe_steps | recipe_id | B-tree | Recipe detail page |
| idx_global_ingredients_name | global_ingredients | lower(name) | B-tree | Seed matching |
| idx_global_ingredients_aliases | global_ingredients | aliases | GIN | Seed matching |
| idx_week_plans_household | week_plans | household_id | B-tree | List plans by household |
| idx_week_plans_household_date | week_plans | household_id, start_date DESC | B-tree | Find current/recent plans |
| idx_meal_slots_week_plan | meal_slots | week_plan_id | B-tree | All slots for a plan |
| idx_meal_slots_recipe | meal_slots | recipe_id (partial) | B-tree | "Which plans use this recipe?" |
| idx_meal_slots_leftover_source | meal_slots | leftover_source_id (partial) | B-tree | Leftover chain lookup |
| idx_meal_slot_participants_slot | meal_slot_participants | meal_slot_id | B-tree | Participants for a slot |
| idx_meal_slot_participants_member | meal_slot_participants | member_id | B-tree | Slots for a member (nutrition) |
| idx_dietary_prefs_member | member_dietary_prefs | member_id | B-tree | Prefs for a member |
| idx_dietary_prefs_ingredient | member_dietary_prefs | ingredient_id (partial) | B-tree | "Who can't eat this?" |
| idx_participation_defaults_member | member_participation_defaults | member_id | B-tree | Defaults for a member |

---

## Foreign Key Strategy

| FK | ON DELETE | Reason |
|----|-----------|--------|
| households.created_by → auth.users | SET NULL | Household survives if user deletes account |
| household_members.household_id → households | RESTRICT | Can't delete household with members |
| household_members.auth_user_id → auth.users | SET NULL | Member record survives account deletion |
| ingredients.household_id → households | RESTRICT | Can't delete household with ingredients |
| recipes.household_id → households | RESTRICT | Can't delete household with recipes |
| recipe_ingredients.recipe_id → recipes | CASCADE | Deleting recipe removes its ingredients |
| recipe_ingredients.ingredient_id → ingredients | RESTRICT | Can't delete ingredient used in recipe |
| recipe_steps.recipe_id → recipes | CASCADE | Deleting recipe removes its steps |
| week_plans.household_id → households | RESTRICT | Can't delete household with plans |
| meal_slots.week_plan_id → week_plans | CASCADE | Deleting plan removes all its slots |
| meal_slots.recipe_id → recipes | SET NULL | Slot survives recipe archival |
| meal_slots.leftover_source_id → meal_slots | SET NULL | Source deletion doesn't cascade |
| meal_slot_participants.meal_slot_id → meal_slots | CASCADE | Slot deletion removes participants |
| meal_slot_participants.member_id → household_members | CASCADE | Member deletion removes participation |
| member_dietary_prefs.member_id → household_members | CASCADE | Member deletion removes prefs |
| member_dietary_prefs.ingredient_id → ingredients | CASCADE | Ingredient deletion removes pref |
| member_participation_defaults.member_id → household_members | CASCADE | Member deletion removes defaults |

---

## Helper Functions

### get_my_household_id() → UUID
Returns the household_id for the currently authenticated user.
Used by ALL RLS policies as the single source of truth for tenant isolation.
Returns NULL if user has no household (denies all access).
`SECURITY DEFINER` — bypasses RLS on household_members to avoid circular dependency.

### handle_new_user() → TRIGGER
Fires AFTER INSERT on auth.users. Auto-creates the full onboarding chain:
1. Creates household (name = "[email prefix]'s Kitchen")
2. Creates household_member (is_app_user = true, linked to auth user)
3. Calls copy_global_ingredients() to seed ~250 ingredients
`SECURITY DEFINER` — bypasses RLS because user has no household at trigger time.

### copy_global_ingredients(target_household_id UUID) → INT
Copies all global_ingredients into a household's ingredient library.
Call this when creating a new household.
Returns the number of ingredients copied.

### populate_meal_slot_participants(meal_slot_id UUID) → INT
Auto-populates participants for a single meal slot from member_participation_defaults.
Priority cascade: day-specific default > meal-type default > true (participates).
`SECURITY DEFINER` — bypasses RLS to access cross-table data.

### create_week_plan_slots(week_plan_id UUID) → INT
Creates 28 meal_slots (7 days × 4 meal types) and auto-populates participants for each.
Call after inserting a week_plan row.
Returns the total number of participant rows created.
`SECURITY DEFINER` — bypasses RLS.

---

## CHECK Constraint Values

### activity_level
sedentary, light, moderate, active, very_active

### goal
maintain, lose_weight, gain_muscle, general_health

### ingredient_category
vegetable, fruit, grain, protein, dairy, spice, oil, condiment, nut, legume, other

### recipe_source_type
manual, paste_import, url_import

### recipe_status
draft, active, archived

### difficulty
easy, medium, hard

### week_plan_status
draft, finalized, archived

### meal_type
breakfast, lunch, dinner, snack

### meal_mode
cook, eat_outside, leftover, skip

### pref_type (dietary)
allergy, hard_no, dislike, prefer

---

## Row Level Security (RLS)

RLS is enabled on ALL 12 tables. Every policy uses `get_my_household_id()` for tenant isolation.

### Policy Summary (39 policies total: 20 Phase 1 + 19 Phase 2)

| Table | SELECT | INSERT | UPDATE | DELETE | Notes |
|-------|--------|--------|--------|--------|-------|
| households | ✅ Own | ❌ (trigger) | ✅ Own | ❌ | Soft delete only |
| household_members | ✅ Own | ✅ Own | ✅ Own | ❌ | Soft delete only |
| global_ingredients | ✅ All authenticated | ❌ | ❌ | ❌ | Read-only shared catalog |
| ingredients | ✅ Own | ✅ Own | ✅ Own | ❌ | Soft delete only |
| recipes | ✅ Own | ✅ Own | ✅ Own | ❌ | Soft delete only |
| recipe_ingredients | ✅ Via recipe | ✅ Via recipe | ✅ Via recipe | ✅ Via recipe | Checks recipe's household_id |
| recipe_steps | ✅ Via recipe | ✅ Via recipe | ✅ Via recipe | ✅ Via recipe | Checks recipe's household_id |
| week_plans | ✅ Own | ✅ Own | ✅ Own | ❌ | Soft delete (is_archived) |
| meal_slots | ✅ Via week_plan | ✅ Via week_plan | ✅ Via week_plan | ✅ Via week_plan | Checks week_plan's household_id |
| meal_slot_participants | ✅ Via slot→plan | ✅ Via slot→plan | ✅ Via slot→plan | ✅ Via slot→plan | 3-table chain |
| member_dietary_prefs | ✅ Via member | ✅ Via member | ✅ Via member | ✅ Via member | Checks member's household_id |
| member_participation_defaults | ✅ Via member | ✅ Via member | ✅ Via member | ✅ Via member | Checks member's household_id |

### Edge Cases
- **No household yet**: `get_my_household_id()` returns NULL → all policies return zero rows → safe denial
- **Cross-household access**: RLS silently returns empty results (no error, no data leak)
- **n8n service role**: Bypasses RLS entirely (trusted server-side — must include household_id in writes)
- **Auth account deleted**: `ON DELETE SET NULL` on FKs → household and data survive

### Auth Trigger
`on_auth_user_created` → fires `handle_new_user()` on every signup → creates household + member + seeds ingredients.

---

## Phase 2 Tables

### week_plans
Container for a household's weekly meal plan. One plan per week per household.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| household_id | UUID FK → households | ON DELETE RESTRICT |
| start_date | DATE NOT NULL | Must be a Monday (ISODOW = 1) |
| status | TEXT + CHECK | draft, finalized, archived |
| notes | TEXT | Free-text notes for the week |
| is_archived | BOOLEAN | Soft delete |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

**Constraints:** UNIQUE (household_id, start_date) — one plan per week per household.

### meal_slots
One slot per day × meal type within a week plan. 7 days × 4 types = 28 slots per week.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| week_plan_id | UUID FK → week_plans | ON DELETE CASCADE |
| slot_date | DATE NOT NULL | Actual date within the week |
| meal_type | TEXT + CHECK | breakfast, lunch, dinner, snack |
| meal_mode | TEXT + CHECK | cook, eat_outside, leftover, skip |
| recipe_id | UUID FK → recipes | ON DELETE SET NULL. NULL = not yet assigned |
| leftover_source_id | UUID FK → meal_slots (self) | ON DELETE SET NULL. Links to earlier cooked meal |
| servings_override | INT | Override recipe's default servings (CHECK > 0) |
| is_locked | BOOLEAN | If true, copy to next week automatically |
| notes | TEXT | |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

**Constraints:**
- UNIQUE (week_plan_id, slot_date, meal_type) — one slot per day per meal type
- CHECK: eat_outside/skip = no recipe, no leftover_source
- CHECK: leftover = no direct recipe (inherits from source)
- CHECK: cook = no leftover_source

### meal_slot_participants
Per-member participation for each meal slot. Drives grocery quantity scaling.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| meal_slot_id | UUID FK → meal_slots | ON DELETE CASCADE |
| member_id | UUID FK → household_members | ON DELETE CASCADE |
| is_participating | BOOLEAN | Does this person eat this meal? |
| serving_factor | DECIMAL | 1.0 = standard, 0.5 = half, 1.5 = extra (CHECK > 0) |
| created_at | TIMESTAMPTZ | |

**Constraints:** UNIQUE (meal_slot_id, member_id) — one row per member per slot.

### member_dietary_prefs
Structured dietary restrictions per household member. Replaces free-text dietary_notes.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| member_id | UUID FK → household_members | ON DELETE CASCADE |
| pref_type | TEXT + CHECK | allergy, hard_no, dislike, prefer |
| ingredient_id | UUID FK → ingredients | ON DELETE CASCADE. Link to household ingredient |
| ingredient_name | TEXT | Free-text fallback (e.g., "shellfish" as category) |
| notes | TEXT | Context (e.g., "mild — OK in small amounts") |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

**Constraints:** CHECK: at least one of ingredient_id or ingredient_name must be non-NULL.

### member_participation_defaults
Default meal participation patterns. Auto-populates meal_slot_participants for new weeks.
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | |
| member_id | UUID FK → household_members | ON DELETE CASCADE |
| meal_type | TEXT + CHECK | breakfast, lunch, dinner, snack |
| day_of_week | INT | ISO: 1=Mon, 7=Sun. NULL = every day |
| is_participating | BOOLEAN | Default participation |
| serving_factor | DECIMAL | Default serving multiplier (CHECK > 0) |
| created_at | TIMESTAMPTZ | |
| updated_at | TIMESTAMPTZ | |

**Constraints:** UNIQUE NULLS NOT DISTINCT (member_id, meal_type, day_of_week)

## Phase 3 Tables (NOT YET — reference only)
- prep_components
- recipe_prep_components (junction)
- prep_blocks
- grocery_lists
- grocery_items

---

## SQL Migration Files

| File | Purpose |
|------|---------|
| sql/001-foundation-schema.sql | DDL: tables, constraints, indexes, triggers |
| sql/002-seed-global-ingredients.sql | ~250 Indian/Asian ingredients with nutrition data |
| sql/003-seed-helper-function.sql | RPC: copy_global_ingredients() |
| sql/004-auth-rls-setup.sql | Auth trigger, RLS policies, get_my_household_id() |
| sql/005-test-auth-rls.sql | Verification queries for auth + RLS setup |
| sql/007-phase2-meal-slots.sql | Phase 2: week_plans, meal_slots, participants, dietary prefs, defaults |
