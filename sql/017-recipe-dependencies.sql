-- =============================================================================
-- Plateful — Migration 017: Recipe Dependency Columns
-- =============================================================================
-- Adds dish_role, is_standalone, pairing_group, needs_roles to global_recipes.
-- Also adds missing columns: is_eggetarian, is_jain, protein_category, cuisine_region.
-- These power the multi-dish/thali system (Phase 6) and auto-pairing suggestions.
--
-- Run AFTER 016-multi-dish-thali.sql
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. Dependency columns on global_recipes
-- ---------------------------------------------------------------------------

-- dish_role: what role this recipe plays in a multi-dish meal
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS dish_role TEXT NOT NULL DEFAULT 'complete'
  CHECK (dish_role IN ('main', 'staple', 'side', 'accompaniment', 'complete'));

COMMENT ON COLUMN global_recipes.dish_role IS 'Role in a multi-dish meal: main (protein/gravy), staple (rice/bread), side (veggie), accompaniment (raita/chutney), complete (self-contained)';

-- is_standalone: whether this recipe forms a complete meal on its own
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS is_standalone BOOLEAN NOT NULL DEFAULT true;

COMMENT ON COLUMN global_recipes.is_standalone IS 'True if this recipe is a complete meal alone (biryani, sandwich, etc). False if it needs other dishes.';

-- pairing_group: which cuisine family this recipe pairs with
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS pairing_group TEXT;

COMMENT ON COLUMN global_recipes.pairing_group IS 'Cuisine pairing family: north, south, bengali, maharashtrian, indo_chinese, continental, gujarati, street, arabian';

-- needs_roles: what other dish roles are needed to complete this meal
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS needs_roles TEXT[] DEFAULT '{}';

COMMENT ON COLUMN global_recipes.needs_roles IS 'What roles are needed to complete this meal. E.g., main needs [staple], side needs [main, staple], complete needs [].';

-- ---------------------------------------------------------------------------
-- 2. Missing metadata columns from Codex data
-- ---------------------------------------------------------------------------

-- is_eggetarian: contains eggs but no meat
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS is_eggetarian BOOLEAN NOT NULL DEFAULT false;

COMMENT ON COLUMN global_recipes.is_eggetarian IS 'Contains eggs but no meat/fish. Useful for eggetarian dietary mode.';

-- is_jain: safe for Jain diet (no onion, garlic, root vegetables)
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS is_jain BOOLEAN NOT NULL DEFAULT false;

COMMENT ON COLUMN global_recipes.is_jain IS 'Safe for Jain diet (no onion, garlic, root vegetables).';

-- protein_category: primary protein source for rotation/variety tracking
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS protein_category TEXT;

COMMENT ON COLUMN global_recipes.protein_category IS 'Primary protein: chicken, mutton, lamb, fish, prawns, egg, paneer, dal, legume, soya, tofu, or null.';

-- cuisine_region: sub-regional style (e.g., "dhaba-style", "restaurant-style")
ALTER TABLE global_recipes ADD COLUMN IF NOT EXISTS cuisine_region TEXT;

COMMENT ON COLUMN global_recipes.cuisine_region IS 'Sub-regional cooking style like dhaba-style, tiffin-style, restaurant-style.';

-- ---------------------------------------------------------------------------
-- 3. Same columns on household recipes table (for imported recipes)
-- ---------------------------------------------------------------------------

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS dish_role TEXT NOT NULL DEFAULT 'complete'
  CHECK (dish_role IN ('main', 'staple', 'side', 'accompaniment', 'complete'));

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS is_standalone BOOLEAN NOT NULL DEFAULT true;

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS pairing_group TEXT;

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS needs_roles TEXT[] DEFAULT '{}';

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS is_eggetarian BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS is_jain BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS protein_category TEXT;

ALTER TABLE recipes ADD COLUMN IF NOT EXISTS cuisine_region TEXT;

-- ---------------------------------------------------------------------------
-- 4. Indexes for efficient pairing queries
-- ---------------------------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_global_recipes_dish_role
  ON global_recipes(dish_role);

CREATE INDEX IF NOT EXISTS idx_global_recipes_pairing_group
  ON global_recipes(pairing_group);

CREATE INDEX IF NOT EXISTS idx_global_recipes_standalone
  ON global_recipes(is_standalone);

CREATE INDEX IF NOT EXISTS idx_global_recipes_needs_roles
  ON global_recipes USING GIN(needs_roles);

CREATE INDEX IF NOT EXISTS idx_global_recipes_protein_cat
  ON global_recipes(protein_category);

CREATE INDEX IF NOT EXISTS idx_recipes_dish_role
  ON recipes(dish_role);

CREATE INDEX IF NOT EXISTS idx_recipes_pairing_group
  ON recipes(pairing_group);

-- ---------------------------------------------------------------------------
-- Verification
-- ---------------------------------------------------------------------------
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'global_recipes'
  AND column_name IN ('dish_role', 'is_standalone', 'pairing_group', 'needs_roles', 'is_eggetarian', 'is_jain', 'protein_category', 'cuisine_region')
ORDER BY column_name;

SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'recipes'
  AND column_name IN ('dish_role', 'is_standalone', 'pairing_group', 'needs_roles', 'is_eggetarian', 'is_jain', 'protein_category', 'cuisine_region')
ORDER BY column_name;

-- ---------------------------------------------------------------------------
-- Rollback (uncomment if needed)
-- ---------------------------------------------------------------------------
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS dish_role;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS is_standalone;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS pairing_group;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS needs_roles;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS is_eggetarian;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS is_jain;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS protein_category;
-- ALTER TABLE global_recipes DROP COLUMN IF EXISTS cuisine_region;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS dish_role;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS is_standalone;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS pairing_group;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS needs_roles;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS is_eggetarian;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS is_jain;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS protein_category;
-- ALTER TABLE recipes DROP COLUMN IF EXISTS cuisine_region;
