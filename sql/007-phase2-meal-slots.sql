-- =============================================================================
-- Plateful — Phase 2: Meal Slot Data Model + Dietary Prefs
-- =============================================================================
-- Run this in Supabase SQL Editor (single execution, top to bottom).
-- Creates 5 new tables, indexes, RLS policies, helper functions, and triggers.
-- Depends on: Phase 1 tables (households, household_members, recipes, ingredients)
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. week_plans — weekly planning container per household
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS week_plans (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  household_id  UUID NOT NULL REFERENCES households(id) ON DELETE RESTRICT,
  start_date    DATE NOT NULL,
  status        TEXT NOT NULL DEFAULT 'draft',
  notes         TEXT,
  is_archived   BOOLEAN NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_week_plan_status
    CHECK (status IN ('draft', 'finalized', 'archived')),
  CONSTRAINT chk_start_date_is_monday
    CHECK (EXTRACT(ISODOW FROM start_date) = 1),
  CONSTRAINT uq_household_week
    UNIQUE (household_id, start_date)
);

COMMENT ON TABLE week_plans IS 'Container for a household weekly meal plan. start_date must be a Monday.';
COMMENT ON COLUMN week_plans.status IS 'draft = being built, finalized = recipes assigned, archived = past/discarded';

-- ---------------------------------------------------------------------------
-- 2. meal_slots — one slot per day × meal type within a week plan
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS meal_slots (
  id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  week_plan_id        UUID NOT NULL REFERENCES week_plans(id) ON DELETE CASCADE,
  slot_date           DATE NOT NULL,
  meal_type           TEXT NOT NULL,
  meal_mode           TEXT NOT NULL DEFAULT 'cook',
  recipe_id           UUID REFERENCES recipes(id) ON DELETE SET NULL,
  leftover_source_id  UUID REFERENCES meal_slots(id) ON DELETE SET NULL,
  servings_override   INT,
  is_locked           BOOLEAN NOT NULL DEFAULT false,
  notes               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_meal_type
    CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')),
  CONSTRAINT chk_meal_mode
    CHECK (meal_mode IN ('cook', 'eat_outside', 'leftover', 'skip')),
  CONSTRAINT chk_no_recipe_for_skip_outside
    CHECK (
      (meal_mode IN ('eat_outside', 'skip') AND recipe_id IS NULL AND leftover_source_id IS NULL)
      OR (meal_mode = 'leftover' AND recipe_id IS NULL)
      OR (meal_mode = 'cook' AND leftover_source_id IS NULL)
    ),
  CONSTRAINT chk_servings_positive
    CHECK (servings_override IS NULL OR servings_override > 0),
  CONSTRAINT uq_slot_per_day_meal
    UNIQUE (week_plan_id, slot_date, meal_type)
);

COMMENT ON TABLE meal_slots IS 'One meal in the weekly grid. 7 days × 4 types = 28 slots per week.';
COMMENT ON COLUMN meal_slots.meal_mode IS 'cook = needs recipe, eat_outside = no grocery, leftover = links to source, skip = nothing';
COMMENT ON COLUMN meal_slots.leftover_source_id IS 'Self-reference to the meal_slot this is a leftover of';
COMMENT ON COLUMN meal_slots.is_locked IS 'If true, copy this slot forward when creating next week plan';

-- ---------------------------------------------------------------------------
-- 3. meal_slot_participants — who eats each meal
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS meal_slot_participants (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  meal_slot_id     UUID NOT NULL REFERENCES meal_slots(id) ON DELETE CASCADE,
  member_id        UUID NOT NULL REFERENCES household_members(id) ON DELETE CASCADE,
  is_participating BOOLEAN NOT NULL DEFAULT true,
  serving_factor   DECIMAL NOT NULL DEFAULT 1.0,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT uq_participant_per_slot
    UNIQUE (meal_slot_id, member_id),
  CONSTRAINT chk_serving_factor_positive
    CHECK (serving_factor > 0)
);

COMMENT ON TABLE meal_slot_participants IS 'Per-member participation for each meal slot. Drives grocery scaling.';
COMMENT ON COLUMN meal_slot_participants.serving_factor IS '1.0 = standard serving, 0.5 = half, 1.5 = extra';

-- ---------------------------------------------------------------------------
-- 4. member_dietary_prefs — structured dietary restrictions per member
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS member_dietary_prefs (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  member_id       UUID NOT NULL REFERENCES household_members(id) ON DELETE CASCADE,
  pref_type       TEXT NOT NULL,
  ingredient_id   UUID REFERENCES ingredients(id) ON DELETE CASCADE,
  ingredient_name TEXT,
  notes           TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_pref_type
    CHECK (pref_type IN ('allergy', 'hard_no', 'dislike', 'prefer')),
  CONSTRAINT chk_has_ingredient_ref
    CHECK (ingredient_id IS NOT NULL OR ingredient_name IS NOT NULL)
);

COMMENT ON TABLE member_dietary_prefs IS 'Structured dietary restrictions per household member.';
COMMENT ON COLUMN member_dietary_prefs.pref_type IS 'allergy = medical, hard_no = never, dislike = avoid, prefer = boost';

-- ---------------------------------------------------------------------------
-- 5. member_participation_defaults — default meal participation patterns
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS member_participation_defaults (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  member_id        UUID NOT NULL REFERENCES household_members(id) ON DELETE CASCADE,
  meal_type        TEXT NOT NULL,
  day_of_week      INT,
  is_participating BOOLEAN NOT NULL DEFAULT true,
  serving_factor   DECIMAL NOT NULL DEFAULT 1.0,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_default_meal_type
    CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')),
  CONSTRAINT chk_day_of_week
    CHECK (day_of_week IS NULL OR day_of_week BETWEEN 1 AND 7),
  CONSTRAINT chk_default_serving_factor
    CHECK (serving_factor > 0),
  CONSTRAINT uq_member_meal_day_default
    UNIQUE NULLS NOT DISTINCT (member_id, meal_type, day_of_week)
);

COMMENT ON TABLE member_participation_defaults IS 'Default participation patterns. day_of_week NULL = every day.';
COMMENT ON COLUMN member_participation_defaults.day_of_week IS 'ISO day: 1=Monday, 7=Sunday. NULL = applies every day.';

-- ---------------------------------------------------------------------------
-- 6. Indexes
-- ---------------------------------------------------------------------------

-- week_plans
CREATE INDEX IF NOT EXISTS idx_week_plans_household
  ON week_plans(household_id);
CREATE INDEX IF NOT EXISTS idx_week_plans_household_date
  ON week_plans(household_id, start_date DESC);

-- meal_slots
CREATE INDEX IF NOT EXISTS idx_meal_slots_week_plan
  ON meal_slots(week_plan_id);
CREATE INDEX IF NOT EXISTS idx_meal_slots_recipe
  ON meal_slots(recipe_id) WHERE recipe_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_meal_slots_leftover_source
  ON meal_slots(leftover_source_id) WHERE leftover_source_id IS NOT NULL;

-- meal_slot_participants
CREATE INDEX IF NOT EXISTS idx_meal_slot_participants_slot
  ON meal_slot_participants(meal_slot_id);
CREATE INDEX IF NOT EXISTS idx_meal_slot_participants_member
  ON meal_slot_participants(member_id);

-- member_dietary_prefs
CREATE INDEX IF NOT EXISTS idx_dietary_prefs_member
  ON member_dietary_prefs(member_id);
CREATE INDEX IF NOT EXISTS idx_dietary_prefs_ingredient
  ON member_dietary_prefs(ingredient_id) WHERE ingredient_id IS NOT NULL;

-- member_participation_defaults
CREATE INDEX IF NOT EXISTS idx_participation_defaults_member
  ON member_participation_defaults(member_id);

-- ---------------------------------------------------------------------------
-- 7. Updated_at triggers (reuse existing update_updated_at function from Phase 1)
-- ---------------------------------------------------------------------------
CREATE TRIGGER trg_week_plans_updated_at
  BEFORE UPDATE ON week_plans
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_meal_slots_updated_at
  BEFORE UPDATE ON meal_slots
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_member_dietary_prefs_updated_at
  BEFORE UPDATE ON member_dietary_prefs
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_member_participation_defaults_updated_at
  BEFORE UPDATE ON member_participation_defaults
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- meal_slot_participants intentionally has no updated_at (toggle table)

-- ---------------------------------------------------------------------------
-- 8. RLS Policies — Enable RLS on all 5 new tables
-- ---------------------------------------------------------------------------

ALTER TABLE week_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE meal_slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE meal_slot_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE member_dietary_prefs ENABLE ROW LEVEL SECURITY;
ALTER TABLE member_participation_defaults ENABLE ROW LEVEL SECURITY;

-- ── week_plans (has household_id — direct comparison) ──

CREATE POLICY "Users can view own household week plans"
  ON week_plans FOR SELECT
  USING (household_id = get_my_household_id());

CREATE POLICY "Users can create week plans in own household"
  ON week_plans FOR INSERT
  WITH CHECK (household_id = get_my_household_id());

CREATE POLICY "Users can update own household week plans"
  ON week_plans FOR UPDATE
  USING (household_id = get_my_household_id())
  WITH CHECK (household_id = get_my_household_id());

-- ── meal_slots (no household_id — check via week_plans) ──

CREATE POLICY "Users can view own meal slots"
  ON meal_slots FOR SELECT
  USING (week_plan_id IN (
    SELECT id FROM week_plans WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can create meal slots in own plans"
  ON meal_slots FOR INSERT
  WITH CHECK (week_plan_id IN (
    SELECT id FROM week_plans WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can update own meal slots"
  ON meal_slots FOR UPDATE
  USING (week_plan_id IN (
    SELECT id FROM week_plans WHERE household_id = get_my_household_id()
  ))
  WITH CHECK (week_plan_id IN (
    SELECT id FROM week_plans WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can delete own meal slots"
  ON meal_slots FOR DELETE
  USING (week_plan_id IN (
    SELECT id FROM week_plans WHERE household_id = get_my_household_id()
  ));

-- ── meal_slot_participants (no household_id — check via meal_slots → week_plans) ──

CREATE POLICY "Users can view own meal slot participants"
  ON meal_slot_participants FOR SELECT
  USING (meal_slot_id IN (
    SELECT id FROM meal_slots WHERE week_plan_id IN (
      SELECT id FROM week_plans WHERE household_id = get_my_household_id()
    )
  ));

CREATE POLICY "Users can create meal slot participants in own plans"
  ON meal_slot_participants FOR INSERT
  WITH CHECK (meal_slot_id IN (
    SELECT id FROM meal_slots WHERE week_plan_id IN (
      SELECT id FROM week_plans WHERE household_id = get_my_household_id()
    )
  ));

CREATE POLICY "Users can update own meal slot participants"
  ON meal_slot_participants FOR UPDATE
  USING (meal_slot_id IN (
    SELECT id FROM meal_slots WHERE week_plan_id IN (
      SELECT id FROM week_plans WHERE household_id = get_my_household_id()
    )
  ))
  WITH CHECK (meal_slot_id IN (
    SELECT id FROM meal_slots WHERE week_plan_id IN (
      SELECT id FROM week_plans WHERE household_id = get_my_household_id()
    )
  ));

CREATE POLICY "Users can delete own meal slot participants"
  ON meal_slot_participants FOR DELETE
  USING (meal_slot_id IN (
    SELECT id FROM meal_slots WHERE week_plan_id IN (
      SELECT id FROM week_plans WHERE household_id = get_my_household_id()
    )
  ));

-- ── member_dietary_prefs (no household_id — check via household_members) ──

CREATE POLICY "Users can view own member dietary prefs"
  ON member_dietary_prefs FOR SELECT
  USING (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can create dietary prefs for own members"
  ON member_dietary_prefs FOR INSERT
  WITH CHECK (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can update own member dietary prefs"
  ON member_dietary_prefs FOR UPDATE
  USING (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ))
  WITH CHECK (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can delete own member dietary prefs"
  ON member_dietary_prefs FOR DELETE
  USING (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

-- ── member_participation_defaults (same pattern as dietary prefs) ──

CREATE POLICY "Users can view own participation defaults"
  ON member_participation_defaults FOR SELECT
  USING (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can create participation defaults for own members"
  ON member_participation_defaults FOR INSERT
  WITH CHECK (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can update own participation defaults"
  ON member_participation_defaults FOR UPDATE
  USING (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ))
  WITH CHECK (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

CREATE POLICY "Users can delete own participation defaults"
  ON member_participation_defaults FOR DELETE
  USING (member_id IN (
    SELECT id FROM household_members WHERE household_id = get_my_household_id()
  ));

-- ---------------------------------------------------------------------------
-- 9. Helper functions
-- ---------------------------------------------------------------------------

-- Populate participants for a single meal slot from defaults
CREATE OR REPLACE FUNCTION populate_meal_slot_participants(p_meal_slot_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_household_id UUID;
  v_meal_type TEXT;
  v_day_of_week INT;
  v_count INT := 0;
BEGIN
  -- Get the slot's context
  SELECT wp.household_id, ms.meal_type, EXTRACT(ISODOW FROM ms.slot_date)::INT
  INTO v_household_id, v_meal_type, v_day_of_week
  FROM public.meal_slots ms
  JOIN public.week_plans wp ON wp.id = ms.week_plan_id
  WHERE ms.id = p_meal_slot_id;

  IF v_household_id IS NULL THEN
    RETURN 0;
  END IF;

  -- Insert a participant row for every non-archived member
  -- Priority: day-specific default > meal-type-only default > default true/1.0
  INSERT INTO public.meal_slot_participants (meal_slot_id, member_id, is_participating, serving_factor)
  SELECT
    p_meal_slot_id,
    hm.id,
    COALESCE(
      day_specific.is_participating,
      meal_only.is_participating,
      true
    ),
    COALESCE(
      day_specific.serving_factor,
      meal_only.serving_factor,
      1.0
    )
  FROM public.household_members hm
  LEFT JOIN public.member_participation_defaults day_specific
    ON day_specific.member_id = hm.id
    AND day_specific.meal_type = v_meal_type
    AND day_specific.day_of_week = v_day_of_week
  LEFT JOIN public.member_participation_defaults meal_only
    ON meal_only.member_id = hm.id
    AND meal_only.meal_type = v_meal_type
    AND meal_only.day_of_week IS NULL
  WHERE hm.household_id = v_household_id
    AND hm.is_archived = false
  ON CONFLICT (meal_slot_id, member_id) DO NOTHING;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN v_count;
END;
$$;

COMMENT ON FUNCTION populate_meal_slot_participants IS 'Auto-populate participants for a meal slot from member defaults.';

-- Create all 28 meal slots for a week plan + auto-populate participants
CREATE OR REPLACE FUNCTION create_week_plan_slots(p_week_plan_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_start_date DATE;
  v_day DATE;
  v_meal_type TEXT;
  v_slot_id UUID;
  v_total INT := 0;
  v_slot_count INT;
  meal_types TEXT[] := ARRAY['breakfast', 'lunch', 'dinner', 'snack'];
BEGIN
  SELECT start_date INTO v_start_date
  FROM public.week_plans
  WHERE id = p_week_plan_id;

  IF v_start_date IS NULL THEN
    RETURN 0;
  END IF;

  -- Create 7 days × 4 meal types = 28 slots
  FOR i IN 0..6 LOOP
    v_day := v_start_date + i;
    FOREACH v_meal_type IN ARRAY meal_types LOOP
      INSERT INTO public.meal_slots (week_plan_id, slot_date, meal_type)
      VALUES (p_week_plan_id, v_day, v_meal_type)
      ON CONFLICT (week_plan_id, slot_date, meal_type) DO NOTHING
      RETURNING id INTO v_slot_id;

      -- Auto-populate participants for this slot (only if slot was inserted)
      IF v_slot_id IS NOT NULL THEN
        SELECT public.populate_meal_slot_participants(v_slot_id) INTO v_slot_count;
        v_total := v_total + v_slot_count;
      END IF;
    END LOOP;
  END LOOP;

  RETURN v_total;
END;
$$;

COMMENT ON FUNCTION create_week_plan_slots IS 'Create 28 meal slots for a week plan and auto-populate participants from defaults.';

-- ---------------------------------------------------------------------------
-- 10. Verification queries
-- ---------------------------------------------------------------------------

-- Table row counts (should all be 0 for fresh install)
SELECT 'week_plans' AS table_name, count(*) AS row_count FROM week_plans
UNION ALL SELECT 'meal_slots', count(*) FROM meal_slots
UNION ALL SELECT 'meal_slot_participants', count(*) FROM meal_slot_participants
UNION ALL SELECT 'member_dietary_prefs', count(*) FROM member_dietary_prefs
UNION ALL SELECT 'member_participation_defaults', count(*) FROM member_participation_defaults;

-- RLS policy count (should be 19: 3 + 4 + 4 + 4 + 4)
SELECT count(*) AS policy_count
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('week_plans', 'meal_slots', 'meal_slot_participants',
                     'member_dietary_prefs', 'member_participation_defaults');

-- Functions exist
SELECT proname, prorettype::regtype AS return_type
FROM pg_proc
WHERE proname IN ('populate_meal_slot_participants', 'create_week_plan_slots')
ORDER BY proname;

-- Index count
SELECT count(*) AS index_count
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename IN ('week_plans', 'meal_slots', 'meal_slot_participants',
                     'member_dietary_prefs', 'member_participation_defaults');

-- ---------------------------------------------------------------------------
-- 11. Test: Create a week plan and verify slots + participants
-- ---------------------------------------------------------------------------
-- Uncomment and run AFTER the main migration to test:

-- -- Get your household_id
-- SELECT get_my_household_id();
--
-- -- Create a test week plan (next Monday)
-- INSERT INTO week_plans (household_id, start_date, status)
-- VALUES (
--   get_my_household_id(),
--   date_trunc('week', CURRENT_DATE + INTERVAL '7 days')::date,
--   'draft'
-- )
-- RETURNING id, start_date;
--
-- -- Create 28 slots + participants (replace UUID with the returned id above)
-- SELECT create_week_plan_slots('YOUR-WEEK-PLAN-ID-HERE');
--
-- -- Verify: should be 28 slots
-- SELECT count(*) AS slot_count FROM meal_slots
-- WHERE week_plan_id = 'YOUR-WEEK-PLAN-ID-HERE';
--
-- -- Verify: should be 56 participants (2 members × 28 slots)
-- SELECT count(*) AS participant_count FROM meal_slot_participants
-- WHERE meal_slot_id IN (
--   SELECT id FROM meal_slots WHERE week_plan_id = 'YOUR-WEEK-PLAN-ID-HERE'
-- );
--
-- -- View the grid
-- SELECT ms.slot_date, ms.meal_type, ms.meal_mode,
--        msp.member_id, hm.name, msp.is_participating, msp.serving_factor
-- FROM meal_slots ms
-- JOIN meal_slot_participants msp ON msp.meal_slot_id = ms.id
-- JOIN household_members hm ON hm.id = msp.member_id
-- WHERE ms.week_plan_id = 'YOUR-WEEK-PLAN-ID-HERE'
-- ORDER BY ms.slot_date, ms.meal_type, hm.name;

-- ---------------------------------------------------------------------------
-- 12. Rollback (uncomment to undo — USE WITH CAUTION)
-- ---------------------------------------------------------------------------

-- DROP FUNCTION IF EXISTS create_week_plan_slots(UUID);
-- DROP FUNCTION IF EXISTS populate_meal_slot_participants(UUID);
-- DROP TRIGGER IF EXISTS trg_member_participation_defaults_updated_at ON member_participation_defaults;
-- DROP TRIGGER IF EXISTS trg_member_dietary_prefs_updated_at ON member_dietary_prefs;
-- DROP TRIGGER IF EXISTS trg_meal_slots_updated_at ON meal_slots;
-- DROP TRIGGER IF EXISTS trg_week_plans_updated_at ON week_plans;
-- DROP TABLE IF EXISTS member_participation_defaults CASCADE;
-- DROP TABLE IF EXISTS member_dietary_prefs CASCADE;
-- DROP TABLE IF EXISTS meal_slot_participants CASCADE;
-- DROP TABLE IF EXISTS meal_slots CASCADE;
-- DROP TABLE IF EXISTS week_plans CASCADE;
