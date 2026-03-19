-- =============================================================================
-- Plateful — Test Auth + RLS Setup
-- =============================================================================
-- Run these AFTER 004-auth-rls-setup.sql AND after signing up a test user.
--
-- HOW TO TEST:
--   1. Run 004-auth-rls-setup.sql in SQL Editor
--   2. Go to Authentication → Users in Supabase Dashboard
--   3. Click "Add user" → create a test user (e.g. test@plateful.com / test1234)
--   4. Come back here and run these queries to verify everything worked
--
-- These queries use the service_role (SQL Editor) so they bypass RLS.
-- They verify that the trigger created the right data.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- TEST 1: Did the signup trigger create a household?
-- ---------------------------------------------------------------------------
-- Expected: 1 row with name like "Test's Kitchen"
SELECT
  h.id AS household_id,
  h.name AS household_name,
  h.created_by,
  u.email
FROM households h
JOIN auth.users u ON u.id = h.created_by
ORDER BY h.created_at DESC
LIMIT 5;

-- ---------------------------------------------------------------------------
-- TEST 2: Did the trigger create a household member?
-- ---------------------------------------------------------------------------
-- Expected: 1 row with is_app_user = true, auth_user_id matching the user
SELECT
  hm.id AS member_id,
  hm.name,
  hm.is_app_user,
  hm.auth_user_id,
  hm.goal,
  hm.household_id
FROM household_members hm
ORDER BY hm.created_at DESC
LIMIT 5;

-- ---------------------------------------------------------------------------
-- TEST 3: Were global ingredients copied to the household?
-- ---------------------------------------------------------------------------
-- Expected: count should match global_ingredients count (~250)
SELECT
  h.name AS household_name,
  count(i.id) AS ingredient_count,
  (SELECT count(*) FROM global_ingredients) AS global_count,
  count(i.id) = (SELECT count(*) FROM global_ingredients) AS counts_match
FROM households h
LEFT JOIN ingredients i ON i.household_id = h.id
GROUP BY h.id, h.name
ORDER BY h.created_at DESC
LIMIT 5;

-- ---------------------------------------------------------------------------
-- TEST 4: Does get_my_household_id() work?
-- ---------------------------------------------------------------------------
-- NOTE: This will return NULL when run from SQL Editor (no auth context).
-- That's EXPECTED. It only works when called from the frontend via
-- Supabase client with a logged-in user.
-- This just verifies the function exists and doesn't error.
SELECT get_my_household_id() AS my_household_id;

-- ---------------------------------------------------------------------------
-- TEST 5: Verify RLS is enabled on all tables
-- ---------------------------------------------------------------------------
-- Expected: all 7 tables show rls_enabled = true
SELECT
  relname AS table_name,
  CASE WHEN relrowsecurity THEN '✅ ENABLED' ELSE '❌ DISABLED' END AS rls_status
FROM pg_class
WHERE relname IN (
  'households', 'household_members', 'global_ingredients',
  'ingredients', 'recipes', 'recipe_ingredients', 'recipe_steps'
)
ORDER BY relname;

-- ---------------------------------------------------------------------------
-- TEST 6: Count all RLS policies (should be 20)
-- ---------------------------------------------------------------------------
-- Breakdown: households(2) + household_members(3) + global_ingredients(1)
--            + ingredients(3) + recipes(3) + recipe_ingredients(4)
--            + recipe_steps(4) = 20
SELECT
  tablename,
  count(*) AS policy_count,
  string_agg(policyname, ', ' ORDER BY policyname) AS policies
FROM pg_policies
WHERE schemaname = 'public'
GROUP BY tablename
ORDER BY tablename;

-- ---------------------------------------------------------------------------
-- TEST 7: Verify the complete signup chain
-- ---------------------------------------------------------------------------
-- This shows the full picture: user → household → member → ingredients
SELECT
  u.email,
  h.name AS household_name,
  hm.name AS member_name,
  hm.is_app_user,
  hm.goal,
  (SELECT count(*) FROM ingredients WHERE household_id = h.id) AS ingredients_seeded
FROM auth.users u
LEFT JOIN households h ON h.created_by = u.id
LEFT JOIN household_members hm ON hm.auth_user_id = u.id AND hm.household_id = h.id
ORDER BY u.created_at DESC
LIMIT 5;

-- ---------------------------------------------------------------------------
-- SUMMARY
-- ---------------------------------------------------------------------------
-- If all tests pass, you should see:
--   ✅ TEST 1: Household created with "[Name]'s Kitchen"
--   ✅ TEST 2: Member created with is_app_user = true
--   ✅ TEST 3: Ingredient count matches global count (~250)
--   ✅ TEST 4: Function exists (returns NULL from SQL Editor — that's OK)
--   ✅ TEST 5: All 7 tables have RLS enabled
--   ✅ TEST 6: 20 RLS policies total across 7 tables
--   ✅ TEST 7: Full chain: user → household → member → ingredients
--
-- NEXT: Test from the frontend with Supabase client to verify RLS
-- actually blocks cross-household access.
