-- =============================================================================
-- Plateful — Phase 5 Migration 013: Dietary Mode + Recipe Taxonomy
-- =============================================================================
-- Adds dietary_mode to household_members (veg/non-veg identity)
-- Adds taxonomy columns to recipes (cuisine_category, cooking_style, dietary_tags)
-- Adds rating + favorite fields to recipes
-- Adds 'library_import' to source_type CHECK constraint
--
-- Run AFTER 012-analytics-events.sql
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. household_members: dietary_mode column
-- ---------------------------------------------------------------------------
ALTER TABLE household_members
  ADD COLUMN IF NOT EXISTS dietary_mode TEXT NOT NULL DEFAULT 'non_vegetarian';

-- Add CHECK constraint (drop first if exists for idempotency)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.check_constraints
    WHERE constraint_name = 'chk_dietary_mode'
  ) THEN
    ALTER TABLE household_members
      ADD CONSTRAINT chk_dietary_mode
      CHECK (dietary_mode IN ('vegetarian', 'non_vegetarian', 'eggetarian', 'vegan'));
  END IF;
END $$;

COMMENT ON COLUMN household_members.dietary_mode IS 'Base dietary identity: vegetarian, non_vegetarian, eggetarian, vegan. Can be overridden by meal_rules on specific days.';

-- ---------------------------------------------------------------------------
-- 2. recipes: taxonomy columns
-- ---------------------------------------------------------------------------
ALTER TABLE recipes
  ADD COLUMN IF NOT EXISTS cuisine_category TEXT;

ALTER TABLE recipes
  ADD COLUMN IF NOT EXISTS cooking_style TEXT[] DEFAULT '{}';

ALTER TABLE recipes
  ADD COLUMN IF NOT EXISTS dietary_tags TEXT[] DEFAULT '{}';

COMMENT ON COLUMN recipes.cuisine_category IS 'Structured cuisine category (north_indian, south_indian, etc). Complements free-text cuisine field.';
COMMENT ON COLUMN recipes.cooking_style IS 'Cooking style tags: quick, one-pot, batch-prep-friendly, weekend-project, stir-fry, deep-fry, bake, steam, grill, slow-cook, no-cook';
COMMENT ON COLUMN recipes.dietary_tags IS 'Dietary classification tags: veg, non-veg, eggetarian, vegan, jain';

-- ---------------------------------------------------------------------------
-- 3. recipes: rating + favorite
-- ---------------------------------------------------------------------------
ALTER TABLE recipes
  ADD COLUMN IF NOT EXISTS rating INT;

ALTER TABLE recipes
  ADD COLUMN IF NOT EXISTS is_favorite BOOLEAN NOT NULL DEFAULT false;

-- Rating constraint (1-5 or null)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.check_constraints
    WHERE constraint_name = 'chk_rating_range'
  ) THEN
    ALTER TABLE recipes
      ADD CONSTRAINT chk_rating_range
      CHECK (rating IS NULL OR (rating >= 1 AND rating <= 5));
  END IF;
END $$;

COMMENT ON COLUMN recipes.rating IS 'User rating 1-5 stars. NULL = unrated.';
COMMENT ON COLUMN recipes.is_favorite IS 'Household favorite flag. Boosted in auto-fill suggestions.';

-- ---------------------------------------------------------------------------
-- 4. recipes: update source_type CHECK to include library_import
-- ---------------------------------------------------------------------------
-- Drop the old constraint and recreate with the new value
ALTER TABLE recipes DROP CONSTRAINT IF EXISTS chk_source_type;
ALTER TABLE recipes
  ADD CONSTRAINT chk_source_type
  CHECK (source_type IN ('manual', 'paste_import', 'url_import', 'library_import'));

-- ---------------------------------------------------------------------------
-- 5. Indexes
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_recipes_cuisine_category
  ON recipes(household_id, cuisine_category);

CREATE INDEX IF NOT EXISTS idx_recipes_dietary_tags
  ON recipes USING GIN(dietary_tags);

CREATE INDEX IF NOT EXISTS idx_recipes_cooking_style
  ON recipes USING GIN(cooking_style);

CREATE INDEX IF NOT EXISTS idx_recipes_is_favorite
  ON recipes(household_id, is_favorite) WHERE is_favorite = true;

CREATE INDEX IF NOT EXISTS idx_members_dietary_mode
  ON household_members(household_id, dietary_mode);

-- ---------------------------------------------------------------------------
-- Verification
-- ---------------------------------------------------------------------------
SELECT 'household_members columns' AS check_type,
       column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'household_members'
  AND column_name = 'dietary_mode';

SELECT 'recipes new columns' AS check_type,
       column_name, data_type
FROM information_schema.columns
WHERE table_name = 'recipes'
  AND column_name IN ('cuisine_category', 'cooking_style', 'dietary_tags', 'rating', 'is_favorite')
ORDER BY column_name;

-- ---------------------------------------------------------------------------
-- Rollback (uncomment if needed)
-- ---------------------------------------------------------------------------
-- ALTER TABLE household_members DROP COLUMN IF EXISTS dietary_mode;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS cuisine_category;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS cooking_style;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS dietary_tags;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS rating;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS is_favorite;
-- ALTER TABLE recipes DROP CONSTRAINT IF EXISTS chk_source_type;
-- ALTER TABLE recipes ADD CONSTRAINT chk_source_type CHECK (source_type IN ('manual', 'paste_import', 'url_import'));
