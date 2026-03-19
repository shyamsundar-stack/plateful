-- ============================================================================
-- 008 — Copy Locked Slots to Next Week
-- Session 9: Recurring Meals + Leftover Linking
-- ============================================================================
-- This RPC copies locked meal slots from one week plan to another.
-- When a user creates a new week plan, any slots marked is_locked = true
-- in the previous week are copied forward (same weekday + meal_type).
--
-- Run this in the Supabase SQL Editor BEFORE testing the lock/copy feature.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Function: copy_locked_slots_to_week
-- ---------------------------------------------------------------------------
-- Matches locked source slots to target slots by:
--   1. Same meal_type (breakfast, lunch, dinner, snack)
--   2. Same day-of-week position (offset from plan start_date)
-- Updates the target slot's meal_mode, recipe_id, and is_locked.
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION copy_locked_slots_to_week(
  p_source_plan_id UUID,
  p_target_plan_id UUID
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_source_start DATE;
  v_target_start DATE;
BEGIN
  -- Get start dates for both plans
  SELECT start_date INTO v_source_start
  FROM week_plans WHERE id = p_source_plan_id;

  SELECT start_date INTO v_target_start
  FROM week_plans WHERE id = p_target_plan_id;

  IF v_source_start IS NULL OR v_target_start IS NULL THEN
    RAISE EXCEPTION 'One or both week plans not found';
  END IF;

  -- Update target slots where a matching locked source slot exists
  -- Match by: same day offset (0-6) from plan start + same meal_type
  UPDATE meal_slots AS target
  SET
    meal_mode   = source.meal_mode,
    recipe_id   = source.recipe_id,
    is_locked   = true,
    updated_at  = now()
  FROM meal_slots AS source
  WHERE source.week_plan_id = p_source_plan_id
    AND source.is_locked = true
    AND target.week_plan_id = p_target_plan_id
    AND target.meal_type = source.meal_type
    AND (target.slot_date - v_target_start) = (source.slot_date - v_source_start);
END;
$$;

COMMENT ON FUNCTION copy_locked_slots_to_week IS
  'Copies locked meal slots from source week to target week, matching by weekday + meal_type. Used when creating a new week plan.';

-- ---------------------------------------------------------------------------
-- Grant execute to authenticated users
-- ---------------------------------------------------------------------------
GRANT EXECUTE ON FUNCTION copy_locked_slots_to_week(UUID, UUID) TO authenticated;

-- ---------------------------------------------------------------------------
-- Verification
-- ---------------------------------------------------------------------------
SELECT
  routine_name,
  routine_type,
  security_type
FROM information_schema.routines
WHERE routine_name = 'copy_locked_slots_to_week'
  AND routine_schema = 'public';

-- ============================================================================
-- ROLLBACK (uncomment to remove)
-- ============================================================================
-- DROP FUNCTION IF EXISTS copy_locked_slots_to_week(UUID, UUID);
