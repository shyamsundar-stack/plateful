-- =============================================================================
-- Plateful — Phase 6: Multi-Dish Meals + Thali Templates
-- =============================================================================
-- Run this in Supabase SQL Editor (single execution, top to bottom).
-- Creates 3 new tables, migration RPC, seed data, indexes, and RLS policies.
-- Depends on: Phase 2 tables (meal_slots, week_plans, recipes)
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. meal_slot_dishes — junction table: multiple recipes per meal slot
-- ---------------------------------------------------------------------------
-- Each row represents one dish in a multi-dish meal.
-- dish_role categorizes the dish's function in the meal.
-- portion_factor allows scaling (e.g., 0.5x for small side, 1.5x for big eater).

CREATE TABLE IF NOT EXISTS meal_slot_dishes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  meal_slot_id  UUID NOT NULL REFERENCES meal_slots(id) ON DELETE CASCADE,
  recipe_id     UUID NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  dish_role     TEXT NOT NULL DEFAULT 'main',
  portion_factor NUMERIC(3,2) NOT NULL DEFAULT 1.0,
  sort_order    INT NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_dish_role
    CHECK (dish_role IN ('main', 'staple', 'side', 'accompaniment')),
  CONSTRAINT chk_portion_factor_positive
    CHECK (portion_factor > 0 AND portion_factor <= 5.0),
  CONSTRAINT uq_slot_recipe
    UNIQUE (meal_slot_id, recipe_id)
);

COMMENT ON TABLE meal_slot_dishes IS 'Junction table supporting multi-dish meals. Each meal slot can have 1-4 dishes with typed roles.';
COMMENT ON COLUMN meal_slot_dishes.dish_role IS 'main = protein/gravy, staple = carb base (rice/roti), side = vegetable, accompaniment = extras (raita/chutney)';
COMMENT ON COLUMN meal_slot_dishes.portion_factor IS 'Scaling factor for this dish (1.0 = standard, 0.5 = half portion)';

-- Indexes
CREATE INDEX IF NOT EXISTS idx_meal_slot_dishes_slot
  ON meal_slot_dishes(meal_slot_id);
CREATE INDEX IF NOT EXISTS idx_meal_slot_dishes_recipe
  ON meal_slot_dishes(recipe_id);

-- ---------------------------------------------------------------------------
-- 2. thali_templates — pre-built meal combinations
-- ---------------------------------------------------------------------------
-- household_id = NULL means global (seeded) template, accessible to everyone.
-- household_id = UUID means household-specific custom template.

CREATE TABLE IF NOT EXISTS thali_templates (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id    UUID REFERENCES households(id) ON DELETE CASCADE,
  name            TEXT NOT NULL,
  description     TEXT,
  cuisine         TEXT,
  meal_types      TEXT[] DEFAULT '{}',
  is_vegetarian   BOOLEAN NOT NULL DEFAULT false,
  is_archived     BOOLEAN NOT NULL DEFAULT false,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE thali_templates IS 'Pre-built meal combinations. NULL household_id = global/seeded, otherwise household-specific.';

-- Indexes
CREATE INDEX IF NOT EXISTS idx_thali_templates_household
  ON thali_templates(household_id) WHERE household_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_thali_templates_cuisine
  ON thali_templates(cuisine) WHERE cuisine IS NOT NULL;

-- ---------------------------------------------------------------------------
-- 3. thali_template_dishes — dishes within a thali template
-- ---------------------------------------------------------------------------
-- recipe_filter is JSONB that describes what kind of recipe fills this role.
-- Can be a specific recipe: {"recipe_id": "uuid-here"}
-- Or a filter pattern: {"cuisine": "south_indian", "tags": ["sambar"], "is_vegetarian": true}

CREATE TABLE IF NOT EXISTS thali_template_dishes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id   UUID NOT NULL REFERENCES thali_templates(id) ON DELETE CASCADE,
  dish_role     TEXT NOT NULL DEFAULT 'main',
  dish_label    TEXT NOT NULL,
  recipe_filter JSONB NOT NULL DEFAULT '{}',
  sort_order    INT NOT NULL DEFAULT 0,

  CONSTRAINT chk_template_dish_role
    CHECK (dish_role IN ('main', 'staple', 'side', 'accompaniment'))
);

COMMENT ON TABLE thali_template_dishes IS 'Dishes within a thali template. recipe_filter describes what recipe to use (specific or pattern-based).';
COMMENT ON COLUMN thali_template_dishes.dish_label IS 'Human-readable label like "Dal", "Rice", "Poriyal" for display in template preview';
COMMENT ON COLUMN thali_template_dishes.recipe_filter IS 'JSONB: {"recipe_id":"uuid"} for specific recipe, or {"cuisine":"south_indian","tags":["sambar"]} for pattern matching';

-- Indexes
CREATE INDEX IF NOT EXISTS idx_thali_template_dishes_template
  ON thali_template_dishes(template_id);

-- ---------------------------------------------------------------------------
-- 4. RLS Policies
-- ---------------------------------------------------------------------------

-- Enable RLS on all new tables
ALTER TABLE meal_slot_dishes ENABLE ROW LEVEL SECURITY;
ALTER TABLE thali_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE thali_template_dishes ENABLE ROW LEVEL SECURITY;

-- meal_slot_dishes: same household scope as meal_slots (via week_plans)
CREATE POLICY "meal_slot_dishes: household members can read"
  ON meal_slot_dishes FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM meal_slots ms
      JOIN week_plans wp ON wp.id = ms.week_plan_id
      WHERE ms.id = meal_slot_dishes.meal_slot_id
        AND wp.household_id = get_my_household_id()
    )
  );

CREATE POLICY "meal_slot_dishes: household members can insert"
  ON meal_slot_dishes FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM meal_slots ms
      JOIN week_plans wp ON wp.id = ms.week_plan_id
      WHERE ms.id = meal_slot_dishes.meal_slot_id
        AND wp.household_id = get_my_household_id()
    )
  );

CREATE POLICY "meal_slot_dishes: household members can update"
  ON meal_slot_dishes FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM meal_slots ms
      JOIN week_plans wp ON wp.id = ms.week_plan_id
      WHERE ms.id = meal_slot_dishes.meal_slot_id
        AND wp.household_id = get_my_household_id()
    )
  );

CREATE POLICY "meal_slot_dishes: household members can delete"
  ON meal_slot_dishes FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM meal_slots ms
      JOIN week_plans wp ON wp.id = ms.week_plan_id
      WHERE ms.id = meal_slot_dishes.meal_slot_id
        AND wp.household_id = get_my_household_id()
    )
  );

-- thali_templates: global (NULL household_id) readable by all, household-specific CRUD
CREATE POLICY "thali_templates: everyone can read global templates"
  ON thali_templates FOR SELECT
  USING (
    household_id IS NULL
    OR household_id = get_my_household_id()
  );

CREATE POLICY "thali_templates: household members can insert own"
  ON thali_templates FOR INSERT
  WITH CHECK (
    household_id = get_my_household_id()
  );

CREATE POLICY "thali_templates: household members can update own"
  ON thali_templates FOR UPDATE
  USING (
    household_id = get_my_household_id()
  );

CREATE POLICY "thali_templates: household members can delete own"
  ON thali_templates FOR DELETE
  USING (
    household_id = get_my_household_id()
  );

-- thali_template_dishes: access follows parent template
CREATE POLICY "thali_template_dishes: read via template"
  ON thali_template_dishes FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM thali_templates t
      WHERE t.id = thali_template_dishes.template_id
        AND (t.household_id IS NULL OR t.household_id = get_my_household_id())
    )
  );

CREATE POLICY "thali_template_dishes: insert via own template"
  ON thali_template_dishes FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM thali_templates t
      WHERE t.id = thali_template_dishes.template_id
        AND t.household_id = get_my_household_id()
    )
  );

CREATE POLICY "thali_template_dishes: update via own template"
  ON thali_template_dishes FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM thali_templates t
      WHERE t.id = thali_template_dishes.template_id
        AND t.household_id = get_my_household_id()
    )
  );

CREATE POLICY "thali_template_dishes: delete via own template"
  ON thali_template_dishes FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM thali_templates t
      WHERE t.id = thali_template_dishes.template_id
        AND t.household_id = get_my_household_id()
    )
  );

-- ---------------------------------------------------------------------------
-- 5. Migration RPC — backfill existing single-recipe slots into junction table
-- ---------------------------------------------------------------------------
-- Idempotent: only inserts for slots that have recipe_id but no junction rows.

CREATE OR REPLACE FUNCTION migrate_single_to_multi_dish()
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  migrated_count INT;
BEGIN
  INSERT INTO meal_slot_dishes (meal_slot_id, recipe_id, dish_role, sort_order)
  SELECT ms.id, ms.recipe_id, 'main', 0
  FROM meal_slots ms
  WHERE ms.recipe_id IS NOT NULL
    AND NOT EXISTS (
      SELECT 1 FROM meal_slot_dishes msd
      WHERE msd.meal_slot_id = ms.id
    );

  GET DIAGNOSTICS migrated_count = ROW_COUNT;
  RETURN migrated_count;
END;
$$;

COMMENT ON FUNCTION migrate_single_to_multi_dish() IS 'Backfill: copies existing meal_slots.recipe_id into meal_slot_dishes as main dish. Idempotent.';

-- ---------------------------------------------------------------------------
-- 6. Seed global thali templates (~12 templates)
-- ---------------------------------------------------------------------------
-- These are global templates (household_id = NULL) available to all users.

DO $$
DECLARE
  t_id UUID;
BEGIN
  -- 1. North Indian Lunch
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'North Indian Lunch', 'Classic North Indian thali with dal, roti, sabzi, and raita', 'north_indian', '{lunch}', false)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Dal / Curry', '{"tags": ["dal", "curry"], "cuisine": "north_indian"}', 0),
    (t_id, 'staple', 'Roti / Chapati', '{"tags": ["roti", "chapati", "bread"], "cuisine": "north_indian"}', 1),
    (t_id, 'side', 'Sabzi', '{"tags": ["sabzi", "vegetable"], "cuisine": "north_indian"}', 2),
    (t_id, 'accompaniment', 'Raita / Salad', '{"tags": ["raita", "salad", "accompaniment"]}', 3);

  -- 2. North Indian Dinner
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'North Indian Dinner', 'Hearty dinner with curry, naan, and a side', 'north_indian', '{dinner}', false)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Curry / Gravy', '{"tags": ["curry", "gravy"], "cuisine": "north_indian"}', 0),
    (t_id, 'staple', 'Naan / Paratha', '{"tags": ["naan", "paratha", "bread"], "cuisine": "north_indian"}', 1),
    (t_id, 'side', 'Salad / Raita', '{"tags": ["salad", "raita"]}', 2);

  -- 3. South Indian Lunch
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'South Indian Lunch', 'Traditional South Indian meals with sambar, rice, poriyal, and rasam', 'south_indian', '{lunch}', true)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Sambar / Kootu', '{"tags": ["sambar", "kootu", "dal"], "cuisine": "south_indian"}', 0),
    (t_id, 'staple', 'Rice', '{"tags": ["rice"], "cuisine": "south_indian"}', 1),
    (t_id, 'side', 'Poriyal / Thoran', '{"tags": ["poriyal", "thoran", "vegetable"], "cuisine": "south_indian"}', 2),
    (t_id, 'accompaniment', 'Rasam / Buttermilk', '{"tags": ["rasam", "buttermilk", "accompaniment"]}', 3);

  -- 4. South Indian Breakfast
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'South Indian Breakfast', 'Classic breakfast with idli/dosa, chutney, and sambar', 'south_indian', '{breakfast}', true)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Idli / Dosa / Uttapam', '{"tags": ["idli", "dosa", "uttapam"], "cuisine": "south_indian"}', 0),
    (t_id, 'accompaniment', 'Coconut Chutney', '{"tags": ["chutney"], "cuisine": "south_indian"}', 1),
    (t_id, 'side', 'Sambar', '{"tags": ["sambar"], "cuisine": "south_indian"}', 2);

  -- 5. Punjabi Thali
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Punjabi Thali', 'Rich Punjabi flavours — chole or paneer with paratha and raita', 'punjabi', '{lunch,dinner}', false)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Chole / Paneer', '{"tags": ["chole", "paneer", "curry"], "cuisine": "punjabi"}', 0),
    (t_id, 'staple', 'Paratha / Naan', '{"tags": ["paratha", "naan", "bread"], "cuisine": "punjabi"}', 1),
    (t_id, 'accompaniment', 'Raita', '{"tags": ["raita"]}', 2),
    (t_id, 'side', 'Pickle / Salad', '{"tags": ["pickle", "salad", "accompaniment"]}', 3);

  -- 6. Bengali Lunch
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Bengali Lunch', 'Traditional Bengali meal with fish curry, rice, dal, and bhaja', 'bengali', '{lunch}', false)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Fish Curry / Chicken', '{"tags": ["fish", "curry"], "cuisine": "bengali"}', 0),
    (t_id, 'staple', 'Rice', '{"tags": ["rice"]}', 1),
    (t_id, 'side', 'Dal / Bhaja', '{"tags": ["dal", "bhaja", "vegetable"], "cuisine": "bengali"}', 2);

  -- 7. Gujarati Thali
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Gujarati Thali', 'Sweet-and-savory Gujarati thali with dal, roti, sabzi, and kadhi', 'gujarati', '{lunch,dinner}', true)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Dal / Kadhi', '{"tags": ["dal", "kadhi"], "cuisine": "gujarati"}', 0),
    (t_id, 'staple', 'Roti / Bhakhri', '{"tags": ["roti", "bhakhri", "bread"], "cuisine": "gujarati"}', 1),
    (t_id, 'side', 'Sabzi / Shaak', '{"tags": ["sabzi", "shaak", "vegetable"], "cuisine": "gujarati"}', 2),
    (t_id, 'accompaniment', 'Khichdi / Rice', '{"tags": ["khichdi", "rice"]}', 3);

  -- 8. Simple Weeknight
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Simple Weeknight', 'Quick and easy — one-pot curry with rice', NULL, '{dinner}', false)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'One-Pot Curry', '{"tags": ["curry", "one-pot"]}', 0),
    (t_id, 'staple', 'Rice / Roti', '{"tags": ["rice", "roti", "bread"]}', 1);

  -- 9. Protein-Heavy Meal
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Protein-Heavy Meal', 'High-protein meal with chicken/paneer, grain, and salad', NULL, '{lunch,dinner}', false)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Chicken / Paneer / Eggs', '{"tags": ["chicken", "paneer", "eggs", "protein"]}', 0),
    (t_id, 'staple', 'Quinoa / Brown Rice', '{"tags": ["quinoa", "rice", "grain"]}', 1),
    (t_id, 'side', 'Salad / Greens', '{"tags": ["salad", "greens", "vegetable"]}', 2);

  -- 10. Light Dinner
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Light Dinner', 'Light evening meal with soup, bread, and salad', NULL, '{dinner}', true)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Soup / Stew', '{"tags": ["soup", "stew"]}', 0),
    (t_id, 'staple', 'Bread / Toast', '{"tags": ["bread", "toast"]}', 1),
    (t_id, 'side', 'Salad', '{"tags": ["salad"]}', 2);

  -- 11. Weekend Brunch
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Weekend Brunch', 'Relaxed brunch with paratha, curd, pickle, and chai snacks', 'north_indian', '{breakfast}', true)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Paratha / Poori', '{"tags": ["paratha", "poori", "bread"]}', 0),
    (t_id, 'accompaniment', 'Curd / Lassi', '{"tags": ["curd", "lassi", "yogurt"]}', 1),
    (t_id, 'side', 'Pickle / Chutney', '{"tags": ["pickle", "chutney"]}', 2);

  -- 12. Fasting Meal
  INSERT INTO thali_templates (household_id, name, description, cuisine, meal_types, is_vegetarian)
  VALUES (NULL, 'Fasting Meal', 'Simple fasting-friendly meal for religious observances', NULL, '{lunch,dinner}', true)
  RETURNING id INTO t_id;

  INSERT INTO thali_template_dishes (template_id, dish_role, dish_label, recipe_filter, sort_order) VALUES
    (t_id, 'main', 'Sabudana Khichdi / Kuttu Roti', '{"tags": ["fasting", "sabudana", "kuttu"]}', 0),
    (t_id, 'side', 'Fruit / Potato', '{"tags": ["fruit", "potato", "fasting"]}', 1),
    (t_id, 'accompaniment', 'Curd / Peanuts', '{"tags": ["curd", "peanuts", "fasting"]}', 2);

END $$;

-- ---------------------------------------------------------------------------
-- 7. Updated timestamp trigger for thali_templates
-- ---------------------------------------------------------------------------

-- Helper: generic updated_at trigger function (idempotent)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_thali_templates_updated_at
  BEFORE UPDATE ON thali_templates
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ---------------------------------------------------------------------------
-- 8. Verification queries
-- ---------------------------------------------------------------------------

-- Check tables exist
SELECT 'meal_slot_dishes' AS table_name, count(*) FROM meal_slot_dishes
UNION ALL
SELECT 'thali_templates', count(*) FROM thali_templates
UNION ALL
SELECT 'thali_template_dishes', count(*) FROM thali_template_dishes;

-- Check seed data
SELECT t.name, t.cuisine, t.is_vegetarian, count(td.id) AS dish_count
FROM thali_templates t
LEFT JOIN thali_template_dishes td ON td.template_id = t.id
WHERE t.household_id IS NULL
GROUP BY t.id, t.name, t.cuisine, t.is_vegetarian
ORDER BY t.name;

-- ---------------------------------------------------------------------------
-- ROLLBACK (commented out — run only if needed)
-- ---------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS trg_thali_templates_updated_at ON thali_templates;
-- DROP FUNCTION IF EXISTS migrate_single_to_multi_dish();
-- DROP TABLE IF EXISTS thali_template_dishes CASCADE;
-- DROP TABLE IF EXISTS thali_templates CASCADE;
-- DROP TABLE IF EXISTS meal_slot_dishes CASCADE;
