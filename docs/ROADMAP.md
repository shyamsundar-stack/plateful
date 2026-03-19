# Plateful — Roadmap & Phase Plan

## Phase Overview

| Phase | What it does | Depends on | Sessions | Status |
|-------|-------------|------------|----------|--------|
| **Phase 1: Foundation + Recipe Library** | Database schema, household setup, recipe CRUD (manual + paste + URL import), basic Next.js UI | Nothing | 6 sessions | ✅ COMPLETE |
| **Phase 2: Weekly Planner** | Meal slot grid, participation toggles, recurring meals, nutrition tracking across the week | Phase 1 | 4-5 sessions | ✅ COMPLETE |
| **Phase 3: Batch Prep + Grocery** | Prep component system, prep block planner, grocery list generation with merging/scaling | Phase 2 | 4-5 sessions | ✅ COMPLETE |
| **Phase 4: Learning + Polish** | Preference learning (rules-based), meal suggestions ranking, UI polish, mobile optimization | Phase 3 | 4 sessions | ✅ COMPLETE |
| **Phase 5: Recipe Library + Dietary Rules** | Global recipe library (~200), veg/non-veg user identity, faith-based fasting, conditional rules engine, onboarding upgrade, ratings, taxonomy, analytics dashboard | Phase 4 | 5 sessions | ✅ COMPLETE |

---

## Phase 1: Foundation + Recipe Library (6 sessions)

### Session 1: Database Schema ✅ DONE
- 7 tables: households, household_members, global_ingredients, ingredients, recipes, recipe_ingredients, recipe_steps
- ~250 seeded global ingredients (Indian/Asian focus with nutrition data)
- copy_global_ingredients() RPC for household onboarding
- CEO review: cut member_dietary_prefs + member_participation_defaults (moved to Phase 2)
- Eng review: CHECK constraints, FK strategy, index plan
- SQL files 001-003 written and run in Supabase ✅

### Session 2: Auth + Household Setup ✅ DONE
- get_my_household_id() helper — core of all RLS policies
- handle_new_user() trigger — auto-creates household + member + seeds ingredients on signup
- 20 RLS policies across all 7 tables
- CEO review: auto-create household on signup, defer invites, minimal member profile
- Eng review: SECURITY DEFINER pattern, edge cases documented
- SQL files 004-006 run in Supabase ✅

### Session 3: Recipe Text Parser (n8n + AI) ✅ WORKFLOWS WRITTEN
- Claude parsing prompt (prompts/recipe-text-parser-v1.md) — handles multilingual, fuzzy ingredient matching
- WF-001: Paste import — webhook → fetch ingredients → Claude → validate → save draft
- WF-002: URL import — webhook → fetch URL → clean HTML → fetch ingredients → Claude → validate → save draft
- Auto-creates unmatched ingredients in household library
- CEO review: skip nutrition calc (Phase 3), AI matches against ingredient catalog
- Eng review: edge cases (403, paywall, garbage input, non-English), FK-safe save order
- **Next step:** Import into n8n, set env vars, test with real recipes

### Session 4: Next.js Setup + Recipe List UI ✅ DONE
- Next.js project scaffolding
- Supabase client integration
- Recipe list page (view all recipes in household)
- Mobile-first card layout

### Session 5: Recipe CRUD UI ✅ DONE
- Add recipe form (manual entry)
- Import recipe (paste text / paste URL)
- Edit recipe page
- Recipe detail view

### Session 6: Review + Polish Phase 1 ✅ DONE
- End-to-end testing: login → recipe list → detail → edit → paste import → status management
- Bug fix: nested n8n response structure (recipe title not showing in success message)
- Build clean, mobile responsive, error states all working
- Phase 1 COMPLETE

---

## Phase 2: Weekly Planner (4-5 sessions)

### Session 7: Meal Slot Data Model + Dietary Prefs
- WeekPlan and MealSlot tables
- member_dietary_prefs table (moved from Phase 1 — needed for meal filtering)
- member_participation_defaults table (moved from Phase 1 — needed for planner)
- Participation model (who eats which meal)
- Meal modes: cook, eat_outside, leftover, skip

### Session 8: Planner UI
- Week grid view (7 days × 3-4 meal types)
- Drag/assign recipes to slots
- Participation toggles per member per slot

### Session 9: Recurring Meals + Special Modes
- Lock recurring breakfast slots
- "Eat outside" mode (no grocery demand)
- Leftover linking (point to earlier cooked meal)

### Session 10: Weekly Nutrition Dashboard
- Calculate nutrition across the week (not per meal)
- Show protein/carb/fat balance
- Flag imbalanced days

---

## Phase 3: Batch Prep + Grocery (4-5 sessions)

### Session 11: Prep Component System
- PrepComponent table (chopped onions, cooked dal, etc.)
- Link recipes to shared prep components
- Tag recipes for batch-friendliness

### Session 12: Prep Block Planner
- Suggest weekend prep blocks based on the week's plan
- Show which meals each prep block serves
- Estimated time per block

### Session 13: Grocery Engine
- Aggregate ingredients from approved plan
- Merge overlapping items (2 recipes need onions → 1 line item)
- Unit conversion (ml to cups, g to kg)
- Scale by participant count per meal

### Session 14: Grocery List UI
- Grouped by store section (produce, dairy, grains, etc.)
- "Already have this" checkbox
- Shareable list (link for family members)

---

## Phase 4: Learning + Polish (3-4 sessions)

### Session 12: Settings Page + Recipe Nutrition ✅ DONE
- Settings page with member profiles (age, height, weight, bio_sex, activity, goals)
- Recipe detail page shows nutrition per serving with confidence score
- Header updated with Settings nav link

### Session 13: Gap Fixes + PWA ✅ DONE
- Snack slot support in planner (B/L/D/S)
- 404 page, error boundary
- Dietary preferences UI (allergy, hard_no, dislike, prefer)
- Participation defaults UI with serving factor
- PWA manifest + viewport meta

### Session 14: Safety + Preference Learning ✅ DONE
- Dietary preference warnings in planner (🚨 when recipe conflicts with member allergy/hard_no/dislike)
- Preference tracking table + implicit accept/reject logging
- Preference scoring with recency weighting + cuisine affinity
- Recipe ranking in slot editor (⭐ recommended badge)
- Shared grocery list client-side check-off (localStorage)
- PWA icons generated (icon-192.png, icon-512.png)
- Snack slots now fetched in planner (was filtering out snack meal_type)

### Session 15: Boil the Lake — Onboarding + Analytics + Auto-fill + Images + Variety ✅ DONE
- **Analytics pipeline**: append-only analytics_events table, trackEvent() fire-and-forget server action, wired into 8 actions (recipe_created, recipe_imported, week_plan_created, meal_assigned, meal_removed, grocery_generated, grocery_shared, auto_fill_week)
- **Onboarding flow**: 4-step wizard (Name Kitchen → Family → First Recipe → All Set!), middleware redirect for new users, checks household name="Kitchen" + 0 recipes
- **Smart auto-fill**: ✨ Auto-fill Week button in planner, suggestion engine with preference scoring + meal type matching + protein bias + dietary conflict filtering + variety constraint (no repeat within 5 days)
- **Recipe image upload**: Supabase Storage (recipe-images bucket), client-side canvas compression (800px max, JPEG 0.8), preview, upload on save, hero image on detail page
- **Variety enforcement**: detectRepeatedRecipes(threshold=3 days), amber 🔁 badge on meal slot cards, suggestions use stricter 5-day threshold
- **Prerequisites**: Run sql/012-analytics-events.sql. Create "recipe-images" bucket in Supabase Dashboard (public, 5MB max, image/* only).

---

## Phase 5: Global Recipe Library + Dietary Identity + Rules Engine (5 sessions) ✅ COMPLETE

### Session 16: SQL Migrations ✅ DONE
- sql/013-dietary-mode-taxonomy.sql — dietary_mode on household_members, recipe taxonomy fields (cuisine_category, cooking_style, dietary_tags, rating, is_favorite)
- sql/014-global-recipes.sql — global_recipes + global_recipe_ingredients + global_recipe_steps, RLS read-only, GIN indexes
- sql/015-meal-rules-festivals.sql — meal_rules + festival_calendar + ~20 Hindu festivals for 2026-2027

### Session 17: Types + Import Mechanism + Rules Engine Logic ✅ DONE
- lib/rules.ts — pure functions: getApplicableRules, applyRulesToCandidates, filterByDietaryModes, getRatingFavoriteBoost
- lib/actions/global-recipe-actions.ts — fetchGlobalRecipes, importGlobalRecipeToHousehold (3-tier ingredient matching), batchImportGlobalRecipes
- lib/actions/rule-actions.ts — CRUD for meal rules, fetchFestivalCalendar
- Updated: suggestions.ts (rules integration), preferences.ts (rating/favorite boosts), settings-actions.ts, onboarding-actions.ts, recipe-actions.ts

### Session 18: Global Recipe Browse UI + Onboarding Upgrade ✅ DONE
- /recipes/browse page — browse global recipe library with filters
- GlobalRecipeBrowseGrid — search, cuisine chips, meal type chips, veg/non-veg toggle
- GlobalRecipeCard + GlobalRecipeDetailModal — preview + 1-tap import
- OnboardingRecipePicker — mini browse grid for onboarding step 3
- Onboarding wizard upgraded — dietary_mode per member + library recipe picker

### Session 19: Settings (Dietary Mode + Rules Manager) + Ratings/Favorites ✅ DONE
- settings-panel.tsx — dietary_mode dropdown per member
- rules-manager.tsx — full CRUD for conditional meal rules (IF day/meal/festival THEN dietary/cuisine/ingredient action)
- star-rating.tsx — reusable star rating component
- recipe-detail.tsx — star rating + heart favorite toggle
- recipe-card.tsx — favorite heart overlay + rating stars display
- recipe-filters.tsx + recipe-grid.tsx — Favorites filter chip

### Session 20: Analytics Dashboard + Polish ✅ DONE
- /analytics page — household cooking insights
- analytics-dashboard.tsx — 8 stat cards (total recipes, active, favorites, library imports, meals planned, grocery lists, auto-fills, week streak) + top 5 most-cooked recipes + cuisine breakdown bars
- analytics-dashboard-actions.ts — parallel aggregate queries for dashboard data
- Header updated with Analytics nav link
- 0 TypeScript errors
- **Prerequisites**: Run sql/013-015 in Supabase. Recipe data (~200) pending Codex generation.

---

## Future Ideas (NOT in current scope)
- Pantry inventory tracking (Phase 6 candidate)
- YouTube/Instagram recipe import
- Grocery delivery integration (Swiggy Instamart, BigBasket)
- AI chat planner ("I have chicken and rice, what can I make?")
- Voice interface
- Social features (share recipes with friends)
- Meal prep photography (take photo → link to recipe)
