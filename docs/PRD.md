# Founder PRD and System Blueprint
## Family Meal Planning, Batch Prep, and Grocery Automation App

**Prepared for:** Shyam  
**Document type:** PRD + high-level architecture + roadmap  
**Product direction:** System suggests meals and prep plan; user edits; groceries generated

## Executive summary
This product is a household-focused meal planning app that helps families choose a balanced week of meals, optimize weekend batch cooking, and generate an intelligent grocery list. The system does not auto-impose a plan; it suggests meals and prep blocks, then the user edits and confirms.

### Snapshot
- **Primary user:** Household meal planner
- **Main outcome:** Save time while keeping weekly meals balanced
- **Core differentiator:** Batch prep optimization + grocery automation
- **MVP shape:** Private household recipe library with weekly planner
- **Monetization direction:** Subscription, with commerce integrations later

## Product vision
- Reduce the mental load of planning meals for a household.
- Optimize nutrition across the week rather than demanding perfect meals every time.
- Support real life: skipped meals, eating outside, leftovers, recurring breakfasts, and batch cooking.
- Generate a sensible grocery list automatically from the approved plan.

## Product principles
1. System suggests; user edits and confirms.
2. The week is the planning unit, not the individual meal.
3. Meal participation matters. Grocery quantities should reflect who actually eats each meal.
4. Batch prep is first-class, not an afterthought.
5. AI helps with messy inputs, but deterministic logic governs nutrition, units, and grocery merging.

## Core user and use cases
Primary user: a family meal planner, often the person coordinating meals, groceries, and cooking effort for the household.

- Plan a week quickly without debating every meal from scratch.
- Batch cook over the weekend and assemble faster weekday meals.
- Handle different participation patterns, such as one person eating out or skipping breakfast.
- Keep the week generally balanced with a high-protein bias and Indian / Asian meal preferences.

## Real-life household rules to support
- **Recurring meal:** Wife has same breakfast daily -> allow a locked recurring breakfast slot.
- **Skipped meal:** User skips weekday breakfast -> exclude that member from nutrition and grocery math for that slot.
- **Eat outside:** Thursday dinner outside -> treat as a valid meal type; do not generate grocery demand.
- **Leftovers:** Cook once, eat twice -> link meals to earlier prep or cooked dishes and avoid duplicate grocery additions.
- **Per-person variation:** Same meal, different portions -> support a base meal with portion adjustments by member.

## Functional scope
### Household setup
- Family members, age, height, weight, activity level, and goal.
- Hard-no ingredients and general cuisine preferences.
- Recurring participation patterns such as skip, eat outside, and repeating breakfasts.

### Recipe library and ingestion
- Manual recipe creation.
- Copy-paste recipe text import.
- Website URL import in MVP.
- YouTube and Instagram extraction in V2, treated as draft recipes that require user review.

### Weekly planner
- Planner suggests breakfast, lunch, dinner, and snacks across the week.
- User selects from options instead of receiving a fixed imposed plan.
- Nutrition is optimized across the week, not just per meal.

### Batch prep planner
- Suggest prep blocks such as boil lentils, chop vegetables, grill paneer, or cook rice.
- Reuse prep components across multiple meals.
- Help shift effort toward the weekend and reduce weekday friction.

### Grocery engine
- Aggregate ingredients from the approved plan.
- Merge overlapping items and convert units where possible.
- Scale by participants and family quantity needs.
- Support already-have-this flags and later substitutions.

### Learning loop
- Learn from accepted and rejected meals.
- Learn from skipped foods and commonly purchased groceries.
- Start rules-based before attempting heavier ML personalization.

## Non-goals for MVP
- Grocery delivery integrations
- Pantry inventory tracking
- AI chat planner
- Voice interface
- Advanced medical-grade nutrition guidance
- Automatic YouTube / Instagram ingestion without user review

## High-level system architecture
**Recommended stack:** Flutter mobile app, Node.js + TypeScript backend, PostgreSQL database, and Firebase or Supabase for authentication.

### Core layers
- **Mobile app:** onboarding, weekly planning, recipes, grocery list
- **API layer:** user, recipe, planning, grocery endpoints
- **Planning service:** meal ranking and prep suggestions
- **Ingestion service:** parse pasted text and website links
- **Nutrition service:** estimate recipe and weekly totals
- **Grocery service:** merge, scale, and group grocery items
- **Database:** recipes, members, plans, ingredients, prep components

## Core data entities
- **Household:** Top-level container for members and plans.
- **HouseholdMember:** Stores profile, goals, and default participation patterns.
- **Ingredient:** Canonical ingredient with aliases, unit conversions, and nutrition mapping.
- **Recipe:** Structured recipe with ingredients, steps, servings, time, tags, and nutrition estimate.
- **PrepComponent:** Reusable cooked or prepped component such as chopped onions or cooked lentils.
- **WeekPlan:** A weekly planning instance for the household.
- **MealSlot:** A day + meal type combination with participants, recipe, and meal mode.
- **GroceryList:** Merged shopping list derived from the approved plan.

## MVP roadmap
### Phase 0 - Prototype
- Household setup, simple planner, recipe import, grocery generation
- Success signal: users complete a weekly plan

### Phase 1 - MVP app
- Private recipe library, planning engine, prep suggestions, grocery engine
- Success signal: repeat weekly usage and grocery list generation

### Phase 2 - Smarter ingestion
- YouTube import, Instagram import, improved learning
- Success signal: imported recipes are edited and reused

### Phase 3 - Commerce
- Grocery integrations, premium features, advanced prep automation
- Success signal: subscription conversion and retention

## Build difficulty and risk register
- **Ingredient normalization:** messy units and aliases break grocery and nutrition logic -> build a canonical ingredient layer early.
- **Recipe ingestion:** website and video sources are often incomplete or inconsistent -> treat imported items as editable drafts.
- **Weekly ranking:** a good week must balance nutrition, prep effort, and repetition -> start with rules and human-legible heuristics.
- **Prep optimization:** reusability depends on shelf life and recipe metadata -> tag recipes for batch-friendliness and leftovers.
- **Household variation:** different participants per meal create quantity and nutrition edge cases -> model meal participation explicitly in the data model.

## Recommended KPIs
- Weekly plan completion rate
- Grocery list generation rate
- Meal acceptance rate
- Repeat weekly usage
- Number of meals fulfilled using prep components

## Final recommendation
Launch as an Android-first private household planning tool focused on meal suggestions, batch prep, and grocery automation. Do not overbuild AI early. The winning experience will come from practical weekly planning, realistic household handling, and grocery lists that feel trustworthy.
