# Plateful — Claude Code Project Instructions

## WHAT THIS PROJECT IS
Plateful (formerly MealPlanr) is a household meal planning web app that suggests balanced weekly meals, optimizes batch prep for weekends, and auto-generates smart grocery lists. Built for Indian/Asian food preferences with high-protein bias. Personal use first, commercial later.

## MY ROLE (SHYAM)
I am the business owner. I am NOT a developer. I am learning development as I build this project. Explain everything clearly. Give me copy-paste-ready code and step-by-step instructions.

## CURRENT FOCUS — DO NOT EXPAND SCOPE
We are building **Phase 1: Foundation + Recipe Library**.
This includes: database schema, household setup, recipe CRUD (manual + paste + URL import), and basic Next.js UI.
DO NOT build the weekly planner, batch prep engine, grocery engine, or AI suggestions yet.
See docs/ROADMAP.md for future phases.

## TECH STACK (DO NOT CHANGE WITHOUT ASKING)
- Database: Supabase (PostgreSQL)
- Backend API: Supabase auto-generated REST API + Edge Functions
- Frontend: Next.js (mobile-first, responsive)
- Automation: n8n (recipe URL parsing, future AI features)
- AI: Claude Sonnet API via n8n (recipe text parsing)
- Storage: OCI Object Storage (recipe images)
- Auth: Supabase Auth (email/password for now)

## KEY URLS AND IDENTIFIERS
- Supabase project: (to be created — new project for Plateful)
- n8n instance: (Shyam's existing self-hosted n8n)
- OCI bucket: (to be created — "plateful-images" in ap-hyderabad-1)

## CURRENT STATUS
- Phase 1 (Foundation + Recipe Library): IN PROGRESS
- Phase 2 (Weekly Planner): NOT STARTED
- Phase 3 (Batch Prep + Grocery): NOT STARTED
- Phase 4 (Learning + Polish): NOT STARTED
See .claude/context.md for detailed progress tracking.

## PROJECT FOLDER STRUCTURE
```
Plateful/
├── CLAUDE.md
├── .claude/
│   └── context.md
├── docs/
│   ├── PRD.md
│   ├── ARCHITECTURE.md
│   ├── SCHEMA.md
│   └── ROADMAP.md
├── sql/
│   ├── 001-foundation-schema.sql
│   ├── 002-seed-global-ingredients.sql
│   ├── 003-seed-helper-function.sql
│   ├── 004-auth-rls-setup.sql
│   └── 005-test-auth-rls.sql
├── workflows/
│   ├── WF-001-recipe-paste-parser.json
│   └── WF-002-recipe-url-parser.json
├── prompts/
│   └── recipe-text-parser-v1.md
├── src/
│   └── frontend/              ← Next.js app
└── tests/
```

## DATABASE SCHEMA (PHASE 1 TABLES)
- **households**: Top-level tenant container (id, name, created_by, is_archived)
- **household_members**: People in household (name, age, goals, dietary_notes, is_app_user, is_archived)
- **global_ingredients**: Pre-seeded template catalog (~250 ingredients, not per-household)
- **ingredients**: Per-household ingredient library (seeded from global on signup)
- **recipes**: Recipe library (title, cuisine, servings, times, tags, source_type, status)
- **recipe_ingredients**: Junction table (recipe_id, ingredient_id, quantity, unit, group_name)
- **recipe_steps**: Ordered steps (recipe_id, step_number, instruction)

Tables deferred to Phase 2: member_dietary_prefs, member_participation_defaults

## CRITICAL BUSINESS RULES
- Every query MUST filter by household_id — this is a multi-tenant app from day 1
- Recipes belong to a household (private library) — no shared public recipes yet
- Ingredient quantities must store both amount AND unit — never just a string like "some salt"
- All nutrition values are per 100g to allow unit conversion
- Recipe imports (URL/paste) are ALWAYS saved as draft status — user must review before using
- Never delete recipes — soft delete only (is_archived flag)

## WHAT I NEED HELP WITH RIGHT NOW
Session 3 (recipe parser) done. Next: import workflows into n8n, set environment variables, test with real recipes, then Session 4 (Next.js UI).

## CODING CONVENTIONS
- SQL: snake_case for all table/column names, UUID primary keys, created_at/updated_at on all tables
- Frontend: TypeScript, functional components, Tailwind CSS, mobile-first
- API: Use Supabase client library (not raw fetch) for all database operations
- Error handling: Every API call must have try/catch with user-friendly error messages
- File naming: kebab-case for files, PascalCase for components

## WHEN GENERATING SQL
- All SQL must be runnable directly in Supabase SQL Editor
- Include IF NOT EXISTS for table creation
- ENUMs: use TEXT + CHECK constraints (not CREATE TYPE — easier to evolve)
- Include verification queries at the bottom (SELECT count(*) FROM table_name)
- Include rollback section (commented out DROP statements)

## WHEN GENERATING n8n WORKFLOWS
- Output must be valid JSON importable via n8n Import from File
- Use descriptive node names (not "HTTP Request 1")
- Store API keys in n8n credentials, never hardcoded
- Include error handling nodes for every HTTP request
- Test with a single item before batch processing

## UI/DESIGN APPROACH
- Claude gives 100% effort on design and UI — make it look polished, not just functional
- Use the food-themed color palette consistently (terracotta, sage, mustard, cream)
- Mobile-first responsive design with proper spacing, shadows, and transitions
- Follow existing component patterns (rounded-xl cards, subtle borders, hover states)
- **Future UI redesign workflow (Google Stitch):**
  1. Claude generates a detailed Stitch-compatible prompt describing all UI elements, layout, colors, and component structure
  2. Shyam feeds the prompt into Google Stitch to generate the UI
  3. Shyam tweaks visual aspects manually in Stitch (colors, spacing, etc.)
  4. Shyam copies the HTML/CSS output back to Claude
  5. Claude incorporates the Stitch output into the Next.js/Tailwind codebase without breaking functionality
  - When generating Stitch prompts: include ALL interactive elements, states (empty, loading, error, populated), responsive breakpoints, and the exact color palette hex values
  - When incorporating Stitch output: preserve all existing data flow, Supabase queries, event handlers, and TypeScript types — only change the visual layer

## Design System
Always read DESIGN.md before making any visual or UI decisions.
All font choices, colors, spacing, and aesthetic direction are defined there.
Do not deviate without explicit user approval.
In QA mode, flag any code that doesn't match DESIGN.md.
Key rules: use `primary-dark` (#C4603F) for text instead of `primary` (#E07A5F) — contrast.
Never use `ink-light` (#9CA3AF) for readable text — only placeholders and decorative borders.
All interactive elements must be 44px minimum touch target.

## gstack
Use /browse from gstack for all web browsing. Never use mcp__claude-in-chrome__* tools.
Available skills: /plan-ceo-review, /plan-eng-review, /plan-design-review,
/design-consultation, /review, /ship, /browse, /qa, /qa-only, /qa-design-review,
/setup-browser-cookies, /retro, /document-release.
If gstack skills aren't working, run: cd ~/.claude/skills/gstack && ./setup
