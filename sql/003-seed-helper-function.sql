-- =============================================================================
-- Plateful — Helper Function: Copy Global Ingredients to New Household
-- =============================================================================
-- Call this RPC when creating a new household to seed their ingredient library.
-- Usage from Supabase client:
--   const { data, error } = await supabase.rpc('copy_global_ingredients', {
--     target_household_id: 'uuid-here'
--   });
--
-- Run AFTER 001-foundation-schema.sql and 002-seed-global-ingredients.sql
-- =============================================================================

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
  INSERT INTO public.ingredients (
    household_id, name, aliases, category, default_unit,
    calories_per_100g, protein_per_100g, carbs_per_100g,
    fat_per_100g, fiber_per_100g
  )
  SELECT
    target_household_id, name, aliases, category, default_unit,
    calories_per_100g, protein_per_100g, carbs_per_100g,
    fat_per_100g, fiber_per_100g
  FROM public.global_ingredients;

  GET DIAGNOSTICS copied_count = ROW_COUNT;
  RETURN copied_count;
END;
$$;

COMMENT ON FUNCTION copy_global_ingredients IS 'Copies all global ingredients into a household ingredient library. Call on household creation.';

-- ---------------------------------------------------------------------------
-- Verification: test the function exists
-- ---------------------------------------------------------------------------
SELECT proname, proargnames, prorettype::regtype
FROM pg_proc
WHERE proname = 'copy_global_ingredients';
