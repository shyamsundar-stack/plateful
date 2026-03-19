# Plateful — System Architecture

## System Overview

```
┌─────────────────────────────────────┐
│  Next.js Frontend (Mobile-first)    │
│  - Signup / Login                   │
│  - Household setup                  │
│  - Recipe library (CRUD)            │
│  - Weekly planner (Phase 2)         │
│  - Grocery list (Phase 3)           │
└──────────┬──────────────────────────┘
           │ Supabase Client SDK (anon key + RLS)
           ▼
┌─────────────────────────────────────┐
│  Supabase                           │
│  - PostgreSQL Database              │
│  - Auth (email/password)            │
│  - Auto-generated REST API          │
│  - Row Level Security (20 policies) │
│  - Edge Functions (if needed)       │
└──────────┬──────────────────────────┘
           │
     ┌─────┴─────┐
     ▼           ▼
┌──────────┐ ┌──────────────────────┐
│  OCI     │ │  n8n (self-hosted)   │
│  Storage │ │  - Recipe URL parser │
│  (images)│ │  - Recipe text parser│
│          │ │  - Claude Sonnet API │
└──────────┘ └──────────────────────┘
```

## Authentication & Signup Flow

```
User signs up (email + password)
    → Supabase creates auth.users row
    → Trigger: on_auth_user_created fires handle_new_user()
        → 1. Creates household ("[Name]'s Kitchen")
        → 2. Creates household_member (is_app_user = true, linked to auth user)
        → 3. Calls copy_global_ingredients() → seeds ~250 ingredients
    → User lands on dashboard with fully populated household
```

### Key Auth Design Decisions
- **Auto-create household on signup**: No separate "create household" step. Every user gets one immediately.
- **Supabase auth.users is the source of truth**: No custom users table. household_members links via auth_user_id FK.
- **Email confirmation disabled for testing**: Enable before going commercial.
- **One user = one household (Phase 1)**: Multi-household support deferred to Phase 4.

## Multi-Tenancy & RLS

### Tenant Isolation Pattern
```
Frontend request (with JWT from Supabase Auth)
    → Supabase REST API validates JWT, extracts auth.uid()
    → RLS policy calls get_my_household_id()
        → Looks up: auth.uid() → household_members → household_id
    → Policy compares row's household_id with user's household_id
    → Only matching rows returned / allowed
```

### get_my_household_id() — The Core of All RLS
Every RLS policy uses this single function. It:
- Returns the user's household_id (or NULL if no household)
- Uses SECURITY DEFINER to bypass RLS on household_members (avoids circular dependency)
- Is marked STABLE (PostgreSQL can cache within a transaction)

### RLS Policy Summary
- **20 policies** across 7 tables
- Tables with household_id: direct comparison (`household_id = get_my_household_id()`)
- Tables without household_id (recipe_ingredients, recipe_steps): subquery through recipes
- global_ingredients: read-only for all authenticated users
- No DELETE policies on main tables (soft delete only)
- DELETE allowed on recipe_ingredients and recipe_steps (normal editing)

### Security Boundaries
| Actor | Access Level |
|-------|-------------|
| Frontend (anon key) | RLS-enforced. Only own household data |
| n8n (service_role key) | Bypasses RLS. Must include household_id in writes |
| SQL Editor | Bypasses RLS. Admin access only |

## Data Flow: Recipe Import (Paste Text)

```
User pastes recipe text in UI
    → Frontend sends text to n8n webhook
    → n8n sends text to Claude Sonnet API with parsing prompt
    → Claude returns structured JSON (title, ingredients, steps, tags)
    → n8n validates JSON structure
    → n8n writes to Supabase (status = "draft") using service_role key
    → Frontend shows draft recipe for user review
    → User edits and confirms → status = "active"
```

## Data Flow: Recipe Import (URL)

```
User pastes URL in UI
    → Frontend sends URL to n8n webhook
    → n8n fetches the page HTML (HTTP Request node)
    → n8n sends HTML to Claude Sonnet API with extraction prompt
    → Claude returns structured JSON
    → n8n validates JSON structure
    → n8n writes to Supabase (status = "draft") using service_role key
    → Frontend shows draft recipe for user review
    → User edits and confirms → status = "active"
```

## Security Model

- RLS on ALL tables — no data leaks between households
- Service role key ONLY in n8n (server-side)
- Frontend uses anon key (RLS-protected)
- Recipe imports go through n8n (server-side) to avoid exposing API keys
- No API keys in frontend code, ever
- SECURITY DEFINER functions have `SET search_path = ''` to prevent injection
- Signup trigger uses SECURITY DEFINER to bootstrap household before RLS applies

## SQL Migration Order

Run these in Supabase SQL Editor, in this exact order:
1. `sql/001-foundation-schema.sql` — Tables, constraints, indexes, triggers
2. `sql/002-seed-global-ingredients.sql` — ~250 ingredient catalog
3. `sql/003-seed-helper-function.sql` — copy_global_ingredients() RPC
4. `sql/004-auth-rls-setup.sql` — Auth trigger, RLS policies, helper functions
5. `sql/005-test-auth-rls.sql` — Verification queries (run after creating a test user)
