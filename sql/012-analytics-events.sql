-- ============================================================
-- Plateful — 012: Analytics Events Table
-- Session 15: Boil the Lake
-- ============================================================
-- Append-only event log for tracking user actions.
-- No updated_at — events are immutable once written.
-- ============================================================

-- 1. Create analytics_events table
-- ============================================================

CREATE TABLE IF NOT EXISTS analytics_events (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  household_id  UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  event_type    TEXT NOT NULL,
  event_data    JSONB DEFAULT '{}',
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Index for querying by household + type + time
CREATE INDEX IF NOT EXISTS idx_analytics_events_household_type
  ON analytics_events (household_id, event_type, created_at DESC);

-- 2. RLS Policies
-- ============================================================

ALTER TABLE analytics_events ENABLE ROW LEVEL SECURITY;

-- Users can insert events for their own household
CREATE POLICY analytics_events_insert ON analytics_events
  FOR INSERT TO authenticated
  WITH CHECK (household_id = get_my_household_id());

-- Users can read their own household's events
CREATE POLICY analytics_events_select ON analytics_events
  FOR SELECT TO authenticated
  USING (household_id = get_my_household_id());

-- 3. Verification
-- ============================================================

SELECT
  'analytics_events' AS table_name,
  count(*) AS row_count
FROM analytics_events;

SELECT
  schemaname, policyname
FROM pg_policies
WHERE tablename = 'analytics_events';

-- ============================================================
-- ROLLBACK (uncomment to undo)
-- ============================================================
-- DROP POLICY IF EXISTS analytics_events_insert ON analytics_events;
-- DROP POLICY IF EXISTS analytics_events_select ON analytics_events;
-- DROP INDEX IF EXISTS idx_analytics_events_household_type;
-- DROP TABLE IF EXISTS analytics_events;
