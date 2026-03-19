# Design System — Plateful

## Product Context
- **What this is:** A household meal planning web app that suggests balanced weekly meals, optimizes batch prep, and auto-generates grocery lists. Built for Indian/Asian food preferences with high-protein bias.
- **Who it's for:** Indian families managing daily cooking — primarily the household member who plans and preps meals. Non-technical users who want something that feels warm and personal, not clinical.
- **Space/industry:** Meal planning & recipe management. Peers: Mealime, Eat This Much, Whisk, Plan to Eat, MealPrepPro, Paprika.
- **Project type:** Mobile-first progressive web app (PWA)

## Aesthetic Direction
- **Direction:** Organic/Natural
- **Decoration level:** Intentional — subtle warmth through color and rounded forms, not heavy ornamentation. Emoji as food-category icons (not custom illustrations).
- **Mood:** Warm kitchen, not sterile dashboard. The app should feel like opening a recipe notebook at a wooden table — earthy, inviting, personal. Professional enough to trust with your weekly plan, cozy enough that you enjoy using it on a lazy Sunday afternoon.
- **Reference sites:** Competitive research found the meal planning space converges heavily on green/teal/white palettes (Mealime, Whisk, Eat This Much). Plateful's terracotta-forward palette is a genuine differentiator — it reads as "Indian kitchen" rather than "Silicon Valley health app."

## Typography

### Font Stack
- **Display/Hero:** Nunito 800 — Rounded terminals feel organic and approachable without being childish. The extra-bold weight commands hierarchy on page titles and empty-state headings.
- **Body:** Nunito 400 — Same family maintains visual cohesion. The rounded letterforms stay comfortable at paragraph length, and the x-height gives good readability on mobile.
- **UI/Labels:** Nunito 600 — Semi-bold for buttons, nav links, chip labels, and form labels. Distinct from body weight without needing a second typeface.
- **Data/Tables:** JetBrains Mono 400 — Tabular figures for nutrition values, quantities, and analytics numbers. Monospace alignment makes columns scan instantly. Use sparingly — only where numerical alignment matters.
- **Code:** JetBrains Mono 400
- **Loading:** Google Fonts CDN
  ```html
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  ```

### Type Scale
| Token | Size | Weight | Use |
|-------|------|--------|-----|
| 3xl | 30px / 1.875rem | 800 | Page titles, hero headings |
| 2xl | 24px / 1.5rem | 700 | Section headings |
| xl | 20px / 1.25rem | 700 | Subsection headings, card titles |
| lg | 18px / 1.125rem | 700 | Feature headings, modal titles |
| base | 16px / 1rem | 400 | Body text, descriptions |
| sm | 14px / 0.875rem | 600 | Buttons, nav links, form labels, chips |
| xs | 12px / 0.75rem | 400-600 | Captions, timestamps, meta text |

### Typography Rules
- Line height: 1.2 for headings, 1.6-1.7 for body
- Never set body text below 14px on mobile
- JetBrains Mono is ONLY for numerical data display — never for headings or body
- Nunito covers display through UI labels — no third typeface needed

## Color

### Approach
Balanced — primary (terracotta) + secondary (sage) + accent (mustard), with semantic colors for system feedback. Color is used meaningfully for hierarchy, not decoration.

### Core Palette
| Token | Hex | Usage | Contrast on White |
|-------|-----|-------|--------------------|
| `primary` | #E07A5F | Main actions, active nav, links, focus rings | 3.33:1 — FAILS AA text. Use for large text (18px+), icons, or backgrounds only |
| `primary-dark` | #C4603F | Text-safe primary. Use wherever primary text must pass AA | 5.09:1 — PASSES AA |
| `primary-light` | #F0A08A | Primary backgrounds (10% opacity), hover tints | Decorative only |
| `secondary` | #81B29A | Success-adjacent actions, veg badges, completion indicators | 2.79:1 — decorative only |
| `secondary-dark` | #5E9478 | Text-safe secondary | 4.18:1 — PASSES AA for large text |
| `secondary-light` | #A8D4BE | Secondary backgrounds, hover fills | Decorative only |
| `accent` | #F2CC8F | Highlights, mustard warmth, star ratings, warning-adjacent | Decorative only |
| `accent-dark` | #E0B56E | Accent on white backgrounds | Decorative only |
| `accent-light` | #F7DEB3 | Warm background tints | Decorative only |
| `cream` | #FEFAE0 | Page background, warm surface base | N/A (background) |
| `surface` | #FFFFFF | Card backgrounds, elevated surfaces | N/A (background) |
| `ink` | #3D405B | Primary text, headings | 9.47:1 — PASSES AAA |
| `ink-muted` | #6B7280 | Secondary text, descriptions, meta | 4.64:1 — PASSES AA |
| `ink-light` | #9CA3AF | Placeholder text, disabled states, borders | 3.01:1 — FAILS AA. Use ONLY for placeholders and decorative borders, never for readable text |

### Semantic Colors
| Token | Hex | Background | Text-safe |
|-------|-----|------------|-----------|
| `success` | #10B981 | #ECFDF5 | #065F46 |
| `warning` | #F59E0B | #FFFBEB | #92400E |
| `error` | #EF4444 | #FEF2F2 | #991B1B |
| `info` | #3B82F6 | #EFF6FF | #1E40AF |

### Accessibility Contract
- **All readable text must meet WCAG AA (4.5:1).** Use `primary-dark` (#C4603F) instead of `primary` (#E07A5F) for text.
- **`ink-light` (#9CA3AF) is NOT text-safe.** Use only for placeholders, decorative borders, and disabled states.
- **Large text (18px+ bold, 24px+ regular)** may use `primary` (#E07A5F) at its native 3.33:1 ratio.
- **Interactive elements** must show visible focus rings: `box-shadow: 0 0 0 3px rgba(224,122,95,0.15)` on focus.

### Dark Mode Strategy
When dark mode is implemented:
- Surfaces: cream → #1a1a2e, surface → #252540
- Text: ink → #E8E8ED
- Bump primary saturation slightly: #E07A5F → #E8927A
- Reduce shadow opacity, increase shadow spread
- All semantic background colors need dark variants

## Spacing

### Base Unit
4px — allows finer control than 8px for compact mobile layouts like chip rows and recipe meta.

### Density
Comfortable — generous padding on cards and sections, tighter spacing within component groups (chip rows, stat grids).

### Scale
| Token | Value | Common Use |
|-------|-------|------------|
| `2xs` | 2px | Hairline gaps, icon-to-text micro-gap |
| `xs` | 4px | Chip internal padding, tight inline spacing |
| `sm` | 8px | Inner card padding, input padding, between related items |
| `md` | 16px | Standard card padding, section internal spacing |
| `lg` | 24px | Between sections, major layout gaps |
| `xl` | 32px | Page-level vertical rhythm |
| `2xl` | 48px | Hero padding, major section separators |
| `3xl` | 64px | Page top/bottom padding |

### Touch Targets
- Minimum 44x44px for all interactive elements (buttons, links, checkboxes, toggles)
- Nav links currently at `px-3 py-1.5` — needs padding increase to meet 44px height
- Chip minimum height: 44px (currently under-sized — flagged as design debt)

## Layout

### Approach
Grid-disciplined — strict columns and predictable alignment. No creative/editorial asymmetry. This is a utility app, not a magazine.

### Grid
| Breakpoint | Columns | Behavior |
|------------|---------|----------|
| Mobile (<640px) | 1 column, full bleed cards | Stack everything vertically |
| Tablet (640-1024px) | 2 columns for recipe grid, 1 column for forms | Side-by-side where density helps |
| Desktop (1024px+) | 3-4 columns for recipe grid, sidebar potential | Max density, nav becomes horizontal bar |

### Container
- Max content width: `max-w-5xl` (1024px) — matches existing header component
- Horizontal padding: 16px (mobile), auto-centered on larger screens

### Border Radius Scale
| Token | Value | Use |
|-------|-------|-----|
| `sm` | 4px | Small elements: badges, inline tags |
| `md` | 8px | Inputs, alerts, small cards |
| `lg` | 12px | Buttons, chips, medium components |
| `xl` | 16px | Cards, modals, major surfaces (`rounded-xl`) |
| `full` | 9999px | Pills, toggle tracks, avatars |

### Shadows
| Token | Value | Use |
|-------|-------|-----|
| `sm` | `0 1px 2px rgba(61,64,91,0.06)` | Cards at rest, inputs |
| `md` | `0 4px 12px rgba(61,64,91,0.08)` | Cards on hover, dropdowns |
| `lg` | `0 8px 24px rgba(61,64,91,0.12)` | Modals, elevated surfaces |

Shadow base color uses ink (#3D405B) RGB values for warm-tinted shadows that match the palette.

## Motion

### Approach
Minimal-functional — transitions that aid comprehension, not decoration. No bounce, no spring, no scroll-driven choreography.

### Easing
| Token | Curve | Use |
|-------|-------|-----|
| `ease-enter` | `cubic-bezier(0, 0, 0.2, 1)` | Elements appearing (modals, toasts, dropdowns) |
| `ease-exit` | `cubic-bezier(0.4, 0, 1, 1)` | Elements disappearing |
| `ease-move` | `cubic-bezier(0.4, 0, 0.2, 1)` | State changes (hover, focus, color transitions) |

### Duration
| Token | Value | Use |
|-------|-------|-----|
| `micro` | 100ms | Hover color changes, focus rings |
| `short` | 200ms | Button state transitions, input focus |
| `medium` | 300ms | Modal open/close, dropdown expand |

### What Gets Motion
- Hover/focus state changes on buttons, links, cards
- Modal/drawer open/close
- Toast/alert entrance

### What Does NOT Get Motion
- Page transitions (rely on browser default)
- List reordering
- Data loading (use skeleton/shimmer, not entrance animations)
- Scroll-triggered reveals

## Component Patterns (Existing)

These patterns exist in the codebase and should be followed for consistency:

| Pattern | Implementation | Files |
|---------|---------------|-------|
| Recipe cards | `rounded-xl` surface cards with emoji header, title, meta row, badge | `global-recipe-browse-grid.tsx` |
| Stat cards | Emoji icon + large number + label, `rounded-xl` bordered | `analytics-dashboard.tsx` |
| Filter chips | Pill-shaped, `rounded-full`, active state uses `primary` bg + white text | `global-recipe-browse-grid.tsx` |
| Dietary toggle | Segmented control (All/Veg/Non-Veg), cream background, active gets surface bg | `global-recipe-browse-grid.tsx` |
| Toggle switch | Custom track+thumb, `primary` when on, `ink-light` when off | `rules-manager.tsx` |
| Form inputs | `rounded-lg` border, focus ring with primary tint, placeholder in `ink-light` | Various |
| Navigation | Horizontal nav bar (desktop), hamburger drawer (mobile), active link gets `primary/10` bg | `header.tsx` |
| Empty states | Centered emoji + heading + description + CTA button | Various |
| Alert/toast | Rounded rectangle with semantic bg color + dark text variant | Proposed (currently uses `alert()`) |
| Delete confirmation | Modal dialog with destructive red button + cancel | `rules-manager.tsx` |

## Design Debt

Known issues to address in future implementation sprints:

| # | Issue | Impact | Fix |
|---|-------|--------|-----|
| 1 | `alert()` for errors | Breaks mobile UX, no styling control | Replace with toast/inline alert component |
| 2 | Primary text contrast | #E07A5F fails AA at 3.33:1 | Use `primary-dark` (#C4603F) for all text; reserve `primary` for backgrounds/large text |
| 3 | ink-light text contrast | #9CA3AF fails AA at 3.01:1 | Restrict to placeholders/decorative only; use `ink-muted` for readable secondary text |
| 4 | Touch targets under 44px | Nav links, chips below minimum | Increase padding to meet 44px minimum interactive size |
| 5 | 7 nav items on tablet | Crowded at 640-1024px | Group to 5 visible items (combine Nutrition→Analytics, Prep→Planner) or use overflow menu |
| 6 | Zero-state display | Analytics shows "0" for empty stats | Show "—" or motivational text ("Cook your first recipe!") |
| 7 | No loading skeletons | Components show nothing while fetching | Add shimmer/skeleton variants for recipe grid, stat cards, planner |
| 8 | No JetBrains Mono loaded | Data font not in current font stack | Add to `layout.tsx` Google Fonts link and Tailwind config |

## Not In Scope
- Dark mode implementation (design tokens defined above, implementation deferred)
- Animation library (Framer Motion, etc.) — use CSS transitions only
- Multi-language/i18n typography adjustments
- Custom illustration system (emoji serves as icon system for now)
- Print stylesheet
- Native app design tokens (this is web-only)

## Decisions Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-03-19 | Organic/Natural aesthetic | Matches food domain; terracotta palette evokes Indian kitchen warmth. Differentiates from green/teal competitors. |
| 2026-03-19 | Nunito as sole display+body font | Already in codebase. Rounded terminals match organic aesthetic. One font family = simpler loading. |
| 2026-03-19 | JetBrains Mono for data only | Tabular figures needed for nutrition/quantity alignment. Strict scope prevents overuse. |
| 2026-03-19 | 4px spacing base | Finer control than 8px for mobile-dense layouts (chip rows, recipe meta). Comfortable density overall. |
| 2026-03-19 | primary-dark for text contrast | Primary (#E07A5F) fails WCAG AA. Darker variant (#C4603F) passes at 5.09:1. Document as hard rule. |
| 2026-03-19 | Minimal-functional motion | Utility app — motion should clarify state changes, not entertain. No spring/bounce physics. |
| 2026-03-19 | Grid-disciplined layout | Meal planning is structured data. Predictable alignment over creative asymmetry. max-w-5xl container. |
| 2026-03-19 | Bottom sheet on mobile, modal on desktop | Rule editor and recipe detail need full-screen on mobile. Sheet pattern is thumb-friendly. |
| 2026-03-19 | Rule conflict indicator | When meal rules conflict, show inline warning with amber badge. Users need to know before save. |
| 2026-03-19 | Onboarding requires min 1 recipe | Users must import at least 1 recipe before completing onboarding. Empty planner has no value. |
| 2026-03-19 | Design system created | Created by /design-consultation based on competitive research (Mealime, Whisk, Eat This Much, etc.) and existing codebase analysis. |

## Preview
A visual preview of this design system is available at `design-preview.html` in the project root. Open it in a browser to see colors, typography, components, and product mockups rendered together.
