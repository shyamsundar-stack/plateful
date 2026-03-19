-- =============================================================================
-- Plateful — Phase 5 Migration 014: Global Recipe Library
-- =============================================================================
-- Shared recipe catalog accessible to all authenticated users.
-- No household_id — these are curated recipes, not user-owned.
-- Users can "import" global recipes into their household library.
--
-- Run AFTER 013-dietary-mode-taxonomy.sql
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. global_recipes — the shared recipe catalog
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS global_recipes (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title             TEXT NOT NULL,
  description       TEXT,
  cuisine           TEXT,
  cuisine_category  TEXT,
  cuisine_region    TEXT,
  meal_types        TEXT[] DEFAULT '{}',
  servings          INT NOT NULL DEFAULT 2,
  prep_time_min     INT,
  cook_time_min     INT,
  total_time_min    INT GENERATED ALWAYS AS (
                      COALESCE(prep_time_min, 0) + COALESCE(cook_time_min, 0)
                    ) STORED,
  difficulty        TEXT NOT NULL DEFAULT 'medium',
  tags              TEXT[] DEFAULT '{}',
  cooking_style     TEXT[] DEFAULT '{}',
  dietary_tags      TEXT[] DEFAULT '{}',
  image_url         TEXT,
  source_url        TEXT,
  image_search_query TEXT,
  is_vegetarian     BOOLEAN NOT NULL DEFAULT false,
  is_vegan          BOOLEAN NOT NULL DEFAULT false,
  is_eggetarian     BOOLEAN NOT NULL DEFAULT false,
  is_jain           BOOLEAN NOT NULL DEFAULT false,
  is_batch_friendly BOOLEAN NOT NULL DEFAULT false,
  leftover_days     INT NOT NULL DEFAULT 0,
  protein_category  TEXT,
  import_count      INT NOT NULL DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_gr_difficulty CHECK (difficulty IN ('easy', 'medium', 'hard')),
  CONSTRAINT chk_gr_servings CHECK (servings > 0),
  CONSTRAINT chk_gr_leftover_days CHECK (leftover_days >= 0)
);

COMMENT ON TABLE global_recipes IS 'Shared curated recipe catalog. No household_id — accessible to all authenticated users. Admin-managed via service role.';
COMMENT ON COLUMN global_recipes.import_count IS 'Number of times this recipe has been imported by users. Updated via trigger/action.';
COMMENT ON COLUMN global_recipes.protein_category IS 'Primary protein: chicken, mutton, lamb, fish, prawns, egg, paneer, dal, legume, soya, tofu, or null';

-- ---------------------------------------------------------------------------
-- 2. global_recipe_ingredients — ingredients for global recipes
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS global_recipe_ingredients (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  global_recipe_id    UUID NOT NULL REFERENCES global_recipes(id) ON DELETE CASCADE,
  ingredient_name     TEXT NOT NULL,
  global_ingredient_id UUID REFERENCES global_ingredients(id) ON DELETE SET NULL,
  quantity            DECIMAL NOT NULL,
  unit                TEXT NOT NULL,
  preparation         TEXT,
  is_optional         BOOLEAN NOT NULL DEFAULT false,
  group_name          TEXT,
  sort_order          INT NOT NULL DEFAULT 0
);

COMMENT ON TABLE global_recipe_ingredients IS 'Ingredients for global recipes. ingredient_name is authoritative; global_ingredient_id is optional FK for nutrition lookup.';

-- ---------------------------------------------------------------------------
-- 3. global_recipe_steps — cooking instructions for global recipes
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS global_recipe_steps (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  global_recipe_id  UUID NOT NULL REFERENCES global_recipes(id) ON DELETE CASCADE,
  step_number       INT NOT NULL,
  instruction       TEXT NOT NULL,
  duration_min      INT,

  CONSTRAINT uq_gr_step_order UNIQUE (global_recipe_id, step_number)
);

COMMENT ON TABLE global_recipe_steps IS 'Ordered cooking instructions for global recipes.';

-- ---------------------------------------------------------------------------
-- 4. Indexes
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_global_recipes_cuisine
  ON global_recipes(cuisine);

CREATE INDEX IF NOT EXISTS idx_global_recipes_cuisine_cat
  ON global_recipes(cuisine_category);

CREATE INDEX IF NOT EXISTS idx_global_recipes_veg
  ON global_recipes(is_vegetarian);

CREATE INDEX IF NOT EXISTS idx_global_recipes_meal_types
  ON global_recipes USING GIN(meal_types);

CREATE INDEX IF NOT EXISTS idx_global_recipes_dietary_tags
  ON global_recipes USING GIN(dietary_tags);

CREATE INDEX IF NOT EXISTS idx_global_recipes_cooking_style
  ON global_recipes USING GIN(cooking_style);

CREATE INDEX IF NOT EXISTS idx_global_recipes_import_count
  ON global_recipes(import_count DESC);

CREATE INDEX IF NOT EXISTS idx_gr_ingredients_recipe
  ON global_recipe_ingredients(global_recipe_id);

CREATE INDEX IF NOT EXISTS idx_gr_steps_recipe
  ON global_recipe_steps(global_recipe_id);

-- ---------------------------------------------------------------------------
-- 5. RLS Policies — SELECT only for authenticated users
-- ---------------------------------------------------------------------------
ALTER TABLE global_recipes ENABLE ROW LEVEL SECURITY;
ALTER TABLE global_recipe_ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE global_recipe_steps ENABLE ROW LEVEL SECURITY;

-- Drop if exists for idempotency
DROP POLICY IF EXISTS global_recipes_select ON global_recipes;
DROP POLICY IF EXISTS global_recipe_ingredients_select ON global_recipe_ingredients;
DROP POLICY IF EXISTS global_recipe_steps_select ON global_recipe_steps;

CREATE POLICY global_recipes_select
  ON global_recipes FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY global_recipe_ingredients_select
  ON global_recipe_ingredients FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY global_recipe_steps_select
  ON global_recipe_steps FOR SELECT
  TO authenticated
  USING (true);

-- No INSERT/UPDATE/DELETE policies — admin-only via service role or SQL editor

-- ---------------------------------------------------------------------------
-- Verification
-- ---------------------------------------------------------------------------
SELECT 'global_recipes' AS table_name, count(*) AS row_count FROM global_recipes;
SELECT 'global_recipe_ingredients' AS table_name, count(*) AS row_count FROM global_recipe_ingredients;
SELECT 'global_recipe_steps' AS table_name, count(*) AS row_count FROM global_recipe_steps;

-- ---------------------------------------------------------------------------
-- Rollback (uncomment if needed)
-- ---------------------------------------------------------------------------
-- DROP TABLE IF EXISTS global_recipe_steps CASCADE;
-- DROP TABLE IF EXISTS global_recipe_ingredients CASCADE;
-- DROP TABLE IF EXISTS global_recipes CASCADE;
