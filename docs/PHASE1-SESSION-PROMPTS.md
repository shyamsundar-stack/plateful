# MealPlanr — Phase 1 Session Prompts
## Copy-paste these into Claude Code in order

---

# SESSION 1: Database Schema + Seed Data
**Goal:** Create all Phase 1 tables in Supabase and seed lookup data.
**Time estimate:** 45-60 minutes
**This is a significant feature → use gstack sequence**

---

### PROMPT 1 — Product Review

```
/plan-ceo-review
I'm building a family meal planning app called MealPlanr. Phase 1 is the
foundation: database schema + recipe library.

The app helps a household plan weekly meals, optimize batch prep, and
auto-generate grocery lists. Right now I need the database foundation.

Key requirements:
- Multi-tenant from day 1 (household_id on everything) because I plan to
  sell this commercially later
- Household members include non-app-users (kids, elderly)
- Recipes can come from 3 sources: manual entry, pasted text, URL import
- Imported recipes always start as "draft" — user must review
- Ingredient library is per-household with nutrition data
- Indian/Asian food bias with high-protein preference

I'm planning these tables for Phase 1:
households, household_members, member_dietary_prefs,
member_participation_defaults, ingredients, recipes,
recipe_ingredients, recipe_steps

Is this the right foundation? Am I missing anything critical?
Am I over-building anything for Phase 1?
```

**Why this prompt:** The CEO review catches missing tables or over-engineering before you write any SQL. It might suggest simplifying member_participation_defaults to Phase 2 (since you don't need the weekly planner yet), which would save time.

---

### PROMPT 2 — Engineering Review

```
/plan-eng-review
Based on the CEO review, we're going ahead with the Phase 1 schema.

Read docs/SCHEMA.md for the complete table designs.

Design the SQL migration:
1. What order should tables be created (foreign key dependencies)?
2. What indexes do we need for common queries (list recipes by household,
   search ingredients by name)?
3. What ENUMs should be PostgreSQL types vs text check constraints?
4. What are the failure modes — what happens if someone tries to delete
   a household that has recipes?
5. Should I use Supabase's built-in auth.users or a separate users table?
6. What seed data do we need for the lookup ENUMs?

Keep it practical — this is a personal-use app scaling to small commercial.
Don't over-engineer.
```

**Why this prompt:** The engineering review locks the CREATE TABLE order (households first, then members, then ingredients, then recipes), decides on ENUMs vs constraints, and catches FK dependency issues before you run anything.

---

### PROMPT 3 — Build the Schema SQL

```
Based on the engineering plan, generate the complete SQL migration file.

Read docs/SCHEMA.md for table definitions.

Requirements:
- Use CREATE TABLE IF NOT EXISTS for all tables
- Use PostgreSQL ENUM types for: activity_level, goal, pref_type,
  target_type, meal_type, participation_mode, ingredient_category,
  recipe_source_type, recipe_status, difficulty
- UUID primary keys using gen_random_uuid()
- created_at DEFAULT now(), updated_at with trigger
- Add an updated_at trigger function (create once, apply to all tables)
- Foreign keys with ON DELETE CASCADE for child tables,
  ON DELETE RESTRICT for households (prevent accidental deletion)
- Indexes on: household_id (all tables), recipes.status,
  ingredients.name, recipes.cuisine
- Include comments on non-obvious columns

Save to: sql/001-foundation-schema.sql

The SQL must be runnable in one shot in Supabase SQL Editor.
```

**Why this prompt:** This is the actual build step. It references the exact schema doc and specifies every convention so Claude doesn't guess.

---

### PROMPT 4 — Build the Seed Data SQL

```
Generate seed data SQL for MealPlanr.

Include:
1. A test household called "Shyam's Family"
2. Two household members:
   - Shyam (30, moderate activity, gain_muscle goal)
   - Wife (28, light activity, maintain goal)
3. Dietary prefs: Wife has hard_no for mushroom
4. Participation defaults: Shyam skips weekday breakfast (Mon-Fri)
5. 20 common Indian cooking ingredients with nutrition data:
   rice, dal (toor), onion, tomato, potato, chicken breast, paneer,
   ghee, coconut oil, turmeric, cumin, coriander, garlic, ginger,
   green chili, curry leaves, mustard seeds, salt, sugar, lemon
6. 3 sample recipes (one for each source_type):
   - Manual: "Dal Tadka" with ingredients and steps
   - Paste import: "Chicken Curry" (status=draft, source_text filled)
   - URL import: "Paneer Butter Masala" (status=draft, source_url filled)

Save to: sql/002-seed-data.sql

NOTE: Use the UUIDs from the households/members tables. Generate fixed
UUIDs so they're predictable for testing (use uuid_generate_v4() is fine,
but make sure FKs reference the right parent).
```

**Why this prompt:** Real seed data lets you verify the schema actually works. The 3 recipe types test all source_type paths. Indian ingredients mean the data is immediately useful.

---

### PROMPT 5 — Code Review

```
/review
Focus on the two SQL files we just created:
- sql/001-foundation-schema.sql
- sql/002-seed-data.sql

Check for:
1. Foreign key references — do all FKs point to existing tables/columns?
2. ENUM values — are they consistent between schema and seed data?
3. Can I run 001 then 002 in sequence without errors?
4. Are there any missing indexes for queries we'll run often?
5. Is the updated_at trigger applied to ALL tables that need it?
6. Multi-tenant safety — is household_id present on every table it should be?
```

**Why this prompt:** The review catches FK mismatches and missing ENUMs that would cause the SQL to fail when you paste it into Supabase.

---

### PROMPT 6 — Verification

```
Generate verification queries I can run in Supabase SQL Editor after
running both SQL files.

I need queries to confirm:
1. All tables exist (list all tables in public schema)
2. All ENUMs exist with correct values
3. Seed data counts: 1 household, 2 members, 1 dietary pref,
   5 participation defaults, 20 ingredients, 3 recipes
4. Foreign keys are working (join recipes → recipe_ingredients → ingredients)
5. The updated_at trigger fires (UPDATE a recipe title and check updated_at changes)

Save to: sql/003-verification.sql
```

**Why this prompt:** You'll run these queries right after pasting the schema + seed SQL into Supabase. If anything fails, you'll know exactly what to tell Claude Code to fix.

---

### PROMPT 7 — Save Progress

```
Update .claude/context.md with:
- Session 1 complete: foundation schema + seed data created
- All 8 tables created with ENUMs, indexes, and triggers
- 20 Indian ingredients seeded with nutrition data
- 3 sample recipes (manual, paste, URL) seeded
- Verification queries pass
- Next step: Session 2 (Auth + Household Setup)
- Decision: using PostgreSQL ENUMs (not text constraints)
- Decision: updated_at trigger shared across all tables
```

---
---

# SESSION 2: Auth + Household Setup + RLS
**Goal:** Set up Supabase Auth, household creation flow, and Row Level Security.
**Time estimate:** 45-60 minutes
**Significant feature → use gstack sequence**

---

### PROMPT 1 — Product Review

```
/plan-ceo-review
I need to add authentication and household setup to MealPlanr.

The flow I'm imagining:
1. User signs up with email/password (Supabase Auth)
2. After signup, they create a household (name it)
3. Then they add household members (themselves + family)
4. Each member gets dietary preferences and participation defaults

Right now this is for me + 1-2 friends testing. But I want the
data model to support commercial multi-tenant later.

Questions:
- Should signup auto-create a household, or should it be a separate step?
- How do I handle inviting a family member who should also be an app user?
- Should I build the full member profile form now, or just name + basics?

What's the simplest thing that works for personal use but doesn't
block commercial scaling later?
```

---

### PROMPT 2 — Engineering Review

```
/plan-eng-review
Based on the CEO review, design the auth + household setup.

Read docs/SCHEMA.md and docs/ARCHITECTURE.md for context.

I need:
1. Supabase Auth configuration (email/password)
2. RLS policies for ALL Phase 1 tables:
   - Users can only read/write data in their household
   - The household creator is the admin (for now)
3. A trigger or function that links auth.users to household_members
4. The signup → create household → add members flow

Design the RLS policies. What are the edge cases?
What happens if a user hasn't created a household yet?
What happens if someone tries to access a recipe from another household?
```

---

### PROMPT 3 — Build RLS + Auth SQL

```
Build the SQL for auth integration and RLS policies.

Read docs/SCHEMA.md for table structure.

Generate:
1. A user_profiles table that links auth.users to households
   (or modify households to include this mapping)
2. A function: get_user_household_id() that returns the current
   user's household_id (used in all RLS policies)
3. RLS policies for EVERY Phase 1 table:
   - households: users can only see their own
   - household_members: filtered by household_id
   - member_dietary_prefs: filtered through household_members
   - member_participation_defaults: filtered through household_members
   - ingredients: filtered by household_id
   - recipes: filtered by household_id
   - recipe_ingredients: filtered through recipes
   - recipe_steps: filtered through recipes
4. Enable RLS on all tables

Save to: sql/004-auth-and-rls.sql
Runnable in Supabase SQL Editor in one shot.
```

---

### PROMPT 4 — Code Review

```
/review
Review sql/004-auth-and-rls.sql for:
1. Can a user access data from another household? (Should be impossible)
2. Are there any tables missing RLS policies?
3. Does the get_user_household_id() function handle the case where
   a user hasn't created a household yet?
4. Can a user create a NEW household? (INSERT policy needed)
5. Do the RLS policies work for both SELECT and INSERT/UPDATE/DELETE?
```

---

### PROMPT 5 — Verification

```
Generate verification queries for the auth + RLS setup.

I need to confirm:
1. RLS is enabled on all tables (query pg_tables or information_schema)
2. All policies exist (list all policies)
3. The get_user_household_id() function exists and works
4. Test: using the Supabase dashboard, can I see the seed data
   when logged in as the correct user?

Save to: sql/005-rls-verification.sql
```

---

### PROMPT 6 — Save Progress

```
Update .claude/context.md with:
- Session 2 complete: Auth + RLS configured
- Supabase Auth enabled (email/password)
- RLS policies on all 8 Phase 1 tables
- get_user_household_id() helper function created
- Next step: Session 3 (Recipe text/URL parser via n8n)
```

---
---

# SESSION 3: Recipe Import Parsers (n8n + Claude API)
**Goal:** Build n8n workflows that parse recipe text and URLs into structured data.
**Time estimate:** 60-90 minutes
**Significant feature → use gstack sequence**

---

### PROMPT 1 — Product Review

```
/plan-ceo-review
I want to build two recipe import methods for MealPlanr:

1. PASTE TEXT: User copies a recipe from anywhere and pastes it into the app.
   The AI parses it into structured fields (title, ingredients with quantities,
   steps, cuisine, tags, etc.)

2. URL IMPORT: User pastes a recipe URL. The system fetches the page,
   extracts the recipe, and structures it the same way.

Both should save the result as a "draft" recipe that the user reviews
and confirms.

My approach: n8n webhooks that the frontend calls. n8n handles the
fetching + AI parsing + saving to Supabase.

Is this the right approach? Should the AI also estimate nutrition,
or should I calculate that deterministically from the ingredient quantities?
```

---

### PROMPT 2 — Engineering Review

```
/plan-eng-review
Based on the CEO review, design the recipe parser system.

Read docs/ARCHITECTURE.md for the data flow diagrams.
Read docs/SCHEMA.md for the recipe and ingredient table structures.

Design two n8n workflows:

WF-001: Recipe Text Parser
- Trigger: webhook (receives { text: "raw recipe text", household_id: "..." })
- Process: send to Claude Sonnet API with structured extraction prompt
- Validate: check JSON structure matches our schema
- Save: insert into recipes, recipe_ingredients, recipe_steps (status=draft)
- Return: the created recipe_id

WF-002: Recipe URL Parser
- Trigger: webhook (receives { url: "https://...", household_id: "..." })
- Fetch: HTTP GET the page
- Process: send HTML to Claude Sonnet API with extraction prompt
- Same validation and save logic as WF-001
- Return: the created recipe_id

Edge cases to handle:
- What if the AI returns an ingredient not in our ingredients table?
- What if the URL is behind a paywall or returns 403?
- What if the recipe text is in a language other than English?
- What if the AI can't parse the text (garbage input)?
```

---

### PROMPT 3 — Build the AI Parsing Prompt

```
Create the AI system prompt for recipe parsing.

This prompt will be sent to Claude Sonnet API via n8n.
It must work for BOTH text input and HTML input.

The prompt should instruct the AI to:
1. Extract: title, description, cuisine, meal_types, servings,
   prep_time_min, cook_time_min, difficulty, tags
2. Extract ingredients as array: [{name, quantity, unit, preparation, is_optional, group_name}]
3. Extract steps as array: [{step_number, instruction, duration_min}]
4. Detect: is_vegetarian, is_vegan, is_batch_friendly
5. Estimate: leftover_days (0-5)
6. Return ONLY valid JSON — no markdown, no explanation
7. If input is unrecognizable as a recipe, return: {"error": "not_a_recipe", "message": "..."}

Use these exact field names (matching our schema).
Use these unit options: g, kg, ml, l, tsp, tbsp, cup, piece, pinch, handful, to_taste
Use these cuisine options: Indian, South Indian, North Indian, Chinese, Indo-Chinese,
  Italian, Thai, Japanese, Korean, Mexican, Middle Eastern, Continental, Other

Version this as: v1.0-recipe-parser
Save to: prompts/recipe-parser-v1.0.md

Also save just the system prompt text (no markdown wrapper) to:
prompts/recipe-parser-v1.0-raw.txt
(This is what gets pasted into the n8n Claude API node)
```

**Why this prompt:** The AI prompt is separate from the workflow so you can version and refine it independently. The raw .txt version is what you'll paste directly into n8n.

---

### PROMPT 4 — Build WF-001 (Text Parser Workflow)

```
Build the n8n workflow JSON for recipe text parsing.

Read prompts/recipe-parser-v1.0-raw.txt for the AI prompt.
Read docs/SCHEMA.md for the database structure.

Workflow: WF-001-recipe-text-parser

Nodes:
1. Webhook trigger (POST, path: /recipe/parse-text)
   - Expects body: { "text": "...", "household_id": "..." }
2. Validate input (Code node: check text is not empty, household_id is UUID)
3. Call Claude Sonnet API (HTTP Request node)
   - Use Anthropic API with credential reference "Anthropic API Key"
   - Model: claude-sonnet-4-20250514
   - System prompt: the recipe parser prompt
   - User message: the pasted text
4. Parse response (Code node: extract JSON from Claude response)
5. Validate parsed recipe (Code node: check required fields exist)
6. Create ingredient records (Code node: for each ingredient, check if it
   exists in household's ingredients table, create if not)
7. Insert recipe into Supabase (HTTP Request: POST to recipes table)
8. Insert recipe_ingredients (HTTP Request: POST to recipe_ingredients)
9. Insert recipe_steps (HTTP Request: POST to recipe_steps)
10. Return response (Respond to Webhook: { recipe_id, status: "draft" })

Error handling:
- If Claude returns invalid JSON → return { error: "parse_failed" }
- If Supabase insert fails → return { error: "save_failed", details: "..." }
- Wrap Claude API call in try/catch

Save to: workflows/WF-001-recipe-text-parser.json
The JSON must be directly importable into n8n.
```

---

### PROMPT 5 — Build WF-002 (URL Parser Workflow)

```
Build the n8n workflow JSON for recipe URL parsing.

This is similar to WF-001 but adds a URL fetch step.

Workflow: WF-002-recipe-url-parser

Nodes:
1. Webhook trigger (POST, path: /recipe/parse-url)
   - Expects body: { "url": "https://...", "household_id": "..." }
2. Validate input (Code node: check URL format, household_id is UUID)
3. Fetch URL content (HTTP Request node: GET the URL)
   - Set User-Agent to avoid bot blocks
   - Timeout: 10 seconds
   - If status != 200, return error
4. Extract text from HTML (Code node: strip tags, keep relevant content)
   - Look for JSON-LD recipe schema first (many recipe sites include this)
   - Fall back to raw text extraction if no schema found
5. Call Claude Sonnet API (same as WF-001 but with the extracted text/HTML)
6-10. Same as WF-001 (parse, validate, insert, return)

Additional error handling:
- URL returns 403/404 → return { error: "url_unreachable" }
- URL content is not a recipe → return { error: "not_a_recipe" }
- Timeout → return { error: "url_timeout" }

Also save the source_url in the recipe record.

Save to: workflows/WF-002-recipe-url-parser.json
```

---

### PROMPT 6 — Code Review

```
/review
Review these files:
- prompts/recipe-parser-v1.0.md
- workflows/WF-001-recipe-text-parser.json
- workflows/WF-002-recipe-url-parser.json

Check for:
1. Does the AI prompt JSON structure match our Supabase schema exactly?
2. Do the n8n workflows use credential references (not hardcoded keys)?
3. Is error handling present for every HTTP request node?
4. Does the workflow handle the case where an ingredient doesn't exist yet?
5. Are the webhook paths unique and sensible?
6. Will the response format work for the frontend to redirect to draft review?
```

---

### PROMPT 7 — Save Progress

```
Update .claude/context.md with:
- Session 3 complete: Recipe parsers built
- AI prompt v1.0 created for recipe text/HTML extraction
- WF-001 (text parser) and WF-002 (URL parser) n8n workflows generated
- Both workflows save parsed recipes as draft status
- Both handle new ingredients (auto-create in household library)
- Next step: Session 4 (Next.js setup + recipe list UI)
- Note: Need to import workflows into n8n and test with real recipes
- Note: Need Anthropic API credential in n8n
```

---
---

# SESSION 4: Next.js Setup + Recipe List UI
**Goal:** Scaffold the Next.js app and build the recipe list page.
**Time estimate:** 60-90 minutes
**Significant feature → use gstack sequence**

---

### PROMPT 1 — Product Review

```
/plan-ceo-review
I need to set up the Next.js frontend for MealPlanr and build the first
page: the recipe list.

This is a mobile-first app. My primary device is Samsung Galaxy S24 Ultra.
I'll also use it on desktop but mobile is the main experience.

The recipe list page should:
- Show all active recipes in my household as cards
- Each card: title, cuisine tag, time, difficulty, vegetarian badge
- Filter by: cuisine, meal type, difficulty, vegetarian/vegan
- Search by recipe title
- "Add Recipe" button (leads to Session 5's add form)
- Tap a card to see recipe detail

I want it to feel modern and clean. Not cluttered.

Is this the right first page to build? Should I start with
onboarding/auth instead?
```

---

### PROMPT 2 — Engineering Review

```
/plan-eng-review
Based on the CEO review, design the Next.js setup and recipe list page.

Read docs/ARCHITECTURE.md for the system design.
Read docs/SCHEMA.md for the recipe table structure.

Plan:
1. Next.js project setup (App Router, TypeScript, Tailwind CSS)
2. Supabase client configuration (environment variables)
3. Auth middleware (redirect to login if not authenticated)
4. Recipe list page with:
   - Server-side data fetching from Supabase
   - Filter/search state management
   - Responsive card grid (1 col mobile, 2 col tablet, 3 col desktop)
   - Empty state (no recipes yet → prompt to add one)
   - Loading state

What's the folder structure for the Next.js app?
Should I use server components or client components for the list?
How should I handle the Supabase client (server vs browser)?
```

---

### PROMPT 3 — Build Next.js Scaffold

```
Set up the Next.js project for MealPlanr.

Create the project at: src/frontend/

Setup requirements:
- Next.js 14+ with App Router
- TypeScript
- Tailwind CSS
- @supabase/supabase-js and @supabase/ssr for auth
- Environment variables template (.env.local.example) with:
  NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
  NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key

Create these files:
- src/frontend/lib/supabase/client.ts (browser client)
- src/frontend/lib/supabase/server.ts (server client)
- src/frontend/middleware.ts (auth redirect)
- src/frontend/app/layout.tsx (root layout with Tailwind)
- src/frontend/app/page.tsx (redirect to /recipes)
- src/frontend/app/login/page.tsx (simple email/password login)
- src/frontend/types/database.ts (TypeScript types matching our schema)

Mobile-first: default font size readable on phone, touch-friendly tap targets (min 44px).

Save all files to: src/frontend/
```

---

### PROMPT 4 — Build Recipe List Page

```
Build the recipe list page for MealPlanr.

Read docs/SCHEMA.md for the recipes table structure.
Read src/frontend/types/database.ts for the TypeScript types.

Page: src/frontend/app/recipes/page.tsx

Requirements:
- Fetch recipes from Supabase where status = 'active' and household_id = user's household
- Display as cards in responsive grid (1 col mobile, 2 tablet, 3 desktop)
- Each card shows: title, cuisine badge, total_time_min, difficulty, veg/vegan icon
- Filter bar at top: cuisine dropdown, meal type pills, difficulty, veg only toggle
- Search bar: filter by title (client-side for now)
- Empty state: friendly message + "Add your first recipe" button
- Loading state: skeleton cards
- "Add Recipe" floating action button (bottom right on mobile)
- Draft recipes shown separately at top with "Review draft" badge

Create these components:
- src/frontend/components/recipes/RecipeCard.tsx
- src/frontend/components/recipes/RecipeFilters.tsx
- src/frontend/components/recipes/RecipeList.tsx

Style: clean, modern, warm colors. Think Notion meets a cooking app.
Use Tailwind only. No extra UI library needed.
```

---

### PROMPT 5 — Code Review

```
/review
Review the entire src/frontend/ directory for:
1. Is the Supabase client correctly configured for both server and browser?
2. Does the auth middleware properly protect all routes except /login?
3. Does the recipe list query filter by household_id?
4. Are TypeScript types matching the database schema?
5. Is the mobile layout actually usable on a phone (not just "responsive")?
6. Are there any hardcoded values that should be in env vars?
7. Error handling: what happens if Supabase is unreachable?
```

---

### PROMPT 6 — Save Progress

```
Update .claude/context.md with:
- Session 4 complete: Next.js scaffold + recipe list page
- Next.js 14 with App Router, TypeScript, Tailwind CSS
- Supabase client configured (server + browser)
- Auth middleware redirects to /login
- Recipe list page with cards, filters, search
- Mobile-first layout tested
- Next step: Session 5 (Recipe CRUD — add/edit/import forms)
- Blocker: Need to fill in .env.local with real Supabase credentials
```

---
---

# SESSION 5: Recipe CRUD UI (Add, Edit, Import)
**Goal:** Build the forms for adding recipes manually, importing via text, and importing via URL.
**Time estimate:** 60-90 minutes
**Significant feature → use gstack sequence**

---

### PROMPT 1 — Product Review

```
/plan-ceo-review
I need to build 3 ways to add recipes to MealPlanr:

1. MANUAL ENTRY: Full form — title, ingredients (with quantity + unit),
   steps, cuisine, tags, etc. This is the most complete but slowest.

2. PASTE TEXT: User pastes raw recipe text, clicks "Parse", AI extracts
   the structured data, shows it as a draft form that user can edit
   and confirm.

3. URL IMPORT: User pastes a URL, clicks "Import", system fetches + parses,
   shows draft form for review.

All three should end up at the same edit form — the difference is how
the initial data gets populated.

I also need:
- Recipe detail view (read-only, for when you're cooking)
- Edit recipe (same form as manual entry, pre-filled)

Should all three import methods be on one page with tabs?
Or separate pages? What's the simplest UX?
```

---

### PROMPT 2 — Engineering Review

```
/plan-eng-review
Based on the CEO review, design the recipe CRUD pages.

Read docs/SCHEMA.md for recipe, recipe_ingredients, recipe_steps structure.
Read src/frontend/components/recipes/ for existing components.

Design:
1. Add Recipe page (/recipes/new) with three tabs:
   - "Write Recipe" (manual form)
   - "Paste Text" (textarea + Parse button → calls n8n WF-001)
   - "Import URL" (URL input + Import button → calls n8n WF-002)

2. Recipe Edit page (/recipes/[id]/edit) — same form as manual, pre-filled

3. Recipe Detail page (/recipes/[id]) — read-only cooking view with:
   - Ingredients list (checkable for while cooking)
   - Steps (large text, one at a time mode for cooking)
   - Quick info bar (time, servings, difficulty)

4. Draft review: when AI import creates a draft, redirect to edit page
   with a yellow "This is a draft — review and confirm" banner

Edge cases:
- What if the n8n webhook is down?
- What if parsing takes 15+ seconds? (loading state needed)
- Dynamic ingredient rows (add/remove ingredients in the form)
- Dynamic step rows (add/remove/reorder steps)
```

---

### PROMPT 3 — Build Add Recipe Page

```
Build the Add Recipe page for MealPlanr.

Read docs/SCHEMA.md for the data structure.
Read src/frontend/types/database.ts for TypeScript types.

Page: src/frontend/app/recipes/new/page.tsx

Tab 1 — Manual Entry:
- Title, description, cuisine (dropdown), meal_types (multi-select pills)
- Servings, prep_time, cook_time, difficulty
- Tags (multi-select: high-protein, batch-friendly, quick, comfort, etc.)
- Vegetarian/vegan toggles
- Ingredients section: dynamic rows with [quantity] [unit dropdown] [ingredient name] [preparation] [optional toggle]
  - Add ingredient button
  - Group name field (e.g. "For the gravy")
- Steps section: dynamic numbered rows with [instruction] [duration_min optional]
  - Add step / reorder buttons
- Save button → INSERT into Supabase → redirect to detail page

Tab 2 — Paste Text:
- Large textarea: "Paste your recipe here..."
- "Parse with AI" button → calls n8n WF-001 webhook
- Loading state: "Parsing your recipe..." with spinner
- On success: redirect to /recipes/[new_id]/edit with draft banner

Tab 3 — Import URL:
- URL input field
- "Import" button → calls n8n WF-002 webhook
- Same loading state and redirect as Tab 2

Create components:
- src/frontend/components/recipes/RecipeForm.tsx (shared form)
- src/frontend/components/recipes/IngredientInput.tsx (dynamic row)
- src/frontend/components/recipes/StepInput.tsx (dynamic row)
- src/frontend/components/recipes/ImportTab.tsx (paste + URL tabs)

Save all to: src/frontend/
```

---

### PROMPT 4 — Build Detail + Edit Pages

```
Build the recipe detail and edit pages.

Read the RecipeForm component from the previous step.
Read docs/SCHEMA.md for the data structure.

Page 1: src/frontend/app/recipes/[id]/page.tsx (Detail view)
- Fetch recipe + ingredients + steps from Supabase by ID
- Hero section: title, cuisine badge, time, difficulty, servings adjuster
- Ingredients list with checkboxes (for cooking mode)
- Steps displayed large and clear, one-at-a-time mode option
- "Edit" button in top right
- If recipe.status === 'draft': show yellow banner "This recipe was
  imported and needs your review. Edit to confirm."
- Back button to recipe list

Page 2: src/frontend/app/recipes/[id]/edit/page.tsx (Edit view)
- Reuse RecipeForm component, pre-filled with existing data
- "Save" updates the recipe
- If status was 'draft', saving changes status to 'active'
- "Delete" button (sets is_archived = true, redirects to list)
- "Cancel" returns to detail view

Save all to: src/frontend/
```

---

### PROMPT 5 — Code Review

```
/review
Review all recipe CRUD pages and components:
- src/frontend/app/recipes/new/page.tsx
- src/frontend/app/recipes/[id]/page.tsx
- src/frontend/app/recipes/[id]/edit/page.tsx
- All components in src/frontend/components/recipes/

Check for:
1. Does manual recipe save correctly insert into all 3 tables (recipes, recipe_ingredients, recipe_steps)?
2. Do the n8n webhook calls include household_id?
3. Is there proper loading + error state for AI parsing?
4. Does the draft → active status transition work on save?
5. Is the ingredient dynamic form adding/removing rows correctly?
6. Can I use this on a phone? (touch targets, scrolling, keyboard handling)
7. XSS risk: is user-pasted text properly sanitized?
```

---

### PROMPT 6 — Save Progress

```
Update .claude/context.md with:
- Session 5 complete: Recipe CRUD (add manual, paste, URL, edit, detail, delete)
- Three import methods working through tab interface
- AI import creates drafts, manual creates active
- Draft → active on first edit save
- Soft delete with is_archived
- Next step: Session 6 (End-to-end testing + polish)
```

---
---

# SESSION 6: End-to-End Testing + Phase 1 Polish
**Goal:** Test the complete Phase 1 flow, fix bugs, and polish the experience.
**Time estimate:** 45-60 minutes
**Use gstack /browse for visual testing**

---

### PROMPT 1 — End-to-End Test Plan

```
/plan
Create a test plan for MealPlanr Phase 1.

Test the complete flow:
1. Sign up with email/password
2. Create a household
3. Add 2 household members with dietary preferences
4. Add a recipe manually (Dal Tadka)
5. Import a recipe via pasted text (paste a real recipe)
6. Import a recipe via URL (use a public recipe URL)
7. View the recipe list — confirm all 3 appear
8. Open a draft recipe — confirm the draft banner shows
9. Edit the draft — confirm it becomes active after save
10. Filter recipes by cuisine, search by name
11. View recipe detail in "cooking mode"
12. Archive a recipe — confirm it disappears from list

For each test, tell me:
- What to click/type
- What I should see
- What to do if something goes wrong

Save to: docs/PHASE1-TEST-PLAN.md
```

---

### PROMPT 2 — Visual QA

```
/browse
Test MealPlanr on both mobile and desktop viewport.

Check:
1. Recipe list cards — readable on phone? Images not broken?
2. Add recipe form — can I fill it on mobile without horizontal scroll?
3. Ingredient rows — can I tap add/remove on phone?
4. Recipe detail — is the cooking mode (checkable ingredients, large steps) usable?
5. Login page — clean and centered?
6. Filters — do they collapse nicely on mobile?
7. Loading states — are skeleton cards showing?
8. Empty state — is the "add first recipe" message friendly?
```

---

### PROMPT 3 — Fix Bugs

```
Based on the testing, here are the issues I found:

[Paste your list of issues here after testing]

Fix all of these. For each fix, explain:
1. What was wrong
2. What you changed
3. How to verify the fix
```

---

### PROMPT 4 — Final Review

```
/review
Final review of the entire MealPlanr Phase 1 codebase.

Focus on:
1. Security: Are all routes protected? Is household isolation working?
2. Data integrity: Can I create a recipe with missing required fields?
3. Error handling: What happens when n8n is unreachable?
4. Mobile UX: Is everything usable on a phone?
5. Performance: Any unnecessary re-renders or slow queries?
6. Code quality: Consistent naming, no dead code, proper types
```

---

### PROMPT 5 — Phase 1 Retrospective

```
Update .claude/context.md with Phase 1 completion:

- Phase 1: COMPLETE
- What's working: auth, household setup, recipe CRUD (manual + paste + URL),
  recipe list with filters, recipe detail with cooking mode
- Tables: 8 tables with RLS, 20 seed ingredients
- Workflows: WF-001 (text parser), WF-002 (URL parser)
- Frontend: Next.js with 5 pages (login, recipe list, add, detail, edit)
- Known issues: [list any remaining minor issues]
- Next: Phase 2 (Weekly Planner) — see docs/ROADMAP.md

Also update docs/ROADMAP.md:
- Phase 1: COMPLETE ✓
- Phase 2: IN PROGRESS (starting next)
```

---

# WHAT TO DO BEFORE STARTING SESSION 1

These are manual steps Shyam needs to do BEFORE opening Claude Code:

1. **Create the MealPlanr folder:**
   Open PowerShell and run the commands from the folder structure section below.

2. **Create a new Supabase project:**
   - Go to https://supabase.com → New Project
   - Name: MealPlanr
   - Region: closest to Chennai (Singapore or Mumbai)
   - Save the project URL and anon key — you'll need them for Session 4

3. **Copy the PRD into the project:**
   - Save the original PRD to docs/PRD.md

4. **Open Claude Code:**
   - Open VS Code
   - Open the MealPlanr folder
   - Start Claude Code

5. **First Claude Code command:**
   ```
   Read CLAUDE.md and all files in docs/. Tell me what you understand
   about this project and what we should build first.
   ```
   This confirms Claude Code has the right context before building anything.
