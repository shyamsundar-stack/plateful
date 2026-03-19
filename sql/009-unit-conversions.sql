-- ============================================================================
-- 009 — Unit Conversions + Nutrition Support + Pregnancy Safety
-- Session 10: Weekly Nutrition Dashboard
-- ============================================================================
-- This migration adds:
--   1. unit_conversions table — kitchen unit to gram/ml conversion
--   2. household_members: biological_sex + pregnancy_trimester columns
--   3. global_ingredients + ingredients: is_pregnancy_unsafe + pregnancy_warning
--   4. meal_slots: manual macro columns for eat-outside logging
--   5. ~13 new pregnancy-unsafe global ingredients + flag existing ones
--   6. Updated copy_global_ingredients() to propagate new columns
--   7. Backfill existing household ingredients with pregnancy flags
--
-- Run this in the Supabase SQL Editor BEFORE testing Session 10 features.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. Unit Conversions Table
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS unit_conversions (
  unit_name      TEXT PRIMARY KEY,
  grams_per_unit DECIMAL NOT NULL,
  notes          TEXT
);

COMMENT ON TABLE unit_conversions IS 'Kitchen unit to grams conversion. Used by nutrition calculator to convert recipe quantities.';

INSERT INTO unit_conversions (unit_name, grams_per_unit, notes) VALUES
-- Volume (approximate for water/liquids, density ≈ 1)
('tsp',           5,       'teaspoon = 5ml ≈ 5g'),
('tbsp',          15,      'tablespoon = 15ml ≈ 15g'),
('cup',           240,     'US cup = 240ml ≈ 240g for liquids'),
('ml',            1,       'milliliter ≈ 1g for water-density liquids'),
('l',             1000,    'liter = 1000ml'),
('fl oz',         30,      'fluid ounce ≈ 30ml'),

-- Weight
('g',             1,       'gram — base unit'),
('kg',            1000,    'kilogram = 1000g'),
('oz',            28.35,   'ounce = 28.35g'),
('lb',            453.6,   'pound = 453.6g'),

-- Indian kitchen measures
('katori',        150,     'standard Indian bowl ≈ 150g/ml'),
('glass',         200,     'standard drinking glass ≈ 200ml'),
('pinch',         0.5,     'pinch of spice ≈ 0.5g'),
('handful',       30,      'handful ≈ 30g (varies by ingredient)'),

-- Piece-based (rough estimates — lower confidence)
('piece',         100,     'generic piece ≈ 100g (use piece_small/medium/large for specificity)'),
('piece_small',   50,      'small piece (e.g., small onion, 1 egg) ≈ 50g'),
('piece_medium',  100,     'medium piece (e.g., medium potato, tomato) ≈ 100g'),
('piece_large',   200,     'large piece (e.g., large potato, banana) ≈ 200g'),
('clove',         3,       'garlic clove ≈ 3g'),
('inch',          10,      '1 inch ginger/turmeric ≈ 10g'),
('sprig',         2,       'sprig of herb (curry leaves, cilantro) ≈ 2g'),
('bunch',         50,      'bunch of herbs/greens ≈ 50g'),
('slice',         20,      'slice of bread/cheese ≈ 20g'),
('stick',         10,      'cinnamon stick ≈ 10g'),
('pod',           1,       'cardamom pod ≈ 1g'),
('leaf',          0.5,     'bay leaf / curry leaf ≈ 0.5g'),
('whole',         5,       'whole spice (clove, peppercorn) ≈ 5g'),
('drop',          0.05,    'drop of essence ≈ 0.05g'),

-- Common aliases
('tablespoon',    15,      'alias for tbsp'),
('teaspoon',      5,       'alias for tsp'),
('litre',         1000,    'British spelling of liter'),
('liter',         1000,    'alias for l')
ON CONFLICT (unit_name) DO NOTHING;

-- ---------------------------------------------------------------------------
-- 2. ALTER household_members — biological_sex + pregnancy_trimester
-- ---------------------------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'household_members' AND column_name = 'biological_sex'
  ) THEN
    ALTER TABLE household_members
      ADD COLUMN biological_sex TEXT DEFAULT NULL;
    ALTER TABLE household_members
      ADD CONSTRAINT chk_biological_sex
        CHECK (biological_sex IS NULL OR biological_sex IN ('male', 'female', 'other'));
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'household_members' AND column_name = 'pregnancy_trimester'
  ) THEN
    ALTER TABLE household_members
      ADD COLUMN pregnancy_trimester SMALLINT NOT NULL DEFAULT 0;
    ALTER TABLE household_members
      ADD CONSTRAINT chk_pregnancy_trimester
        CHECK (pregnancy_trimester BETWEEN 0 AND 3);
  END IF;
END $$;

COMMENT ON COLUMN household_members.biological_sex IS 'Used for TDEE calculation (Mifflin-St Jeor). NULL = use average formula.';
COMMENT ON COLUMN household_members.pregnancy_trimester IS '0 = not pregnant, 1/2/3 = trimester. Used for ingredient safety alerts.';

-- ---------------------------------------------------------------------------
-- 3. ALTER global_ingredients — is_pregnancy_unsafe + pregnancy_warning
-- ---------------------------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'global_ingredients' AND column_name = 'is_pregnancy_unsafe'
  ) THEN
    ALTER TABLE global_ingredients
      ADD COLUMN is_pregnancy_unsafe BOOLEAN NOT NULL DEFAULT false;
    ALTER TABLE global_ingredients
      ADD COLUMN pregnancy_warning TEXT;
  END IF;
END $$;

-- ---------------------------------------------------------------------------
-- 4. ALTER ingredients (per-household) — same columns
-- ---------------------------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'ingredients' AND column_name = 'is_pregnancy_unsafe'
  ) THEN
    ALTER TABLE ingredients
      ADD COLUMN is_pregnancy_unsafe BOOLEAN NOT NULL DEFAULT false;
    ALTER TABLE ingredients
      ADD COLUMN pregnancy_warning TEXT;
  END IF;
END $$;

-- ---------------------------------------------------------------------------
-- 5. ALTER meal_slots — manual macro columns for eat-outside logging
-- ---------------------------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'meal_slots' AND column_name = 'manual_calories'
  ) THEN
    ALTER TABLE meal_slots
      ADD COLUMN manual_calories   DECIMAL,
      ADD COLUMN manual_protein_g  DECIMAL,
      ADD COLUMN manual_carbs_g    DECIMAL,
      ADD COLUMN manual_fat_g      DECIMAL;
  END IF;
END $$;

COMMENT ON COLUMN meal_slots.manual_calories IS 'Manually entered calories for eat_outside slots. NULL = not logged.';

-- ---------------------------------------------------------------------------
-- 6. INSERT new pregnancy-unsafe global ingredients
-- ---------------------------------------------------------------------------
-- These items are NOT in the original 250-ingredient seed (002-seed-global-ingredients.sql).
-- We add them now so they can be flagged and propagated to households.
-- ---------------------------------------------------------------------------
INSERT INTO global_ingredients (name, aliases, category, default_unit, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g, is_pregnancy_unsafe, pregnancy_warning) VALUES
('raw papaya',            ARRAY['green papaya','kachha papaya','unripe papaya'], 'fruit', 'g', 43, 0.5, 11, 0.3, 1.7, true, 'Unripe papaya contains latex which may trigger uterine contractions'),
('shark',                 ARRAY['shark meat'], 'protein', 'g', 130, 21, 0, 4.5, 0, true, 'High mercury content — avoid during pregnancy'),
('swordfish',             ARRAY['swordfish steak'], 'protein', 'g', 144, 20, 0, 6.7, 0, true, 'High mercury content — avoid during pregnancy'),
('tilefish',              ARRAY['tile fish'], 'protein', 'g', 96, 18, 0, 2.3, 0, true, 'High mercury content — avoid during pregnancy'),
('liver (chicken)',       ARRAY['chicken liver','murgh kaleja'], 'protein', 'g', 119, 17, 1, 5, 0, true, 'Extremely high vitamin A — toxic in excess during pregnancy'),
('liver (goat)',          ARRAY['goat liver','bakra kaleja','kaleji'], 'protein', 'g', 130, 20, 3, 4, 0, true, 'Extremely high vitamin A — toxic in excess during pregnancy'),
('brie',                  ARRAY['brie cheese'], 'dairy', 'g', 334, 21, 0.5, 28, 0, true, 'Soft ripened cheese — risk of listeria during pregnancy'),
('camembert',             ARRAY['camembert cheese'], 'dairy', 'g', 300, 20, 0.5, 24, 0, true, 'Soft ripened cheese — risk of listeria during pregnancy'),
('blue cheese',           ARRAY['gorgonzola','roquefort','stilton'], 'dairy', 'g', 353, 21, 2, 29, 0, true, 'Mould-ripened cheese — risk of listeria during pregnancy'),
('raw sprouts',           ARRAY['raw bean sprouts','raw alfalfa sprouts'], 'vegetable', 'g', 31, 3, 6, 0.2, 1.8, true, 'Risk of salmonella/E. coli — immune system is weakened during pregnancy'),
('raw egg',               ARRAY['uncooked egg','kachha anda'], 'protein', 'piece', 155, 13, 1.1, 11, 0, true, 'Risk of salmonella — avoid undercooked or raw eggs during pregnancy'),
('alcohol',               ARRAY['wine','beer','spirits','sharab','daru'], 'other', 'ml', 231, 0, 0, 0, 0, true, 'No safe level of alcohol during pregnancy'),
('unpasteurised cheese',  ARRAY['raw milk cheese','artisan cheese'], 'dairy', 'g', 371, 23, 1.3, 30, 0, true, 'Risk of listeria from unpasteurised dairy during pregnancy')
ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------------------
-- 7. Flag EXISTING global ingredients that are pregnancy-unsafe
-- ---------------------------------------------------------------------------
-- surmai (king mackerel) — already in catalog
UPDATE global_ingredients
SET is_pregnancy_unsafe = true,
    pregnancy_warning = 'High mercury content (king mackerel/seer fish) — avoid during pregnancy'
WHERE name = 'surmai'
  AND is_pregnancy_unsafe = false;

-- pineapple — high bromelain
UPDATE global_ingredients
SET is_pregnancy_unsafe = true,
    pregnancy_warning = 'High bromelain content — may cause uterine contractions in large quantities'
WHERE name = 'pineapple'
  AND is_pregnancy_unsafe = false;

-- ---------------------------------------------------------------------------
-- 8. Update copy_global_ingredients() to propagate new columns
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION copy_global_ingredients(target_household_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  copied_count INT;
BEGIN
  -- Verify the household exists
  IF NOT EXISTS (SELECT 1 FROM public.households WHERE id = target_household_id) THEN
    RAISE EXCEPTION 'Household % does not exist', target_household_id;
  END IF;

  -- Copy all global ingredients into the household's library
  -- Now includes is_pregnancy_unsafe + pregnancy_warning
  INSERT INTO public.ingredients (
    household_id, name, aliases, category, default_unit,
    calories_per_100g, protein_per_100g, carbs_per_100g,
    fat_per_100g, fiber_per_100g,
    is_pregnancy_unsafe, pregnancy_warning
  )
  SELECT
    target_household_id, name, aliases, category, default_unit,
    calories_per_100g, protein_per_100g, carbs_per_100g,
    fat_per_100g, fiber_per_100g,
    is_pregnancy_unsafe, pregnancy_warning
  FROM public.global_ingredients;

  GET DIAGNOSTICS copied_count = ROW_COUNT;
  RETURN copied_count;
END;
$$;

COMMENT ON FUNCTION copy_global_ingredients IS 'Copies all global ingredients into a household ingredient library. Includes pregnancy safety flags. Call on household creation.';

-- ---------------------------------------------------------------------------
-- 9. Backfill existing household ingredients with pregnancy flags
-- ---------------------------------------------------------------------------
-- For households that already have ingredients (copied before this migration),
-- update them with the pregnancy flags from global_ingredients.
UPDATE ingredients i
SET is_pregnancy_unsafe = g.is_pregnancy_unsafe,
    pregnancy_warning = g.pregnancy_warning
FROM global_ingredients g
WHERE i.name = g.name
  AND g.is_pregnancy_unsafe = true
  AND i.is_pregnancy_unsafe = false;

-- Also insert NEW pregnancy-unsafe ingredients into existing households
-- (e.g., raw papaya, shark, etc. that weren't in the original seed)
INSERT INTO ingredients (
  household_id, name, aliases, category, default_unit,
  calories_per_100g, protein_per_100g, carbs_per_100g,
  fat_per_100g, fiber_per_100g,
  is_pregnancy_unsafe, pregnancy_warning
)
SELECT
  h.id, g.name, g.aliases, g.category, g.default_unit,
  g.calories_per_100g, g.protein_per_100g, g.carbs_per_100g,
  g.fat_per_100g, g.fiber_per_100g,
  g.is_pregnancy_unsafe, g.pregnancy_warning
FROM global_ingredients g
CROSS JOIN households h
WHERE g.is_pregnancy_unsafe = true
  AND NOT EXISTS (
    SELECT 1 FROM ingredients i
    WHERE i.household_id = h.id AND i.name = g.name
  );

-- ============================================================================
-- Verification
-- ============================================================================

-- Check unit_conversions
SELECT count(*) AS unit_conversions_count FROM unit_conversions;

-- Check new columns exist
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'household_members'
  AND column_name IN ('biological_sex', 'pregnancy_trimester')
ORDER BY column_name;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'ingredients'
  AND column_name IN ('is_pregnancy_unsafe', 'pregnancy_warning')
ORDER BY column_name;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'meal_slots'
  AND column_name IN ('manual_calories', 'manual_protein_g', 'manual_carbs_g', 'manual_fat_g')
ORDER BY column_name;

-- Check pregnancy-unsafe global ingredients
SELECT name, pregnancy_warning
FROM global_ingredients
WHERE is_pregnancy_unsafe = true
ORDER BY name;

-- Check pregnancy-unsafe household ingredients (backfilled)
SELECT i.name, i.pregnancy_warning, h.name AS household_name
FROM ingredients i
JOIN households h ON i.household_id = h.id
WHERE i.is_pregnancy_unsafe = true
ORDER BY h.name, i.name;

-- ============================================================================
-- ROLLBACK (uncomment to remove)
-- ============================================================================
-- DROP TABLE IF EXISTS unit_conversions;
-- ALTER TABLE household_members DROP COLUMN IF EXISTS biological_sex;
-- ALTER TABLE household_members DROP COLUMN IF EXISTS pregnancy_trimester;
-- ALTER TABLE global_ingredients DROP COLUMN IF EXISTS is_pregnancy_unsafe;
-- ALTER TABLE global_ingredients DROP COLUMN IF EXISTS pregnancy_warning;
-- ALTER TABLE ingredients DROP COLUMN IF EXISTS is_pregnancy_unsafe;
-- ALTER TABLE ingredients DROP COLUMN IF EXISTS pregnancy_warning;
-- ALTER TABLE meal_slots DROP COLUMN IF EXISTS manual_calories;
-- ALTER TABLE meal_slots DROP COLUMN IF EXISTS manual_protein_g;
-- ALTER TABLE meal_slots DROP COLUMN IF EXISTS manual_carbs_g;
-- ALTER TABLE meal_slots DROP COLUMN IF EXISTS manual_fat_g;
