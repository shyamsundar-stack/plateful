-- =============================================================================
-- Plateful — Auth + RLS Setup (Session 2)
-- =============================================================================
-- Run AFTER 001, 002, 003 in Supabase SQL Editor.
--
-- MANUAL STEP FIRST (do this in Supabase Dashboard before running this file):
--   1. Go to Authentication → Providers → Email
--   2. Enable "Email" provider
--   3. DISABLE "Confirm email" (for testing — enable before going commercial)
--   4. Set Site URL to http://localhost:3000
--
-- This file creates:
--   1. get_my_household_id() — helper function used by all RLS policies
--   2. handle_new_user() — trigger that auto-creates household on signup
--   3. RLS policies on ALL 7 Phase 1 tables
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. Helper: get_my_household_id()
-- ---------------------------------------------------------------------------
-- Returns the household_id for the currently authenticated user.
-- Returns NULL if user has no household (triggers RLS to deny all access).
--
-- SECURITY DEFINER: runs with function owner's permissions, bypassing RLS
-- on household_members. This avoids circular dependency (RLS on
-- household_members needs this function, and this function reads
-- household_members).
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_my_household_id()
RETURNS UUID
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT hm.household_id
  FROM public.household_members hm
  WHERE hm.auth_user_id = auth.uid()
    AND hm.is_archived = false
  LIMIT 1;
$$;

COMMENT ON FUNCTION get_my_household_id IS 'Returns the household_id for the current auth user. Used by all RLS policies.';

-- ---------------------------------------------------------------------------
-- 2. Signup trigger: handle_new_user()
-- ---------------------------------------------------------------------------
-- Fires AFTER INSERT on auth.users.
-- Creates: household → household_member → copies global ingredients.
--
-- SECURITY DEFINER: bypasses RLS because the user has no household yet
-- at the moment this trigger fires.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  new_household_id UUID;
  display_name TEXT;
  ingredient_count INT;
BEGIN
  -- Extract a display name from email (everything before @)
  display_name := split_part(NEW.email, '@', 1);

  -- 1. Create the household
  INSERT INTO public.households (name, created_by)
  VALUES (initcap(display_name) || '''s Kitchen', NEW.id)
  RETURNING id INTO new_household_id;

  -- 2. Create the first household member (the user themselves)
  INSERT INTO public.household_members (
    household_id, name, is_app_user, auth_user_id, goal
  )
  VALUES (
    new_household_id, initcap(display_name), true, NEW.id, 'general_health'
  );

  -- 3. Seed the household ingredient library from global catalog
  SELECT public.copy_global_ingredients(new_household_id) INTO ingredient_count;

  RETURN NEW;
END;
$$;

COMMENT ON FUNCTION handle_new_user IS 'Auto-creates household + member + ingredients on user signup.';

-- Create the trigger on auth.users
-- DROP first in case re-running this file
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ---------------------------------------------------------------------------
-- 3. Enable RLS on ALL tables
-- ---------------------------------------------------------------------------
ALTER TABLE households         ENABLE ROW LEVEL SECURITY;
ALTER TABLE household_members  ENABLE ROW LEVEL SECURITY;
ALTER TABLE global_ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE ingredients        ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipes            ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_steps       ENABLE ROW LEVEL SECURITY;

-- ---------------------------------------------------------------------------
-- 4. RLS Policies: households
-- ---------------------------------------------------------------------------
-- Users can only see and update their own household.
-- INSERT is handled by the signup trigger (SECURITY DEFINER).
-- No DELETE — soft delete only (set is_archived = true via UPDATE).
-- ---------------------------------------------------------------------------
CREATE POLICY "Users can view own household"
  ON households FOR SELECT
  USING (id = get_my_household_id());

CREATE POLICY "Users can update own household"
  ON households FOR UPDATE
  USING (id = get_my_household_id())
  WITH CHECK (id = get_my_household_id());

-- ---------------------------------------------------------------------------
-- 5. RLS Policies: household_members
-- ---------------------------------------------------------------------------
-- Users can view, add, and update members in their own household.
-- No DELETE — soft delete only.
-- INSERT requires household_id to match the user's household.
-- ---------------------------------------------------------------------------
CREATE POLICY "Users can view own household members"
  ON household_members FOR SELECT
  USING (household_id = get_my_household_id());

CREATE POLICY "Users can add members to own household"
  ON household_members FOR INSERT
  WITH CHECK (household_id = get_my_household_id());

CREATE POLICY "Users can update own household members"
  ON household_members FOR UPDATE
  USING (household_id = get_my_household_id())
  WITH CHECK (household_id = get_my_household_id());

-- ---------------------------------------------------------------------------
-- 6. RLS Policies: global_ingredients
-- ---------------------------------------------------------------------------
-- Read-only for all authenticated users. This is a shared catalog.
-- No INSERT/UPDATE/DELETE from client — managed by admins only.
-- ---------------------------------------------------------------------------
CREATE POLICY "Authenticated users can view global ingredients"
  ON global_ingredients FOR SELECT
  USING (auth.role() = 'authenticated');

-- ---------------------------------------------------------------------------
-- 7. RLS Policies: ingredients
-- ---------------------------------------------------------------------------
-- Per-household ingredient library. Full CRUD within own household.
-- No DELETE — soft delete only.
-- ---------------------------------------------------------------------------
CREATE POLICY "Users can view own household ingredients"
  ON ingredients FOR SELECT
  USING (household_id = get_my_household_id());

CREATE POLICY "Users can add ingredients to own household"
  ON ingredients FOR INSERT
  WITH CHECK (household_id = get_my_household_id());

CREATE POLICY "Users can update own household ingredients"
  ON ingredients FOR UPDATE
  USING (household_id = get_my_household_id())
  WITH CHECK (household_id = get_my_household_id());

-- ---------------------------------------------------------------------------
-- 8. RLS Policies: recipes
-- ---------------------------------------------------------------------------
-- Per-household recipe library. Full CRUD within own household.
-- No DELETE — soft delete only (status = 'archived' or is_archived).
-- ---------------------------------------------------------------------------
CREATE POLICY "Users can view own household recipes"
  ON recipes FOR SELECT
  USING (household_id = get_my_household_id());

CREATE POLICY "Users can add recipes to own household"
  ON recipes FOR INSERT
  WITH CHECK (household_id = get_my_household_id());

CREATE POLICY "Users can update own household recipes"
  ON recipes FOR UPDATE
  USING (household_id = get_my_household_id())
  WITH CHECK (household_id = get_my_household_id());

-- ---------------------------------------------------------------------------
-- 9. RLS Policies: recipe_ingredients
-- ---------------------------------------------------------------------------
-- No direct household_id — check via recipe's household.
-- DELETE is allowed (removing an ingredient from a recipe is a normal edit).
-- ---------------------------------------------------------------------------
CREATE POLICY "Users can view own recipe ingredients"
  ON recipe_ingredients FOR SELECT
  USING (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can add ingredients to own recipes"
  ON recipe_ingredients FOR INSERT
  WITH CHECK (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can update own recipe ingredients"
  ON recipe_ingredients FOR UPDATE
  USING (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ))
  WITH CHECK (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can delete own recipe ingredients"
  ON recipe_ingredients FOR DELETE
  USING (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

-- ---------------------------------------------------------------------------
-- 10. RLS Policies: recipe_steps
-- ---------------------------------------------------------------------------
-- Same pattern as recipe_ingredients — check via recipe's household.
-- DELETE is allowed (removing/reordering steps is a normal edit).
-- ---------------------------------------------------------------------------
CREATE POLICY "Users can view own recipe steps"
  ON recipe_steps FOR SELECT
  USING (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can add steps to own recipes"
  ON recipe_steps FOR INSERT
  WITH CHECK (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can update own recipe steps"
  ON recipe_steps FOR UPDATE
  USING (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ))
  WITH CHECK (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can delete own recipe steps"
  ON recipe_steps FOR DELETE
  USING (recipe_id IN (
    SELECT id FROM recipes WHERE household_id = get_my_household_id()
  ));

-- ---------------------------------------------------------------------------
-- 11. Verification queries
-- ---------------------------------------------------------------------------

-- Check all RLS policies exist
SELECT
  schemaname,
  tablename,
  policyname,
  permissive,
  cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, cmd;

-- Check RLS is enabled on all tables
SELECT
  relname AS table_name,
  relrowsecurity AS rls_enabled
FROM pg_class
WHERE relname IN (
  'households', 'household_members', 'global_ingredients',
  'ingredients', 'recipes', 'recipe_ingredients', 'recipe_steps'
)
ORDER BY relname;

-- Check trigger exists
SELECT
  trigger_name,
  event_manipulation,
  event_object_table,
  action_timing
FROM information_schema.triggers
WHERE trigger_name = 'on_auth_user_created';

-- Check functions exist
SELECT proname, prorettype::regtype
FROM pg_proc
WHERE proname IN ('get_my_household_id', 'handle_new_user')
ORDER BY proname;

-- ---------------------------------------------------------------------------
-- ROLLBACK (uncomment to tear down — use with caution)
-- ---------------------------------------------------------------------------
-- -- Remove trigger
-- DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
--
-- -- Remove all RLS policies
-- DROP POLICY IF EXISTS "Users can view own household" ON households;
-- DROP POLICY IF EXISTS "Users can update own household" ON households;
-- DROP POLICY IF EXISTS "Users can view own household members" ON household_members;
-- DROP POLICY IF EXISTS "Users can add members to own household" ON household_members;
-- DROP POLICY IF EXISTS "Users can update own household members" ON household_members;
-- DROP POLICY IF EXISTS "Authenticated users can view global ingredients" ON global_ingredients;
-- DROP POLICY IF EXISTS "Users can view own household ingredients" ON ingredients;
-- DROP POLICY IF EXISTS "Users can add ingredients to own household" ON ingredients;
-- DROP POLICY IF EXISTS "Users can update own household ingredients" ON ingredients;
-- DROP POLICY IF EXISTS "Users can view own household recipes" ON recipes;
-- DROP POLICY IF EXISTS "Users can add recipes to own household" ON recipes;
-- DROP POLICY IF EXISTS "Users can update own household recipes" ON recipes;
-- DROP POLICY IF EXISTS "Users can view own recipe ingredients" ON recipe_ingredients;
-- DROP POLICY IF EXISTS "Users can add ingredients to own recipes" ON recipe_ingredients;
-- DROP POLICY IF EXISTS "Users can update own recipe ingredients" ON recipe_ingredients;
-- DROP POLICY IF EXISTS "Users can delete own recipe ingredients" ON recipe_ingredients;
-- DROP POLICY IF EXISTS "Users can view own recipe steps" ON recipe_steps;
-- DROP POLICY IF EXISTS "Users can add steps to own recipes" ON recipe_steps;
-- DROP POLICY IF EXISTS "Users can update own recipe steps" ON recipe_steps;
-- DROP POLICY IF EXISTS "Users can delete own recipe steps" ON recipe_steps;
--
-- -- Disable RLS
-- ALTER TABLE households         DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE household_members  DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE global_ingredients DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE ingredients        DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE recipes            DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE recipe_ingredients DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE recipe_steps       DISABLE ROW LEVEL SECURITY;
--
-- -- Remove functions
-- DROP FUNCTION IF EXISTS handle_new_user();
-- DROP FUNCTION IF EXISTS get_my_household_id();
