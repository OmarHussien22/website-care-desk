# Phase 3 — Statistics & Services Sections

**Project**: Medical Ecosystem Landing Page
**Phase**: 3 of N — Statistics (animated metrics) + Services (feature grid)
**Status**: Planned (not yet implemented)
**Depends on**: Phase 2 ([phase_2.md](phase_2.md)) — shell sections (NavBar · Hero · Footer), routing, section-order plumbing must be merged & verified first
**Owner**: Omar
**Date**: 2026-06-02
**Stack**: Flutter (Dart ^3.11.1) · GetX · flutter_screenutil
**Targets**: Web (primary) · iOS · Android · macOS · Windows · Linux

---

## 0. Numbering Reconciliation (read first)

This project carries **two** roadmaps with **non-aligned numbering**:

| Source | "Phase 3" means |
|--------|-----------------|
| `plan.md` (master marketing roadmap) | **Hero Section** (already built — shipped under detailed Phase 2) |
| `project_docs/plans/` detailed series (`phase_1`, `phase_2`) | per `phase_2.md` §18: Logos · Features · How-it-works · For-clinicians · For-patients |

Neither matches this document. Per the **explicit owner decision (2026-06-02)**, detailed **Phase 3 = the first genuinely unbuilt items in the master `plan.md`**, namely:

- **Statistics Section** (`plan.md` Phase 4)
- **Services Section** (`plan.md` Phase 5)

### What happens to the previously-reserved Phase 3 sections?

`phase_2.md` §18 reserved Logos/Features/How-it-works/For-clinicians/For-patients for "Phase 3". Those **remain as the styled placeholders already registered in `landing_page.dart`** and are **reassigned to Phase 4+**. They are *not* dropped and *not* built here. This document supersedes `phase_2.md` §18's Phase-3 line; the canonical order in §6 below is now authoritative.

> **One-line summary for future readers:** "Phase 3 builds Statistics + Services and inserts them right after Hero. The five content sections phase_2.md once called 'Phase 3' slip to Phase 4+ and stay placeholders until then."

---

## 1. Goal

Replace the two top-of-page placeholders nearest the Hero with **real, animated, responsive sections** that establish credibility (Statistics) and explain the offering (Services) before the visitor reaches the deeper content sections.

**Phase 3 ends when** a visitor can:

1. Scroll past the Hero and see a **Statistics band** with four metrics whose numbers **count up** the first time the band scrolls into view.
2. Continue scrolling to a **Services grid** of six cards, each with an icon, title, and description, that **lift on hover** (desktop) and reflow cleanly across all breakpoints.
3. Experience both sections entering with the existing `FadeInOnScroll` motion, with **no horizontal overflow** at any width and **no layout break** at any height.
4. Reach the (still-placeholder) Features / How-it-works / etc. sections below, unchanged.

---

## 2. Non-Goals (Explicitly Out of Scope)

- Features / How-it-works / For-clinicians / For-patients content — **Phase 4** (stay placeholders).
- Pricing / Testimonials / FAQ / CTA content — Phase 4+.
- Real backing numbers from an API — Phase 3 ships **owner-supplied or placeholder constants**; no network calls.
- Per-service detail pages / routing — services are display-only cards in Phase 3.
- Arabic copy — Arabic is still aliased to English (`landingArAE = landingEnUS`); new keys are auto-present in both. RTL audit remains Phase 5.
- Analytics on card interactions — Phase 6.

---

## 3. Inputs Resolved (Propose-and-Flag)

Following `phase_2.md` §3's pattern, these are **proposed defaults**. Each is one line from flipping — flag objections before §10's task list starts.

| # | Question | Proposed default for Phase 3 |
|---|----------|------------------------------|
| Q1 | Where do Statistics & Services slot in? | Honor `plan.md` order: **`stats` immediately after `hero` (§1), `services` after `stats` (§2)**; existing placeholders shift down. See §6. |
| Q2 | What happens to the `logos` placeholder? | **Folded into the Statistics band's trust framing is *not* done here.** `logos` stays a placeholder and shifts to §3 of the order. (Alternative: delete it — flag if preferred.) |
| Q3 | Does the NavBar gain links? | **Add a single `Services` anchor link** to `_navLinks` in `nav_bar.dart` + `_drawerLinks` in `nav_bar_drawer.dart`. Statistics gets **no** nav link (it's a passive band). |
| Q4 | Are the statistics numbers real? | **Placeholder constants** (`250+`, `40k+`, `120+`, `1.2M+`) until product confirms. Flagged in §11. |
| Q5 | How many services, and which? | The six from `plan.md` Phase 5: Doctor Management, Appointment System, Marketplace, Discounts, Analytics, Multi-center support. |
| Q6 | Counter trigger mechanism? | Reuse the existing `visibility_detector` path (same package `FadeInOnScroll` uses) — **count-up fires on scroll-into-view, once**, respecting `MediaQuery.disableAnimations`. No bare timers. |

---

## 4. Requirements Recap (Phase 3)

| ID | Requirement (from `plan.md` Phases 4 & 5) | Phase 3 deliverable |
|----|-------------------------------------------|---------------------|
| R1 | Statistics cards | `stats_section.dart` + `stat_card.dart` |
| R2 | Animated counters | `animated_counter.dart` — visibility-triggered count-up |
| R3 | Icons on stats | `iconsax` (already a dependency) per stat |
| R4 | Responsive grid (stats) | 4-up laptop+, 2×2 tablet, 1-col / 2-col mobile |
| R5 | Scroll animations | Reuse `FadeInOnScroll` with staggered `delay` |
| R6 | Services grid | `services_section.dart` + responsive grid |
| R7 | Service cards | `service_card.dart` (icon · title · description) |
| R8 | Hover interactions | `MouseRegion` lift + shadow, mirroring §9.4 card spec in `phase_2.md` |
| R9 | Service icons & descriptions | per-service icon + `.tr` description |

---

## 5. Statistics Section Specification

### 5.1 Anatomy

A full-width band (not a card row floating in whitespace) sitting directly under the Hero.

```
┌──────────────────────────────────────────────────────────────────────┐
│        [optional eyebrow: "Trusted across the region"]                 │
│                                                                        │
│   ⚕ 250+          👤 40k+          🏥 120+          📅 1.2M+            │
│   Doctors         Patients         Centers          Appointments       │
└──────────────────────────────────────────────────────────────────────┘
```

### 5.2 Stats (placeholder values — see §11)

| Slot | Icon (Material) | Value | Label key | Suffix |
|------|-----------------|-------|-----------|--------|
| Doctors | `Icons.medical_services_rounded` | 250 | `stats.doctors` | `+` |
| Patients | `Icons.groups_rounded` | 40000 | `stats.patients` | `k+` (display 40k+) |
| Centers | `Icons.local_hospital_rounded` | 120 | `stats.centers` | `+` |
| Appointments | `Icons.event_available_rounded` | 1200000 | `stats.appointments` | `M+` (display 1.2M+) |

> **Icon convention:** Landing code uses **Material `Icons.*`** throughout (see `nav_bar.dart`, `nav_bar_drawer.dart`). `iconsax` is declared in `pubspec.yaml` but is **not** used anywhere under `lib/src/landing/`, so Phase 3 stays on Material icons to read like the surrounding code.

> Display formatting (`40000 → "40k+"`) is computed in `animated_counter.dart`; the raw target int drives the count-up, a formatter maps int→string each tick.

### 5.3 Responsive grid

| Breakpoint | Layout |
|------------|--------|
| laptop / desktop / ultraWide | 4 columns in a single `Row` (each `Expanded`) |
| tablet | 2×2 (`Wrap` or `GridView`-like, two per line) |
| mobile | 2×2 if it fits at 360px without overflow; else single column |

Use `ResponsiveBuilder` or branch on `ScreenSizeX.of(context)`. Gaps via `AppSpacing` tokens (no raw px).

### 5.4 Animated counter behavior

- A `StatefulWidget` `AnimatedCounter` wrapping each value.
- Wrap the section (or each card) in `VisibilityDetector` (the package `FadeInOnScroll` already uses). On first `visibleFraction > 0.05`, run an `AnimationController` (≈1200ms, `Curves.easeOutCubic`) tweening `0 → target`.
- `MediaQuery.disableAnimations` → render the final value immediately (mirror `FadeInOnScroll`'s guard).
- Fires **once** (latch a `_triggered` bool), exactly like `FadeInOnScroll._onVisibilityChanged`.
- Dispose the controller in `dispose()`.

### 5.5 Section entrance & section wrapper

- `SectionWrapper(sectionKey: _key, background: LandingColors.surfaceMuted, ...)` — alternating background relative to the white Hero/sections around it.
- Self-register anchor id `stats` with `LandingScrollController` in a post-frame callback; unregister in `dispose` (copy the `PlaceholderSection` lifecycle pattern).
- Wrapped in `FadeInOnScroll` at the `landing_page.dart` sliver level (consistent with siblings). Per-card stagger via `FadeInOnScroll(delay: ...)` is optional polish.

---

## 6. Canonical Section Order (updated — authoritative)

Supersedes `phase_2.md` §8. Two new ids inserted after `hero`; everything below shifts down.

| # | Section id | Phase 3 status | Owner phase | Nav link? |
|--:|------------|----------------|-------------|-----------|
| 0 | `hero` | Built | Phase 2 | (logo → hero) |
| 1 | `stats` | **BUILD THIS PHASE** | Phase 3 | no |
| 2 | `services` | **BUILD THIS PHASE** | Phase 3 | **yes (new)** |
| 3 | `logos` | Placeholder | Phase 4 | no |
| 4 | `features` | Placeholder | Phase 4 | yes (existing) |
| 5 | `how-it-works` | Placeholder | Phase 4 | yes (existing) |
| 6 | `for-clinicians` | Placeholder | Phase 4 | yes (existing) |
| 7 | `for-patients` | Placeholder | Phase 4 | no |
| 8 | `pricing` | Placeholder | Phase 4 | yes (existing) |
| 9 | `testimonials` | Placeholder | Phase 4 | no |
| 10 | `faq` | Placeholder | Phase 4 | yes (existing) |
| 11 | `cta` | Placeholder | Phase 4 | no |
| 12 | `footer` | Built | Phase 2 | no |

### 6.1 `landing_page.dart` integration (concrete)

Insert two new slivers between the Hero (`§ 0`) and the Logos placeholder (`§ 1`):

```dart
// § 0 — Hero
const SliverToBoxAdapter(child: HeroSection()),

// § 1 — Statistics (Phase 3)  ← NEW
SliverToBoxAdapter(
  child: FadeInOnScroll(child: const StatsSection()),
),

// § 2 — Services (Phase 3)    ← NEW
SliverToBoxAdapter(
  child: FadeInOnScroll(child: const ServicesSection()),
),

// § 3 — Logos strip (now Phase 4)
SliverToBoxAdapter(
  child: FadeInOnScroll(
    child: PlaceholderSection(
      sectionId: 'logos',
      background: LandingColors.surfaceMuted,
    ),
  ),
),
// … remaining placeholders unchanged …
```

Background alternation after insertion: Hero (gradient) → `stats` (`surfaceMuted`) → `services` (`surfaceElevated`/white) → `logos` (`surfaceMuted`) → … Keep the alternation reading top-to-bottom; adjust the `background:` on the shifted placeholders **only if** two adjacent sections end up the same color.

### 6.2 `placeholder_section.dart` map updates

`stats` and `services` graduate **out of** the placeholder system (they become real sections), so they do **not** need entries in `_sectionIndex` / `_sectionTitle`. However, the existing entries still index `logos:1, features:2, …`. Re-number those maps so the "01/02/…" badges on the remaining placeholders stay sensible relative to the new order (logos now reads later). This is cosmetic-only (the badge number on a "coming soon" panel) — low risk, but update it for consistency.

### 6.3 NavBar link (Q3)

Add `(labelKey: 'nav.services', sectionId: 'services')` to:
- `_navLinks` in `nav_bar.dart` (desktop)
- `_drawerLinks` in `nav_bar_drawer.dart` (mobile)

Place it first (before `nav.features`) to match scroll order. No stats link.

---

## 7. Services Section Specification

### 7.1 Anatomy

```
┌──────────────────────────────────────────────────────────────────────┐
│                    [eyebrow]  Everything your practice needs           │
│             One platform — clinical, operational, commercial.          │
│                                                                        │
│   ┌──────────┐  ┌──────────┐  ┌──────────┐                            │
│   │ 🩺 Doctor │  │ 📅 Appt   │  │ 🛒 Market │                           │
│   │ Mgmt      │  │ System    │  │ place     │                           │
│   │ desc…     │  │ desc…     │  │ desc…     │                           │
│   └──────────┘  └──────────┘  └──────────┘                            │
│   ┌──────────┐  ┌──────────┐  ┌──────────┐                            │
│   │ 🏷 Disc.  │  │ 📊 Analy. │  │ 🏥 Multi  │                           │
│   └──────────┘  └──────────┘  └──────────┘                            │
└──────────────────────────────────────────────────────────────────────┘
```

### 7.2 Services (6 cards)

| Icon (Material) | Title key | Description key |
|-----------------|-----------|-----------------|
| `Icons.medical_services_rounded` | `services.doctor_mgmt.title` | `services.doctor_mgmt.desc` |
| `Icons.calendar_month_rounded` | `services.appointments.title` | `services.appointments.desc` |
| `Icons.storefront_rounded` | `services.marketplace.title` | `services.marketplace.desc` |
| `Icons.local_offer_rounded` | `services.discounts.title` | `services.discounts.desc` |
| `Icons.insights_rounded` | `services.analytics.title` | `services.analytics.desc` |
| `Icons.apartment_rounded` | `services.multicenter.title` | `services.multicenter.desc` |

### 7.3 Responsive grid

| Breakpoint | Columns |
|------------|---------|
| desktop / ultraWide | 3 |
| laptop | 3 |
| tablet | 2 |
| mobile | 1 |

Implement with `Wrap` (compute item width from available width ÷ columns minus gaps) or `LayoutBuilder` + `GridView` with `shrinkWrap` inside the sliver. **Prefer `Wrap`** to avoid nested-scroll friction inside `CustomScrollView`. Gaps via `AppSpacing.md`/`lg`.

### 7.4 Service card spec (honors `phase_2.md` §9.4)

- Radius `16`, padding `AppSpacing.md`–`lg`.
- Default shadow `0 1px 3px rgba(15,23,42,0.06)`; **hover lift** `0 8px 24px rgba(15,23,42,0.10)` + `translateY(-4px)`, 160ms `easeOutCubic` — same idiom as `_CtaButton` in `nav_bar.dart`.
- Icon in a gradient-tinted rounded badge (reuse the `_NumberBadge` treatment from `placeholder_section.dart`: `accentGradient` @ ~10% fill, `ShaderMask` icon).
- Title: `CustomText` `role: TextRole.headingMD`, `FW.bold`, `Montserrat`, `textPrimary`.
- Description: `CustomText` `role: TextRole.bodyMD`, `textSecondary`, 2–3 lines.

> `TextRole` members available (`text_role.dart`): `displayXL, displayLG, headingLG, headingMD, headingSM, bodyLG, bodyMD, bodySM, caption, button`.
- Hover only meaningful on pointer devices; touch devices simply show the default state (no tap action in Phase 3).
- Wrap interactive surface in `MouseRegion(cursor: SystemMouseCursors.click)` + `Semantics(label: title)` even though non-navigating, for a11y consistency.

### 7.5 Section wrapper & entrance

- `SectionWrapper(sectionKey: _key, background: <white/surfaceElevated>)`, register anchor `services`.
- Section header (eyebrow + title + subtitle) above the grid, reusing the eyebrow-chip idiom from `hero_content.dart` (but on a light background → use `accent`-tinted chip, not white-on-gradient).
- `FadeInOnScroll` at sliver level; optional per-card stagger via incremental `delay`.

---

## 8. Data & i18n

### 8.1 Data location

Create `lib/src/landing/data/landing_metrics.dart` (sibling of existing `landing_brand.dart`) holding:

- `const List<StatItem>` — `(iconData, targetValue, labelKey, formatter)`.
- `const List<ServiceItem>` — `(iconData, titleKey, descKey)`.

Keeping the lists in `data/` (not inline in the widget) matches `phase_2.md`'s `landing_brand.dart` convention and Constitution II (feature-first; constants in `data/`). `IconData` lives in data here because these are static UI catalogs, not domain entities — acceptable for a landing page (note in §9).

### 8.2 New i18n keys (`landing_translations.dart`, `<section>.<element>`)

Append to `landingEnUS` (Arabic auto-inherits via `landingArAE = landingEnUS`):

```dart
// ── Statistics ──
'stats.eyebrow': 'Trusted across the region',
'stats.doctors': 'Doctors',
'stats.patients': 'Patients',
'stats.centers': 'Centers',
'stats.appointments': 'Appointments',

// ── Services ──
'nav.services': 'Services',
'services.eyebrow': 'What we offer',
'services.title': 'Everything your practice needs',
'services.subtitle': 'One platform — clinical, operational, and commercial.',
'services.doctor_mgmt.title': 'Doctor Management',
'services.doctor_mgmt.desc': 'Onboard, schedule, and manage your clinical team in one place.',
'services.appointments.title': 'Appointment System',
'services.appointments.desc': 'Online booking, reminders, and a live calendar across centers.',
'services.marketplace.title': 'Marketplace',
'services.marketplace.desc': 'List products and services patients can discover and buy.',
'services.discounts.title': 'Discounts',
'services.discounts.desc': 'Create offers and promo codes to grow patient loyalty.',
'services.analytics.title': 'Analytics',
'services.analytics.desc': 'Track revenue, bookings, and performance in real time.',
'services.multicenter.title': 'Multi-center Support',
'services.multicenter.desc': 'Run multiple branches from a single unified dashboard.',
```

> Copy is placeholder/product-owned; keys are stable.

---

## 9. Folder Structure Additions

Phase 3 deltas only (builds on Phase 2 layout):

```text
lib/src/landing/
  core/
    animations/
      animated_counter.dart                ← NEW: visibility-triggered count-up
  data/
    landing_metrics.dart                   ← NEW: StatItem + ServiceItem catalogs
  presentation/
    sections/
      stats/
        stats_section.dart                 ← NEW: SectionWrapper(id: 'stats')
        widgets/
          stat_card.dart                   ← NEW: icon + animated value + label
      services/
        services_section.dart              ← NEW: SectionWrapper(id: 'services')
        widgets/
          service_card.dart                ← NEW: icon + title + desc + hover lift
          services_header.dart             ← NEW: eyebrow + title + subtitle (optional split)
      sections.dart                        ← UPDATE: export stats + services
    pages/
      landing_page.dart                    ← UPDATE: insert two slivers (§6.1)
    widgets/organisms/
      nav_bar.dart                         ← UPDATE: add 'services' to _navLinks
      nav_bar_drawer.dart                  ← UPDATE: add 'services' to _drawerLinks
    sections/placeholders/
      placeholder_section.dart             ← UPDATE: re-number _sectionIndex/_sectionTitle
  core/i18n/
    landing_translations.dart              ← UPDATE: append stats.* / services.* keys
```

No new assets required (icons are Material `Icons.*`, built in). No `pubspec.yaml` change required — `visibility_detector: ^0.4.0+2` (used by `FadeInOnScroll`) is already declared and confirmed present.

---

## 10. Implementation Task Breakdown

Suggested order. Group B and C can run in parallel after A.

**Group A — Foundation (blocks B & C)**

1. ✅ Create `landing_metrics.dart` (`StatItem`, `ServiceItem` + the two catalogs).
2. ✅ Append `stats.*` / `services.*` / `nav.services` keys to `landing_translations.dart`.
3. ✅ Create `animated_counter.dart` (visibility-triggered, disable-animations guard, int→display formatter via `compactCount`).

**Group B — Statistics section**

4. ✅ `stat_card.dart` — icon badge + `AnimatedCounter` + label.
5. ✅ `stats_section.dart` — `SectionWrapper(id: 'stats')`, responsive grid (Row-of-4 laptop+, computed 2-col tablet/mobile), anchor registration.
6. ✅ Wire into `landing_page.dart` as new § 1 sliver.

**Group C — Services section**

7. ✅ `service_card.dart` — hover lift + icon badge + title + desc + Semantics.
8. ✅ Services header — eyebrow/title/subtitle (inlined in `services_section.dart`).
9. ✅ `services_section.dart` — `SectionWrapper(id: 'services')`, responsive `Wrap` grid (3/2/1 cols via computed widths), anchor registration.
10. ✅ Wire into `landing_page.dart` as new § 2 sliver.

**Group D — Navigation & order**

11. ✅ Add `services` link to `_navLinks` (`nav_bar.dart`) and `_drawerLinks` (`nav_bar_drawer.dart`).
12. ✅ Re-number `_sectionIndex` in `placeholder_section.dart`; background alternation reads cleanly (services white → logos muted → …).
13. ✅ Update `sections.dart` barrel exports.

**Group E — Verification & polish**

14. ✅ `flutter analyze` clean (zero errors/warnings in new files; only project-wide relative-import info lints remain). Web debug build compiles end-to-end.
15. ⬜ Breakpoint sweep 360 / 480 / 768 / 1024 / 1280 / 1440 / 1600 / 1920 / 2400 px — no horizontal overflow. *(manual — `flutter run -d chrome`)*
16. ⬜ Counter fires once on scroll-into-view; re-scrolling does not re-trigger. *(manual)*
17. ⬜ Counter renders final value instantly under `MediaQuery.disableAnimations`. *(manual / test)*
18. ⬜ Services hover lift on desktop; graceful static state on touch. *(manual)*
19. ⬜ NavBar `Services` link scrolls to the section; active-highlight works. *(manual)*
20. ⬜ Anchor registration: deep-link `/#services` jumps correctly (web). *(manual)*

Estimated effort: **2–3 working days** for one engineer.

---

## 11. Constitution Compliance Check

Per `.specify/memory/constitution.md`:

| Principle | How Phase 3 honors it |
|-----------|----------------------|
| I. GetX state & nav | Sections self-register with `LandingScrollController` (GetX); no new routing; no go_router. Counters use local `AnimationController` (UI-only state — no controller needed). |
| II. Feature-first clean arch | New code under `landing/`; static catalogs in `data/landing_metrics.dart`; no API → no repo/usecase. `IconData` in data is an accepted exception for static UI catalogs (no domain entity). |
| III. Type & null safety | No `!` on reactive values; `AnimationController` disposed in `dispose()`; `VisibilityDetector` latch prevents double-fire. |
| IV. UI & styling discipline | `AppSpacing` tokens (no raw px for layout gaps), `LandingColors.*`, `CustomText` w/ `role` (no raw `Text` except where Phase 2 hero already does for gradient spans), radius via shared idiom. |
| V. Observability | Anchor mis-registration / unknown id paths logged via `log(..., name: ...)`; no `print`. |
| VI. Testability & app modes | Stat targets & service list externalized in `landing_metrics.dart` so tests can stub; `disableAnimations` path makes counters deterministic under test. |
| VII. Quality gate | `flutter analyze .` zero errors before merge; new anchor ids verified. |

No anticipated violations. Complexity Tracking entries: **none**.

---

## 12. Acceptance Criteria (Definition of Done)

### 12.1 Statistics
- [ ] Four metrics render with icon + value + label across all breakpoints.
- [ ] Numbers count up from 0 → target on first scroll-into-view, once only.
- [ ] Final values shown instantly when `MediaQuery.disableAnimations` is true.
- [ ] 4-up at laptop+, 2×2 at tablet, no overflow at 360px.
- [ ] Section registered as anchor `stats`; entrance via `FadeInOnScroll`.

### 12.2 Services
- [ ] Six cards render with icon, title, description across all breakpoints.
- [ ] 3-col laptop+, 2-col tablet, 1-col mobile; no horizontal overflow.
- [ ] Hover lift + shadow on desktop; static, non-broken state on touch.
- [ ] Section registered as anchor `services`; entrance via `FadeInOnScroll`.

### 12.3 Navigation & order
- [ ] `Services` link present in desktop nav and mobile drawer; scrolls to section.
- [ ] Active-section highlight works for `services`.
- [ ] Canonical order matches §6; background alternation reads cleanly top-to-bottom.
- [ ] Shifted placeholders (`logos` … `cta`) still render and scroll correctly.

### 12.4 i18n & quality
- [ ] Every new visible string flows through `.tr` with a key in `landing_translations.dart`.
- [ ] `flutter analyze .` returns zero errors/warnings in new files.
- [ ] No `print()`, no raw layout-pixel literals, all `AnimationController`s disposed.

---

## 13. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------:|-------:|------------|
| Counter re-fires on every scroll past, looking janky | Medium | Medium | Latch `_triggered` bool exactly like `FadeInOnScroll`; verify in §10 task 16. |
| `Wrap`/`GridView` inside `CustomScrollView` causes nested-scroll or unbounded-height errors | Medium | High | Use `Wrap` with computed item widths (no inner scrollable); never an unbounded `GridView`. |
| Stats overflow at 360px in 2×2 | Medium | Medium | Fall back to single column on mobile if 2×2 measures > viewport; test at 360. |
| Background alternation collides after inserting two sections | Medium | Low | §6.1 re-checks adjacency; flip a `background:` if two neighbors match. |
| Placeholder badge numbers (`01/02…`) now misleading after re-order | Low | Low | Re-number maps in task 12; cosmetic only. |
| Hover effects misfire on hybrid touch+pointer devices | Low | Low | Drive hover purely from `MouseRegion`; default state is always valid. |
| A proposed Material icon name doesn't exist / reads poorly | Low | Low | All names in §5.2/§7.2 are standard Material symbols; confirm at build and swap to the nearest match if any is off. |

---

## 14. Open Questions (resolve before / during Group A)

1. **Real statistics numbers** — §5.2 uses placeholders (`250+`, `40k+`, `120+`, `1.2M+`). Product must confirm real figures before public release.
2. **`logos` placeholder fate** — keep as Phase-4 placeholder (default) or delete now? (Q2)
3. **Services count/labels** — six per `plan.md`; confirm none added/removed.
4. **Final icon choices** — proposed Material symbols in §5.2 / §7.2 are reasonable defaults; confirm they read well or pick alternatives (stay on Material `Icons.*` to match landing convention).
5. **Service card tap behavior** — display-only in Phase 3; confirm no link/scroll target is wanted yet.
6. **Services subtitle copy** — placeholder; product-review before release.

---

## 15. Out of Scope — Reserved for Later Phases

| Phase | Scope (tentative, post-reconciliation) |
|-------|----------------------------------------|
| Phase 4 | Logos strip, Features, How it works, For clinicians, For patients (the sections phase_2.md §18 had called "Phase 3"), plus Pricing/Testimonials/FAQ/CTA as scope allows |
| Phase 5 | Arabic + RTL audit, visible dark-mode toggle, language toggle in NavBar/Footer |
| Phase 6 | Lead-capture forms, analytics events, real CTA destinations, live stats from API |
| Phase 7 | SEO meta, Open Graph, Lighthouse ≥ 95 |

---

## 16. References

- [phase_1.md](phase_1.md) — Foundation & Architecture.
- [phase_2.md](phase_2.md) — Shell sections, NavBar, Hero, Footer, routing (§8 section order superseded by §6 here; §18 Phase-3 line superseded by §0 here).
- `plan.md` — master marketing roadmap (Phase 4 = Statistics, Phase 5 = Services).
- `.specify/memory/constitution.md` — Principles I–VII.
- Existing code idioms reused: `SectionWrapper`, `FadeInOnScroll`, `Responsive<T>`/`ResponsiveBuilder`, `AppSpacing`, `LandingColors`, `CustomText`, `PlaceholderSection` (anchor lifecycle), `_NumberBadge` (icon badge), `_CtaButton` (hover lift).

---

**End of Phase 3 plan. No implementation begins until this document is approved. Resolve §14 Q1 (real numbers) and Q4 (icon symbols) before Group A.**
