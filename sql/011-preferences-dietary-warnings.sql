-- ============================================================================
-- 011 – Recipe Preferences + Dietary Warning Support
-- Session 14: Safety + Polish + Preference Learning
-- Run in: Supabase SQL Editor
-- ============================================================================

-- ─────────────────────────────────────────────
-- 1. recipe_preferences — tracks accept/reject per member per recipe
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS recipe_preferences (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id  UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  member_id     UUID NOT NULL REFERENCES household_members(id) ON DELETE CASCADE,
  recipe_id     UUID NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  action        TEXT NOT NULL CHECK (action IN ('accept', 'reject', 'skip')),
  meal_type     TEXT CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')),
  week_start    DATE,
  context_notes TEXT,
  created_at    TIMESTAMPTZ DEFAULT now()
);

COMMENT ON TABLE recipe_preferences IS 'Tracks recipe accept/reject per member for preference learning.';
COMMENT ON COLUMN recipe_preferences.action IS 'accept = assigned to slot, reject = removed from slot, skip = suggested but not picked';
COMMENT ON COLUMN recipe_preferences.meal_type IS 'Which meal type this preference was recorded for';
COMMENT ON COLUMN recipe_preferences.week_start IS 'Which week plan this preference was recorded in';

-- Indexes for efficient querying
CREATE INDEX IF NOT EXISTS idx_recipe_prefs_household
  ON recipe_preferences(household_id);
CREATE INDEX IF NOT EXISTS idx_recipe_prefs_member_recipe
  ON recipe_preferences(member_id, recipe_id);
CREATE INDEX IF NOT EXISTS idx_recipe_prefs_recipe
  ON recipe_preferences(recipe_id);
CREATE INDEX IF NOT EXISTS idx_recipe_prefs_created
  ON recipe_preferences(created_at DESC);

-- ─────────────────────────────────────────────
-- 2. RLS policies
-- ─────────────────────────────────────────────

ALTER TABLE recipe_preferences ENABLE ROW LEVEL SECURITY;

-- SELECT: household members can read their household's preferences
CREATE POLICY recipe_preferences_select ON recipe_preferences
  FOR SELECT USING (
    household_id = public.get_my_household_id()
  );

-- INSERT: household members can log preferences
CREATE POLICY recipe_preferences_insert ON recipe_preferences
  FOR INSERT WITH CHECK (
    household_id = public.get_my_household_id()
  );

-- DELETE: household members can delete preferences (cleanup)
CREATE POLICY recipe_preferences_delete ON recipe_preferences
  FOR DELETE USING (
    household_id = public.get_my_household_id()
  );

-- ─────────────────────────────────────────────
-- 3. Verification
-- ─────────────────────────────────────────────

SELECT 'recipe_preferences' AS table_name, count(*) FROM recipe_preferences
UNION ALL SELECT 'member_dietary_prefs', count(*) FROM member_dietary_prefs;

-- Check RLS is enabled
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public' AND tablename = 'recipe_preferences';

-- Check policies
SELECT policyname, cmd
FROM pg_policies
WHERE tablename = 'recipe_preferences';

-- ─────────────────────────────────────────────
-- ROLLBACK (if needed)
-- ─────────────────────────────────────────────
-- DROP POLICY IF EXISTS recipe_preferences_select ON recipe_preferences;
-- DROP POLICY IF EXISTS recipe_preferences_insert ON recipe_preferences;
-- DROP POLICY IF EXISTS recipe_preferences_delete ON recipe_preferences;
-- DROP TABLE IF EXISTS recipe_preferences CASCADE;
