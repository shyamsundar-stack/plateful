-- ============================================================================
-- 010 — Phase 3: Prep Components + Grocery Lists
-- Session 11: Mega-session — Prep + Grocery Engine + Grocery List UI
-- ============================================================================
-- This migration adds:
--   1. prep_components — reusable prep items (manual, per-household)
--   2. prep_component_steps — ordered steps for each prep component
--   3. recipe_prep_components — junction: which recipes use which prep components
--   4. grocery_lists — generated grocery list (snapshot from week plan)
--   5. grocery_items — individual items on a grocery list
--   6. RLS policies for all 5 tables
--   7. Indexes for performance
--
-- Run this in the Supabase SQL Editor.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. prep_components — reusable prep items
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS prep_components (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id   UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  name           TEXT NOT NULL,
  description    TEXT,
  prep_type      TEXT NOT NULL DEFAULT 'chop'
                   CHECK (prep_type IN ('chop', 'cook', 'marinate', 'grind', 'soak', 'other')),
  est_time_min   INT,
  is_archived    BOOLEAN NOT NULL DEFAULT false,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_prep_components_household
  ON prep_components(household_id) WHERE NOT is_archived;

-- Trigger for updated_at
CREATE OR REPLACE TRIGGER trg_prep_components_updated
  BEFORE UPDATE ON prep_components
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

COMMENT ON TABLE prep_components IS 'User-defined reusable prep items (e.g., "Onion Base Gravy"). Auto-detected prep is computed on-the-fly, not stored here.';

-- ---------------------------------------------------------------------------
-- 2. prep_component_steps — ordered steps for prep components
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS prep_component_steps (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prep_component_id   UUID NOT NULL REFERENCES prep_components(id) ON DELETE CASCADE,
  step_number         INT NOT NULL,
  instruction         TEXT NOT NULL,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_prep_component_steps_component
  ON prep_component_steps(prep_component_id);

CREATE OR REPLACE TRIGGER trg_prep_component_steps_updated
  BEFORE UPDATE ON prep_component_steps
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ---------------------------------------------------------------------------
-- 3. recipe_prep_components — junction table
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS recipe_prep_components (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  recipe_id           UUID NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  prep_component_id   UUID NOT NULL REFERENCES prep_components(id) ON DELETE CASCADE,
  notes               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(recipe_id, prep_component_id)
);

CREATE INDEX IF NOT EXISTS idx_recipe_prep_components_recipe
  ON recipe_prep_components(recipe_id);
CREATE INDEX IF NOT EXISTS idx_recipe_prep_components_component
  ON recipe_prep_components(prep_component_id);

-- ---------------------------------------------------------------------------
-- 4. grocery_lists — generated grocery list from a week plan
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS grocery_lists (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id   UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  week_plan_id   UUID NOT NULL REFERENCES week_plans(id) ON DELETE CASCADE,
  share_token    UUID UNIQUE DEFAULT gen_random_uuid(),
  status         TEXT NOT NULL DEFAULT 'active'
                   CHECK (status IN ('active', 'completed', 'archived')),
  notes          TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_grocery_lists_household
  ON grocery_lists(household_id);
CREATE INDEX IF NOT EXISTS idx_grocery_lists_week_plan
  ON grocery_lists(week_plan_id);
CREATE INDEX IF NOT EXISTS idx_grocery_lists_share_token
  ON grocery_lists(share_token);

CREATE OR REPLACE TRIGGER trg_grocery_lists_updated
  BEFORE UPDATE ON grocery_lists
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

COMMENT ON TABLE grocery_lists IS 'A grocery list generated from a week plan. share_token allows unauthenticated read access.';

-- ---------------------------------------------------------------------------
-- 5. grocery_items — individual items on a grocery list
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS grocery_items (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  grocery_list_id   UUID NOT NULL REFERENCES grocery_lists(id) ON DELETE CASCADE,
  ingredient_id     UUID REFERENCES ingredients(id) ON DELETE SET NULL,
  name              TEXT NOT NULL,
  quantity          DECIMAL,
  unit              TEXT,
  category          TEXT NOT NULL DEFAULT 'other'
                      CHECK (category IN (
                        'produce', 'protein', 'dairy', 'grains', 'spices',
                        'oils', 'legumes', 'nuts_seeds', 'condiments', 'frozen', 'other'
                      )),
  is_checked        BOOLEAN NOT NULL DEFAULT false,
  is_already_have   BOOLEAN NOT NULL DEFAULT false,
  sort_order        INT NOT NULL DEFAULT 0,
  recipe_sources    TEXT[],  -- recipe titles that need this item (for reference)
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_grocery_items_list
  ON grocery_items(grocery_list_id);
CREATE INDEX IF NOT EXISTS idx_grocery_items_list_category
  ON grocery_items(grocery_list_id, category);

CREATE OR REPLACE TRIGGER trg_grocery_items_updated
  BEFORE UPDATE ON grocery_items
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

COMMENT ON COLUMN grocery_items.recipe_sources IS 'Array of recipe titles that require this ingredient. Informational — helps shopper understand why it''s on the list.';

-- ============================================================================
-- RLS POLICIES
-- ============================================================================

-- Enable RLS on all new tables
ALTER TABLE prep_components ENABLE ROW LEVEL SECURITY;
ALTER TABLE prep_component_steps ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_prep_components ENABLE ROW LEVEL SECURITY;
ALTER TABLE grocery_lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE grocery_items ENABLE ROW LEVEL SECURITY;

-- ---------- prep_components ----------
CREATE POLICY "prep_components_select" ON prep_components
  FOR SELECT USING (household_id = public.get_my_household_id());

CREATE POLICY "prep_components_insert" ON prep_components
  FOR INSERT WITH CHECK (household_id = public.get_my_household_id());

CREATE POLICY "prep_components_update" ON prep_components
  FOR UPDATE USING (household_id = public.get_my_household_id());

CREATE POLICY "prep_components_delete" ON prep_components
  FOR DELETE USING (household_id = public.get_my_household_id());

-- ---------- prep_component_steps ----------
CREATE POLICY "prep_component_steps_select" ON prep_component_steps
  FOR SELECT USING (
    prep_component_id IN (
      SELECT id FROM prep_components WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "prep_component_steps_insert" ON prep_component_steps
  FOR INSERT WITH CHECK (
    prep_component_id IN (
      SELECT id FROM prep_components WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "prep_component_steps_update" ON prep_component_steps
  FOR UPDATE USING (
    prep_component_id IN (
      SELECT id FROM prep_components WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "prep_component_steps_delete" ON prep_component_steps
  FOR DELETE USING (
    prep_component_id IN (
      SELECT id FROM prep_components WHERE household_id = public.get_my_household_id()
    )
  );

-- ---------- recipe_prep_components ----------
CREATE POLICY "recipe_prep_components_select" ON recipe_prep_components
  FOR SELECT USING (
    recipe_id IN (
      SELECT id FROM recipes WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "recipe_prep_components_insert" ON recipe_prep_components
  FOR INSERT WITH CHECK (
    recipe_id IN (
      SELECT id FROM recipes WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "recipe_prep_components_update" ON recipe_prep_components
  FOR UPDATE USING (
    recipe_id IN (
      SELECT id FROM recipes WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "recipe_prep_components_delete" ON recipe_prep_components
  FOR DELETE USING (
    recipe_id IN (
      SELECT id FROM recipes WHERE household_id = public.get_my_household_id()
    )
  );

-- ---------- grocery_lists ----------
CREATE POLICY "grocery_lists_select" ON grocery_lists
  FOR SELECT USING (household_id = public.get_my_household_id());

CREATE POLICY "grocery_lists_insert" ON grocery_lists
  FOR INSERT WITH CHECK (household_id = public.get_my_household_id());

CREATE POLICY "grocery_lists_update" ON grocery_lists
  FOR UPDATE USING (household_id = public.get_my_household_id());

CREATE POLICY "grocery_lists_delete" ON grocery_lists
  FOR DELETE USING (household_id = public.get_my_household_id());

-- ---------- grocery_items ----------
CREATE POLICY "grocery_items_select" ON grocery_items
  FOR SELECT USING (
    grocery_list_id IN (
      SELECT id FROM grocery_lists WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "grocery_items_insert" ON grocery_items
  FOR INSERT WITH CHECK (
    grocery_list_id IN (
      SELECT id FROM grocery_lists WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "grocery_items_update" ON grocery_items
  FOR UPDATE USING (
    grocery_list_id IN (
      SELECT id FROM grocery_lists WHERE household_id = public.get_my_household_id()
    )
  );

CREATE POLICY "grocery_items_delete" ON grocery_items
  FOR DELETE USING (
    grocery_list_id IN (
      SELECT id FROM grocery_lists WHERE household_id = public.get_my_household_id()
    )
  );

-- ---------- grocery_lists: public read via share_token ----------
-- This uses a SECURITY DEFINER function to allow unauthenticated reads
CREATE OR REPLACE FUNCTION get_grocery_list_by_token(p_token UUID)
RETURNS TABLE (
  id UUID,
  status TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
STABLE
AS $$
  SELECT gl.id, gl.status, gl.notes, gl.created_at
  FROM public.grocery_lists gl
  WHERE gl.share_token = p_token
  LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION get_grocery_items_by_token(p_token UUID)
RETURNS TABLE (
  id UUID,
  name TEXT,
  quantity DECIMAL,
  unit TEXT,
  category TEXT,
  is_checked BOOLEAN,
  is_already_have BOOLEAN,
  sort_order INT,
  recipe_sources TEXT[]
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
STABLE
AS $$
  SELECT gi.id, gi.name, gi.quantity, gi.unit, gi.category,
         gi.is_checked, gi.is_already_have, gi.sort_order, gi.recipe_sources
  FROM public.grocery_items gi
  JOIN public.grocery_lists gl ON gi.grocery_list_id = gl.id
  WHERE gl.share_token = p_token
  ORDER BY gi.category, gi.sort_order, gi.name;
$$;

GRANT EXECUTE ON FUNCTION get_grocery_list_by_token TO anon, authenticated;
GRANT EXECUTE ON FUNCTION get_grocery_items_by_token TO anon, authenticated;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT 'prep_components' AS table_name, count(*) FROM prep_components
UNION ALL
SELECT 'prep_component_steps', count(*) FROM prep_component_steps
UNION ALL
SELECT 'recipe_prep_components', count(*) FROM recipe_prep_components
UNION ALL
SELECT 'grocery_lists', count(*) FROM grocery_lists
UNION ALL
SELECT 'grocery_items', count(*) FROM grocery_items;

-- Check RLS is enabled
SELECT tablename, rowsecurity
FROM pg_tables
WHERE tablename IN (
  'prep_components', 'prep_component_steps', 'recipe_prep_components',
  'grocery_lists', 'grocery_items'
);

-- Check policies count
SELECT tablename, count(*) AS policy_count
FROM pg_policies
WHERE tablename IN (
  'prep_components', 'prep_component_steps', 'recipe_prep_components',
  'grocery_lists', 'grocery_items'
)
GROUP BY tablename
ORDER BY tablename;

-- ============================================================================
-- ROLLBACK (uncomment to remove)
-- ============================================================================
-- DROP FUNCTION IF EXISTS get_grocery_items_by_token;
-- DROP FUNCTION IF EXISTS get_grocery_list_by_token;
-- DROP TABLE IF EXISTS grocery_items;
-- DROP TABLE IF EXISTS grocery_lists;
-- DROP TABLE IF EXISTS recipe_prep_components;
-- DROP TABLE IF EXISTS prep_component_steps;
-- DROP TABLE IF EXISTS prep_components;
