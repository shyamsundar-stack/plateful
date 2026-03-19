-- =============================================================================
-- Plateful — Fix: Fully qualify table names in copy_global_ingredients()
-- =============================================================================
-- PROBLEM: copy_global_ingredients() used SECURITY DEFINER without
-- SET search_path or fully qualified table names. When called from
-- handle_new_user() (which has SET search_path = ''), PostgreSQL
-- couldn't resolve the unqualified table names → "Database error
-- creating new user".
--
-- FIX: Recreate the function with SET search_path = '' and
-- public.tablename on all references.
--
-- Run this in Supabase SQL Editor. Then try creating a user again.
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

-- ---------------------------------------------------------------------------
-- Verification: confirm function was updated
-- ---------------------------------------------------------------------------
SELECT proname, prosecdef AS security_definer, proconfig
FROM pg_proc
WHERE proname = 'copy_global_ingredients';
-- Expected: proconfig should show {search_path=}
