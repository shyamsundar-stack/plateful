-- =============================================================================
-- Plateful — Phase 1 Foundation Schema
-- =============================================================================
-- Run this in Supabase SQL Editor (single execution, top to bottom).
-- All tables use: UUID PKs, created_at/updated_at, household_id tenant key.
-- ENUMs use TEXT + CHECK constraints (easier to evolve than CREATE TYPE).
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 0. Extensions
-- ---------------------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ---------------------------------------------------------------------------
-- 1. households — top-level tenant container
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS households (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name        TEXT NOT NULL,
  created_by  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  is_archived BOOLEAN NOT NULL DEFAULT false,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE households IS 'Top-level tenant container. Every user-facing row links here.';

-- ---------------------------------------------------------------------------
-- 2. household_members — people in the household (not all are app users)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS household_members (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  household_id    UUID NOT NULL REFERENCES households(id) ON DELETE RESTRICT,
  name            TEXT NOT NULL,
  age             INT,
  height_cm       DECIMAL,
  weight_kg       DECIMAL,
  activity_level  TEXT NOT NULL DEFAULT 'moderate',
  goal            TEXT NOT NULL DEFAULT 'general_health',
  dietary_notes   TEXT,  -- free-text dietary info (structured prefs in Phase 2)
  is_app_user     BOOLEAN NOT NULL DEFAULT false,
  auth_user_id    UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  is_archived     BOOLEAN NOT NULL DEFAULT false,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_activity_level
    CHECK (activity_level IN ('sedentary','light','moderate','active','very_active')),
  CONSTRAINT chk_goal
    CHECK (goal IN ('maintain','lose_weight','gain_muscle','general_health'))
);

COMMENT ON TABLE household_members IS 'People in the household. Kids/elderly have is_app_user=false.';

-- ---------------------------------------------------------------------------
-- 3. global_ingredients — seeded template catalog (not per-household)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS global_ingredients (
  id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name              TEXT NOT NULL,
  aliases           TEXT[] DEFAULT '{}',
  category          TEXT NOT NULL DEFAULT 'other',
  default_unit      TEXT NOT NULL DEFAULT 'g',
  calories_per_100g DECIMAL,
  protein_per_100g  DECIMAL,
  carbs_per_100g    DECIMAL,
  fat_per_100g      DECIMAL,
  fiber_per_100g    DECIMAL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_global_ingredient_category
    CHECK (category IN ('vegetable','fruit','grain','protein','dairy','spice','oil','condiment','nut','legume','other'))
);

COMMENT ON TABLE global_ingredients IS 'Pre-seeded ingredient catalog. Copied to household ingredients on signup.';

-- ---------------------------------------------------------------------------
-- 4. ingredients — per-household ingredient library
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ingredients (
  id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  household_id      UUID NOT NULL REFERENCES households(id) ON DELETE RESTRICT,
  name              TEXT NOT NULL,
  aliases           TEXT[] DEFAULT '{}',
  category          TEXT NOT NULL DEFAULT 'other',
  default_unit      TEXT NOT NULL DEFAULT 'g',
  calories_per_100g DECIMAL,
  protein_per_100g  DECIMAL,
  carbs_per_100g    DECIMAL,
  fat_per_100g      DECIMAL,
  fiber_per_100g    DECIMAL,
  is_archived       BOOLEAN NOT NULL DEFAULT false,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_ingredient_category
    CHECK (category IN ('vegetable','fruit','grain','protein','dairy','spice','oil','condiment','nut','legume','other'))
);

COMMENT ON TABLE ingredients IS 'Per-household ingredient library with nutrition data. Seeded from global_ingredients.';

-- ---------------------------------------------------------------------------
-- 5. recipes — the recipe library
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS recipes (
  id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  household_id      UUID NOT NULL REFERENCES households(id) ON DELETE RESTRICT,
  title             TEXT NOT NULL,
  description       TEXT,
  cuisine           TEXT,
  meal_types        TEXT[] DEFAULT '{}',
  servings          INT NOT NULL DEFAULT 2,
  prep_time_min     INT,
  cook_time_min     INT,
  total_time_min    INT GENERATED ALWAYS AS (
                      COALESCE(prep_time_min, 0) + COALESCE(cook_time_min, 0)
                    ) STORED,
  difficulty        TEXT NOT NULL DEFAULT 'medium',
  tags              TEXT[] DEFAULT '{}',
  source_type       TEXT NOT NULL DEFAULT 'manual',
  source_url        TEXT,
  source_text       TEXT,
  image_url         TEXT,
  status            TEXT NOT NULL DEFAULT 'draft',
  is_vegetarian     BOOLEAN NOT NULL DEFAULT false,
  is_vegan          BOOLEAN NOT NULL DEFAULT false,
  is_batch_friendly BOOLEAN NOT NULL DEFAULT false,
  leftover_days     INT NOT NULL DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_difficulty
    CHECK (difficulty IN ('easy','medium','hard')),
  CONSTRAINT chk_source_type
    CHECK (source_type IN ('manual','paste_import','url_import')),
  CONSTRAINT chk_status
    CHECK (status IN ('draft','active','archived')),
  CONSTRAINT chk_servings_positive
    CHECK (servings > 0),
  CONSTRAINT chk_leftover_days_non_negative
    CHECK (leftover_days >= 0)
);

COMMENT ON TABLE recipes IS 'Household recipe library. Imported recipes start as draft.';

-- ---------------------------------------------------------------------------
-- 6. recipe_ingredients — junction: ingredients + quantities for a recipe
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS recipe_ingredients (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  recipe_id     UUID NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  ingredient_id UUID NOT NULL REFERENCES ingredients(id) ON DELETE RESTRICT,
  quantity      DECIMAL NOT NULL,
  unit          TEXT NOT NULL,
  preparation   TEXT,
  is_optional   BOOLEAN NOT NULL DEFAULT false,
  group_name    TEXT,
  sort_order    INT NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE recipe_ingredients IS 'Links recipes to ingredients with quantity, unit, and preparation method.';

-- ---------------------------------------------------------------------------
-- 7. recipe_steps — ordered cooking instructions
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS recipe_steps (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  recipe_id    UUID NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  step_number  INT NOT NULL,
  instruction  TEXT NOT NULL,
  duration_min INT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT uq_recipe_step_order UNIQUE (recipe_id, step_number)
);

COMMENT ON TABLE recipe_steps IS 'Ordered cooking instructions for a recipe.';

-- ---------------------------------------------------------------------------
-- 8. Indexes
-- ---------------------------------------------------------------------------

-- Household lookups (primary query pattern)
CREATE INDEX idx_household_members_household ON household_members(household_id);
CREATE INDEX idx_ingredients_household       ON ingredients(household_id);
CREATE INDEX idx_recipes_household           ON recipes(household_id);

-- Recipe list page: filter by household + status
CREATE INDEX idx_recipes_household_status    ON recipes(household_id, status);

-- Ingredient search within a household
CREATE INDEX idx_ingredients_household_name  ON ingredients(household_id, lower(name));

-- Ingredient alias search (GIN for array containment)
CREATE INDEX idx_ingredients_aliases         ON ingredients USING GIN(aliases);

-- Recipe detail page: child rows
CREATE INDEX idx_recipe_ingredients_recipe   ON recipe_ingredients(recipe_id);
CREATE INDEX idx_recipe_steps_recipe         ON recipe_steps(recipe_id);

-- Global ingredients: name + alias search
CREATE INDEX idx_global_ingredients_name     ON global_ingredients(lower(name));
CREATE INDEX idx_global_ingredients_aliases  ON global_ingredients USING GIN(aliases);

-- ---------------------------------------------------------------------------
-- 9. Auto-update updated_at trigger
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_households_updated_at
  BEFORE UPDATE ON households
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_household_members_updated_at
  BEFORE UPDATE ON household_members
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_ingredients_updated_at
  BEFORE UPDATE ON ingredients
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_recipes_updated_at
  BEFORE UPDATE ON recipes
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ---------------------------------------------------------------------------
-- 10. Verification queries — run these to confirm everything worked
-- ---------------------------------------------------------------------------
SELECT 'households'        AS table_name, count(*) FROM households
UNION ALL
SELECT 'household_members', count(*) FROM household_members
UNION ALL
SELECT 'global_ingredients', count(*) FROM global_ingredients
UNION ALL
SELECT 'ingredients',       count(*) FROM ingredients
UNION ALL
SELECT 'recipes',           count(*) FROM recipes
UNION ALL
SELECT 'recipe_ingredients', count(*) FROM recipe_ingredients
UNION ALL
SELECT 'recipe_steps',      count(*) FROM recipe_steps;

-- ---------------------------------------------------------------------------
-- ROLLBACK (uncomment to tear down — use with caution)
-- ---------------------------------------------------------------------------
-- DROP TRIGGER IF EXISTS trg_recipes_updated_at ON recipes;
-- DROP TRIGGER IF EXISTS trg_ingredients_updated_at ON ingredients;
-- DROP TRIGGER IF EXISTS trg_household_members_updated_at ON household_members;
-- DROP TRIGGER IF EXISTS trg_households_updated_at ON households;
-- DROP FUNCTION IF EXISTS update_updated_at();
-- DROP TABLE IF EXISTS recipe_steps;
-- DROP TABLE IF EXISTS recipe_ingredients;
-- DROP TABLE IF EXISTS recipes;
-- DROP TABLE IF EXISTS ingredients;
-- DROP TABLE IF EXISTS global_ingredients;
-- DROP TABLE IF EXISTS household_members;
-- DROP TABLE IF EXISTS households;
