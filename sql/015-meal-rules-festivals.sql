-- =============================================================================
-- Plateful — Phase 5 Migration 015: Meal Rules + Festival Calendar
-- =============================================================================
-- Conditional rules engine: IF day/meal_type/date/festival THEN dietary/cuisine action
-- Festival calendar: pre-seeded Hindu/Jain festivals for 2026-2027
--
-- Run AFTER 014-global-recipes.sql
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. meal_rules — per-household conditional preference rules
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS meal_rules (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id    UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  member_id       UUID REFERENCES household_members(id) ON DELETE CASCADE,
  rule_name       TEXT NOT NULL,
  condition_type  TEXT NOT NULL,
  condition_value TEXT NOT NULL,
  action_type     TEXT NOT NULL,
  action_value    TEXT NOT NULL,
  is_active       BOOLEAN NOT NULL DEFAULT true,
  priority        INT NOT NULL DEFAULT 0,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_mr_condition_type
    CHECK (condition_type IN ('day_of_week', 'meal_type', 'date_range', 'festival')),
  CONSTRAINT chk_mr_action_type
    CHECK (action_type IN ('set_dietary_mode', 'prefer_cuisine', 'exclude_ingredient', 'include_tag'))
);

COMMENT ON TABLE meal_rules IS 'Conditional meal preference rules. IF condition THEN action. member_id NULL = applies to all members.';
COMMENT ON COLUMN meal_rules.condition_type IS 'day_of_week: "monday","thursday"; meal_type: "dinner"; date_range: "2026-03-01|2026-03-15"; festival: "navratri"';
COMMENT ON COLUMN meal_rules.action_type IS 'set_dietary_mode: "vegetarian"; prefer_cuisine: "arabian"; exclude_ingredient: "onion"; include_tag: "one-pot"';
COMMENT ON COLUMN meal_rules.priority IS 'Higher priority rules are evaluated first. Rules with same priority are all applied.';

-- ---------------------------------------------------------------------------
-- 2. festival_calendar — shared festival dates (no household_id)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS festival_calendar (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name            TEXT NOT NULL,
  display_name    TEXT NOT NULL,
  tradition       TEXT NOT NULL DEFAULT 'hindu',
  start_date      DATE NOT NULL,
  end_date        DATE NOT NULL,
  dietary_mode    TEXT,
  description     TEXT,
  year            INT NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_fc_tradition
    CHECK (tradition IN ('hindu', 'jain', 'sikh', 'buddhist', 'muslim', 'christian', 'general')),
  CONSTRAINT chk_fc_dietary_mode
    CHECK (dietary_mode IS NULL OR dietary_mode IN ('vegetarian', 'vegan')),
  CONSTRAINT chk_fc_dates
    CHECK (end_date >= start_date)
);

COMMENT ON TABLE festival_calendar IS 'Shared festival calendar. No household_id — dates are universal. Linked to meal_rules via condition_type=festival.';

-- ---------------------------------------------------------------------------
-- 3. Indexes
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_meal_rules_household
  ON meal_rules(household_id);

CREATE INDEX IF NOT EXISTS idx_meal_rules_active
  ON meal_rules(household_id, is_active) WHERE is_active = true;

CREATE INDEX IF NOT EXISTS idx_meal_rules_member
  ON meal_rules(member_id) WHERE member_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_festival_calendar_dates
  ON festival_calendar(start_date, end_date);

CREATE INDEX IF NOT EXISTS idx_festival_calendar_year
  ON festival_calendar(year, tradition);

CREATE INDEX IF NOT EXISTS idx_festival_calendar_name
  ON festival_calendar(name);

-- ---------------------------------------------------------------------------
-- 4. updated_at trigger for meal_rules
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION update_meal_rules_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_meal_rules_updated_at ON meal_rules;
CREATE TRIGGER trg_meal_rules_updated_at
  BEFORE UPDATE ON meal_rules
  FOR EACH ROW
  EXECUTE FUNCTION update_meal_rules_updated_at();

-- ---------------------------------------------------------------------------
-- 5. RLS Policies
-- ---------------------------------------------------------------------------
ALTER TABLE meal_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE festival_calendar ENABLE ROW LEVEL SECURITY;

-- meal_rules: household-scoped CRUD
DROP POLICY IF EXISTS meal_rules_select ON meal_rules;
DROP POLICY IF EXISTS meal_rules_insert ON meal_rules;
DROP POLICY IF EXISTS meal_rules_update ON meal_rules;
DROP POLICY IF EXISTS meal_rules_delete ON meal_rules;

CREATE POLICY meal_rules_select
  ON meal_rules FOR SELECT
  USING (household_id = get_my_household_id());

CREATE POLICY meal_rules_insert
  ON meal_rules FOR INSERT
  WITH CHECK (household_id = get_my_household_id());

CREATE POLICY meal_rules_update
  ON meal_rules FOR UPDATE
  USING (household_id = get_my_household_id());

CREATE POLICY meal_rules_delete
  ON meal_rules FOR DELETE
  USING (household_id = get_my_household_id());

-- festival_calendar: read-only for all authenticated users
DROP POLICY IF EXISTS festival_calendar_select ON festival_calendar;

CREATE POLICY festival_calendar_select
  ON festival_calendar FOR SELECT
  TO authenticated
  USING (true);

-- ---------------------------------------------------------------------------
-- 6. Seed Festival Data — Major Hindu Festivals 2026-2027
-- ---------------------------------------------------------------------------
-- Note: Dates are approximate for lunar calendar festivals.
-- Sources: drikpanchang.com, iskcondesiretree.com

-- 2026 Festivals
INSERT INTO festival_calendar (name, display_name, tradition, start_date, end_date, dietary_mode, description, year) VALUES

-- Makar Sankranti (fixed solar calendar)
('makar_sankranti', 'Makar Sankranti', 'hindu', '2026-01-14', '2026-01-14', 'vegetarian', 'Harvest festival marking the sun''s transit into Capricorn. Til-gur sweets.', 2026),

-- Maha Shivaratri
('maha_shivaratri', 'Maha Shivaratri', 'hindu', '2026-02-15', '2026-02-15', 'vegetarian', 'Night of Lord Shiva. Strict fasting observed by devotees.', 2026),

-- Holi
('holi', 'Holi', 'hindu', '2026-03-03', '2026-03-04', NULL, 'Festival of colors. Sweets and festive foods.', 2026),

-- Ugadi / Gudi Padwa (Hindu New Year)
('ugadi', 'Ugadi / Gudi Padwa', 'hindu', '2026-03-19', '2026-03-19', 'vegetarian', 'Telugu/Kannada/Marathi New Year. Special meals with 6 tastes.', 2026),

-- Ram Navami
('ram_navami', 'Ram Navami', 'hindu', '2026-03-28', '2026-03-28', 'vegetarian', 'Birthday of Lord Rama. Fasting and prayers.', 2026),

-- Chaitra Navratri (Spring)
('chaitra_navratri', 'Chaitra Navratri', 'hindu', '2026-03-19', '2026-03-28', 'vegetarian', '9-day spring Navratri. Strict vegetarian/sattvic diet.', 2026),

-- Akshaya Tritiya
('akshaya_tritiya', 'Akshaya Tritiya', 'hindu', '2026-04-26', '2026-04-26', 'vegetarian', 'Auspicious day for new beginnings. Vegetarian meals.', 2026),

-- Buddha Purnima
('buddha_purnima', 'Buddha Purnima', 'buddhist', '2026-05-12', '2026-05-12', 'vegetarian', 'Birthday of Lord Buddha. Many observe vegetarianism.', 2026),

-- Rath Yatra
('rath_yatra', 'Rath Yatra', 'hindu', '2026-06-25', '2026-06-25', 'vegetarian', 'Chariot festival of Lord Jagannath. Famous prasad tradition.', 2026),

-- Guru Purnima
('guru_purnima', 'Guru Purnima', 'hindu', '2026-07-11', '2026-07-11', 'vegetarian', 'Day to honor teachers and spiritual guides.', 2026),

-- Shravan Month (entire month is considered auspicious)
('shravan', 'Shravan Month', 'hindu', '2026-07-18', '2026-08-16', 'vegetarian', 'Holy month of Shravan. Many observe strict vegetarianism all month. Mondays especially sacred.', 2026),

-- Janmashtami
('janmashtami', 'Janmashtami', 'hindu', '2026-08-15', '2026-08-15', 'vegetarian', 'Birthday of Lord Krishna. Fasting until midnight, then festive meal.', 2026),

-- Ganesh Chaturthi
('ganesh_chaturthi', 'Ganesh Chaturthi', 'hindu', '2026-08-27', '2026-09-06', 'vegetarian', '10-day Ganesh festival. Modak and vegetarian feasts.', 2026),

-- Onam (Kerala harvest festival)
('onam', 'Onam', 'hindu', '2026-09-04', '2026-09-04', 'vegetarian', 'Kerala harvest festival. Grand vegetarian Onam Sadya feast.', 2026),

-- Sharad Navratri (Autumn — the big one)
('sharad_navratri', 'Sharad Navratri', 'hindu', '2026-10-01', '2026-10-10', 'vegetarian', '9-day autumn Navratri. Strict vegetarian/sattvic diet. No onion, garlic for many families.', 2026),

-- Dussehra
('dussehra', 'Dussehra / Vijayadashami', 'hindu', '2026-10-11', '2026-10-11', NULL, 'Victory of good over evil. Festive meals.', 2026),

-- Karwa Chauth
('karwa_chauth', 'Karwa Chauth', 'hindu', '2026-10-25', '2026-10-25', 'vegetarian', 'Married women fast from sunrise to moonrise. Special evening meal.', 2026),

-- Diwali
('diwali', 'Diwali', 'hindu', '2026-10-31', '2026-11-02', 'vegetarian', 'Festival of lights. Sweets, snacks, and festive vegetarian meals.', 2026),

-- Chhath Puja
('chhath_puja', 'Chhath Puja', 'hindu', '2026-11-06', '2026-11-07', 'vegetarian', 'Sun worship festival. Strict fasting and special prasad.', 2026),

-- Pongal (Tamil harvest festival — falls in January 2027)
('pongal', 'Pongal', 'hindu', '2027-01-14', '2027-01-17', 'vegetarian', 'Tamil harvest festival. Pongal rice dish and vegetarian celebrations.', 2027),

-- 2027 Sharad Navratri (approximate)
('sharad_navratri_2027', 'Sharad Navratri 2027', 'hindu', '2027-09-21', '2027-09-30', 'vegetarian', '9-day autumn Navratri 2027. Strict vegetarian/sattvic diet.', 2027),

-- Jain festivals
('paryushana', 'Paryushana', 'jain', '2026-08-22', '2026-08-30', 'vegan', '8-day Jain festival of austerity. Strict fasting, no root vegetables, no onion/garlic.', 2026),

('mahavir_jayanti', 'Mahavir Jayanti', 'jain', '2026-03-29', '2026-03-29', 'vegetarian', 'Birthday of Lord Mahavira. Vegetarian meals.', 2026),

-- Sikh festivals
('guru_nanak_jayanti', 'Guru Nanak Jayanti', 'sikh', '2026-11-05', '2026-11-05', 'vegetarian', 'Birthday of Guru Nanak. Langar (community vegetarian meal).', 2026)

ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------------------
-- Verification
-- ---------------------------------------------------------------------------
SELECT 'meal_rules' AS table_name, count(*) AS row_count FROM meal_rules;
SELECT 'festival_calendar' AS table_name, count(*) AS row_count FROM festival_calendar;
SELECT tradition, count(*) AS count FROM festival_calendar GROUP BY tradition ORDER BY count DESC;

-- ---------------------------------------------------------------------------
-- Rollback (uncomment if needed)
-- ---------------------------------------------------------------------------
-- DROP TABLE IF EXISTS meal_rules CASCADE;
-- DROP TABLE IF EXISTS festival_calendar CASCADE;
-- DROP FUNCTION IF EXISTS update_meal_rules_updated_at();
