# Phase 4 — Content Sections: Logos · Features · How-it-works · For-clinicians · For-patients

**Project**: Medical Ecosystem Landing Page
**Phase**: 4 of N — The five mid-page content sections currently rendered as styled placeholders
**Status**: Planned (not yet implemented)
**Depends on**: Phase 3 ([phase_3.md](phase_3.md)) — Statistics + Services must be merged & verified first
**Owner**: Omar
**Date**: 2026-06-02
**Stack**: Flutter (Dart ^3.11.1) · GetX · flutter_screenutil
**Targets**: Web (primary) · iOS · Android · macOS · Windows · Linux

---

## 0. Numbering Reconciliation (read first)

This project carries **two** roadmaps with **non-aligned numbering**. This continues the pattern established in [phase_3.md](phase_3.md) §0.

| Source | "Phase 4" means |
|--------|-----------------|
| `plan.md` (master marketing roadmap) | **Statistics Section** — already shipped under detailed Phase 3 |
| `project_docs/plans/` detailed series | **The five placeholder content sections** that `phase_2.md` §18 once called "Phase 3" and `phase_3.md` §10/§15 explicitly reassigned to Phase 4 |

Per the **explicit owner decision (2026-06-02)** recorded in `phase_3.md` §0 and §15, detailed **Phase 4 = the first genuinely unbuilt items still rendering as `PlaceholderSection`**, namely (in scroll order):

- **Logos strip** (`logos`)
- **Features** (`features` — `plan.md` Phase 6)
- **How it works** (`how-it-works` — `plan.md` Phase 8)
- **For clinicians** (`for-clinicians`)
- **For patients** (`for-patients`)

### Scope decision: the five named sections only

`phase_3.md` §15 lists Phase 4 as "the five sections … **plus** Pricing/Testimonials/FAQ/CTA *as scope allows*." Phase 4 **commits to the five named content sections** and **explicitly defers** Pricing / Testimonials / FAQ / CTA to **Phase 5**. Rationale:

- Every prior detailed phase shipped 2–3 sections (`phase_2` = NavBar+Hero+Footer, `phase_3` = Stats+Services). Cramming nine sections into one doc breaks that granularity and buries the work.
- `for-clinicians` / `for-patients` are richer (alternating media+copy rows) than a simple card grid — they carry real weight.
- Pricing and Testimonials each deserve their own data model and acceptance criteria.

> **One-line summary for future readers:** "Phase 4 turns the five placeholders nearest the Services section — Logos, Features, How-it-works, For-clinicians, For-patients — into real sections. Pricing/Testimonials/FAQ/CTA stay placeholders and move to Phase 5."

This document **supersedes** `phase_3.md` §6's tentative "Phase 4" tags for the four deferred sections; the canonical order in §6 below is now authoritative (exactly as `phase_3.md` §0 superseded `phase_2.md` §18).

---

## 1. Goal

Replace the five styled `PlaceholderSection`s between **Services** and **Pricing** with real, responsive, animated sections so that a visitor scrolling past the Services grid encounters a continuous, credible narrative — social proof, capabilities, process, and audience-specific value — instead of "coming soon" panels.

**Phase 4 ends when** a visitor can:

1. Scroll past Services and see a **Logos strip** of partner/trust marks that reflows cleanly and reads as social proof (placeholder marks until brand assets arrive).
2. Reach a **Features** section pairing an application-preview mockup with a labelled feature list, switching to a stacked layout on mobile.
3. Continue to a **How it works** section showing the five onboarding steps as a connected timeline (horizontal on desktop, vertical on mobile).
4. See a **For clinicians** section and a **For patients** section, each an alternating media+copy block speaking to that audience's benefits.
5. Experience all five entering with the existing `FadeInOnScroll` motion, with **no horizontal overflow** at any width and **no layout break** at any height.
6. Reach the (still-placeholder) Pricing / Testimonials / FAQ / CTA sections below, unchanged.

---

## 2. Non-Goals (Explicitly Out of Scope)

- Pricing / Testimonials / FAQ / CTA content — **Phase 5** (stay placeholders, keep their current wiring).
- Real partner logos / brand assets — Phase 4 ships **placeholder logo tiles** (monochrome text/shape marks); real SVG/PNG marks drop in later without structural change.
- Real product screenshots — the Features preview and audience media use the **existing placeholder-mockup idiom from the Hero** (no real app captures).
- Arabic copy — Arabic stays aliased to English (`landingArAE = landingEnUS`); new keys auto-present in both. RTL audit remains Phase 5.
- Lead-capture forms / real CTA destinations — Phase 6.
- Analytics on feature/step interactions — Phase 6.
- Per-feature detail pages or routing — all Phase 4 content is display-only.

---

## 3. Inputs Resolved (Propose-and-Flag)

Following `phase_3.md` §3's pattern, these are **proposed defaults**. Each is one line from flipping — flag objections before §10's task list starts.

| # | Question | Proposed default for Phase 4 |
|---|----------|------------------------------|
| Q1 | Keep all five placeholders, or drop any? | **Keep and build all five.** They are already wired and nav-linked (`features`, `how-it-works`, `for-clinicians` have nav links). |
| Q2 | What are the "Features"? | The six from `plan.md` Phase 6: Online Booking, Notifications, Reports, Products, Doctor Management, Scheduling. |
| Q3 | What are the "How it works" steps? | The five from `plan.md` Phase 8: Register → Create Center → Add Doctors → Receive Appointments → Manage Business. |
| Q4 | What do `for-clinicians` / `for-patients` contain? | Audience-segmented value blocks (alternating media + 3–4 bullet benefits + soft CTA text). Clinicians = doctors/centers; patients = end users. |
| Q5 | Real logos in the strip? | **Placeholder tiles** (text/shape marks via a small reusable widget) until brand assets arrive. Flagged in §14. |
| Q6 | Do the nav links change? | **No new links.** `features`, `how-it-works`, `for-clinicians` already exist in `_navLinks`; `for-patients` and `logos` stay link-less (passive). Confirm whether `for-patients` should gain a link. |
| Q7 | Animation approach? | Reuse `FadeInOnScroll` at the sliver level for all five; per-item stagger via incremental `delay` inside Features list and How-it-works steps. No new animation primitives. |
| Q8 | Where does the Features preview image come from? | Reuse **`HeroVisual`** (`hero/widgets/hero_visual.dart`) — a framed, asset-driven (`SvgPicture.asset`) visual taking `assetPath`. **Caveat:** its frame is styled white-on-gradient (white@6% fill, white@20% border, dark glow) for the *dark* Hero. On a **light** Features/Audience background that frame is invisible — so reuse needs a **light-background frame variant** (parameterize the frame, or a sibling `ContentVisual`). Asset reuse is fine (`LandingBrand.heroIllustration` or a new SVG). |

---

## 4. Requirements Recap (Phase 4)

| ID | Requirement (from `plan.md` + wired placeholders) | Phase 4 deliverable |
|----|---------------------------------------------------|---------------------|
| R1 | Trust/logos strip | `logos_section.dart` + `logo_tile.dart` |
| R2 | Features: preview + list (`plan.md` Phase 6) | `features_section.dart` + `feature_row.dart` |
| R3 | Features: layout switch for mobile | preview-beside-list (laptop+) → stacked (tablet/mobile) |
| R4 | Features: animation on visibility | `FadeInOnScroll` + staggered list items |
| R5 | How it works: step timeline (`plan.md` Phase 8) | `how_it_works_section.dart` + `step_node.dart` |
| R6 | How it works: visual connectors | connector line between nodes (horizontal/vertical) |
| R7 | For clinicians: audience value block | `audience_section.dart` (reused, `variant: clinicians`) |
| R8 | For patients: audience value block | `audience_section.dart` (reused, `variant: patients`) |
| R9 | All: responsive, no overflow, anchor-registered | `SectionWrapper` + `ScreenSizeX`/`Responsive<T>` |

---

## 5. Section Specifications

> **Shared conventions (apply to all five).** Each section is a `StatefulWidget` that:
> - Wraps content in `SectionWrapper(sectionKey: _key, background: <alternating>)`.
> - Self-registers its anchor id with `LandingScrollController` in a post-frame callback and unregisters in `dispose()` (copy the `StatsSection` lifecycle, `stats_section.dart:23-38`).
> - Is wrapped in `FadeInOnScroll` at the `landing_page.dart` sliver level (consistent with all siblings).
> - Uses `CustomText` with `role:` (never raw `Text`), `LandingColors.*`, and `AppSpacing` tokens (no raw layout pixels). Icons stay Material `Icons.*` (house convention — `iconsax` declared but unused in landing code; see `phase_3.md` §5.2).
> - Reuses the eyebrow-chip + title + subtitle header idiom established in `stats_section.dart` / Services (`accent`-tinted chip on light backgrounds).

### 5.1 Logos strip (`logos`)

A slim full-width band of monochrome partner marks reinforcing the Stats/Services credibility.

```
┌──────────────────────────────────────────────────────────────────────┐
│              Trusted by clinics and centers across the region          │
│                                                                        │
│   [ MARK ]   [ MARK ]   [ MARK ]   [ MARK ]   [ MARK ]   [ MARK ]      │
└──────────────────────────────────────────────────────────────────────┘
```

- Eyebrow/caption (`logos.caption`) above a centered `Wrap` of `LogoTile`s.
- `LogoTile` = a placeholder mark (rounded container + greyed `CustomText` brand name, or a simple shape), `~120×40`, low-opacity so it reads as a logo wall, not buttons. Swap to real `Image.asset`/SVG later without touching the section.
- 6 placeholder marks; `Wrap` reflows to 3-per-row tablet, 2-per-row mobile.
- Background `surfaceMuted` (alternation — see §6.1). No nav link.

### 5.2 Features (`features`) — `plan.md` Phase 6

Application preview beside a labelled feature list; stacks on mobile.

```
┌──────────────────────────────────────────────────────────────────────┐
│  [eyebrow]  Everything in one application                              │
│  ┌────────────────────┐   ✔ Online Booking   — short desc             │
│  │                    │   ✔ Notifications     — short desc             │
│  │   APP PREVIEW      │   ✔ Reports           — short desc             │
│  │   (placeholder)    │   ✔ Products          — short desc             │
│  │                    │   ✔ Doctor Management — short desc             │
│  └────────────────────┘   ✔ Scheduling        — short desc            │
└──────────────────────────────────────────────────────────────────────┘
```

**Features (6 rows):**

| Icon (Material) | Title key | Desc key |
|-----------------|-----------|----------|
| `Icons.event_available_rounded` | `features.booking.title` | `features.booking.desc` |
| `Icons.notifications_active_rounded` | `features.notifications.title` | `features.notifications.desc` |
| `Icons.assessment_rounded` | `features.reports.title` | `features.reports.desc` |
| `Icons.inventory_2_rounded` | `features.products.title` | `features.products.desc` |
| `Icons.badge_rounded` | `features.doctors.title` | `features.doctors.desc` |
| `Icons.schedule_rounded` | `features.scheduling.title` | `features.scheduling.desc` |

- **Layout:** laptop+ → `Row` with preview (`Expanded`/fixed-ratio) on the left, list (`Expanded`) on the right. Tablet/mobile → `Column` (preview on top, list below). Branch on `ScreenSizeX.of(context).isLaptopOrLarger` (same idiom as `_StatsGrid`).
- **Preview:** reuse `HeroVisual`'s framed `AspectRatio` + SVG idiom (Q8) **with a light-background frame variant** — the Hero's white-on-gradient frame is invisible on white, so parameterize the frame styling (or add a sibling `ContentVisual`). Asset can be `LandingBrand.heroIllustration` or a new placeholder SVG.
- **`FeatureRow`:** icon badge (reuse the `_NumberBadge` gradient-tint treatment from `placeholder_section.dart:119`) + title (`headingSM`/`bodyLG`, `FW.bold`) + description (`bodyMD`, `textSecondary`).
- **Animation:** list items fade in with incremental `FadeInOnScroll(delay: ...)` stagger.
- Background `surfaceElevated`/white.

### 5.3 How it works (`how-it-works`) — `plan.md` Phase 8

Five onboarding steps as a connected timeline.

```
Desktop:   ①────────②────────③────────④────────⑤
         Register  Create   Add      Receive   Manage
                   Center   Doctors  Appts     Business

Mobile:    ①  Register
           │
           ②  Create Center
           │
           ③  Add Doctors   …
```

**Steps (5):**

| # | Icon (Material) | Title key | Desc key |
|--:|-----------------|-----------|----------|
| 1 | `Icons.person_add_alt_1_rounded` | `how.register.title` | `how.register.desc` |
| 2 | `Icons.add_business_rounded` | `how.center.title` | `how.center.desc` |
| 3 | `Icons.groups_rounded` | `how.doctors.title` | `how.doctors.desc` |
| 4 | `Icons.event_available_rounded` | `how.appointments.title` | `how.appointments.desc` |
| 5 | `Icons.trending_up_rounded` | `how.manage.title` | `how.manage.desc` |

- **`StepNode`:** numbered gradient badge (reuse `_NumberBadge` idiom) + icon + title + short desc.
- **Connectors:** thin gradient line between nodes — horizontal on laptop+ (a `Row` of nodes separated by `Expanded` divider segments), vertical on tablet/mobile (a `Column` with a left-rail connector). Use the `_DecorativeDivider` gradient idiom (`placeholder_section.dart:198`) for the line color.
- **No overflow at 360px:** vertical layout on mobile sidesteps horizontal crowding; verify the 5-up horizontal row does not crush below laptop width (fall back to vertical earlier if needed).
- Background `surfaceMuted`.

### 5.4 For clinicians (`for-clinicians`) & For patients (`for-patients`)

Two instances of **one reusable** `AudienceSection`, differing only by data variant and media side (alternate the media left/right for visual rhythm).

```
For clinicians:   ┌─────────┐   For clinicians
                  │ MEDIA   │   ✔ benefit 1
                  │ (mock)  │   ✔ benefit 2
                  └─────────┘   ✔ benefit 3   [learn more →]

For patients:     For patients      ┌─────────┐
                  ✔ benefit 1        │ MEDIA   │   (media on right)
                  ✔ benefit 2        │ (mock)  │
                  ✔ benefit 3        └─────────┘
```

- **`AudienceSection({required AudienceContent content, required bool mediaOnLeft})`** — single widget, two call sites.
- **Content:** eyebrow (`for_clinicians.eyebrow` / `for_patients.eyebrow`), title, subtitle, a list of 3–4 `(icon, benefitKey)` bullets, and optional soft CTA text (`.tr`, non-navigating in Phase 4).
- **Layout:** laptop+ → `Row` (media + copy, side per `mediaOnLeft`); tablet/mobile → `Column` (media on top). Same `isLaptopOrLarger` branch.
- **Media:** the same light-background `HeroVisual` variant as Features (§5.2 / Q8); no real asset.
- **Backgrounds:** `for-clinicians` → `surfaceElevated`/white, `for-patients` → `surfaceMuted` (keep alternation; see §6.1).
- `for-clinicians` has an existing nav link; `for-patients` is link-less by default (Q6).

---

## 6. Canonical Section Order (unchanged structure — statuses updated)

Supersedes `phase_3.md` §6's "Phase 4" tags for the four deferred rows. The **order and ids are identical** to what's already wired in `landing_page.dart`; only the build/placeholder status changes.

| # | Section id | Phase 4 status | Owner phase | Nav link? |
|--:|------------|----------------|-------------|-----------|
| 0 | `hero` | Built | Phase 2 | (logo → hero) |
| 1 | `stats` | Built | Phase 3 | no |
| 2 | `services` | Built | Phase 3 | yes |
| 3 | `logos` | **BUILD THIS PHASE** | Phase 4 | no |
| 4 | `features` | **BUILD THIS PHASE** | Phase 4 | yes (existing) |
| 5 | `how-it-works` | **BUILD THIS PHASE** | Phase 4 | yes (existing) |
| 6 | `for-clinicians` | **BUILD THIS PHASE** | Phase 4 | yes (existing) |
| 7 | `for-patients` | **BUILD THIS PHASE** | Phase 4 | no |
| 8 | `pricing` | Placeholder | **Phase 5** | yes (existing) |
| 9 | `testimonials` | Placeholder | **Phase 5** | no |
| 10 | `faq` | Placeholder | **Phase 5** | yes (existing) |
| 11 | `cta` | Placeholder | **Phase 5** | no |
| 12 | `footer` | Built | Phase 2 | no |

### 6.1 `landing_page.dart` integration (concrete)

Replace each of the five `PlaceholderSection(sectionId: …)` slivers (`§ 3`–`§ 7`, currently `landing_page.dart:41-83`) with the real section widget, **keeping the same `FadeInOnScroll` wrapper and slot**:

```dart
// § 3 — Logos strip (Phase 4)
SliverToBoxAdapter(child: FadeInOnScroll(child: const LogosSection())),

// § 4 — Features (Phase 4)
SliverToBoxAdapter(child: FadeInOnScroll(child: const FeaturesSection())),

// § 5 — How it works (Phase 4)
SliverToBoxAdapter(child: FadeInOnScroll(child: const HowItWorksSection())),

// § 6 — For clinicians (Phase 4)
SliverToBoxAdapter(
  child: FadeInOnScroll(
    child: const AudienceSection(content: AudienceContent.clinicians, mediaOnLeft: true),
  ),
),

// § 7 — For patients (Phase 4)
SliverToBoxAdapter(
  child: FadeInOnScroll(
    child: const AudienceSection(content: AudienceContent.patients, mediaOnLeft: false),
  ),
),

// § 8 — Pricing (still Phase 5 placeholder) … unchanged
```

> Each real section sets its own `SectionWrapper(background:)` internally, so drop the `background:` argument that the placeholders carried. **Background alternation target:** services (white) → logos (muted) → features (white) → how-it-works (muted) → for-clinicians (white) → for-patients (muted) → pricing (white). Verify no two adjacent sections share a color after the swap.

### 6.2 `placeholder_section.dart` map updates

The five built ids (`logos`, `features`, `how-it-works`, `for-clinicians`, `for-patients`) graduate **out of** the placeholder system, so **remove** their entries from `_sectionIndex` / `_sectionTitle` (`placeholder_section.dart:48-70`). The remaining placeholders are `pricing`, `testimonials`, `faq`, `cta` — **re-number** their badge indices to a sensible sequence (e.g. `01`–`04`) so the "coming soon" badges stay tidy. Cosmetic-only, low risk.

### 6.3 NavBar

**No nav changes required by default.** `nav.features`, `nav.how_it_works`, `nav.for_clinicians`, `nav.pricing`, `nav.faq` already exist in `_navLinks` (`nav_bar.dart:16-22`) and `_drawerLinks`. Building the real sections simply makes those existing links land on real content. Confirm Q6 before adding any `for-patients` link.

---

## 7. Data & i18n

### 7.1 Data location

Add Phase 4 catalogs to a new sibling `lib/src/landing/data/landing_content.dart` (parallel to `landing_metrics.dart`), keeping Phase 3 and Phase 4 catalogs separate and readable. Mirror the `landing_metrics.dart` shape (`abstract final class` + `const List<...>`):

- `FeatureItem(icon, titleKey, descKey)` + `const List<FeatureItem> features`.
- `HowStep(icon, titleKey, descKey)` + `const List<HowStep> steps`.
- `AudienceContent` — an enum or const-keyed model holding `(eyebrowKey, titleKey, subtitleKey, List<(IconData, String)> benefits)` for `clinicians` and `patients`.
- `LogoMark(labelKey)` (or just `String`) + `const List<LogoMark> logos` placeholder marks.

> `IconData` in `data/` follows the accepted Phase 3 exception for static UI catalogs (`phase_3.md` §8.1 / §11 Principle II) — these are display catalogs, not domain entities.

### 7.2 New i18n keys (`landing_translations.dart`, `<section>.<element>`)

Append to `landingEnUS` (Arabic auto-inherits via `landingArAE = landingEnUS`). Copy is placeholder/product-owned; **keys are stable.**

```dart
// ── Logos ──
'logos.caption': 'Trusted by clinics and centers across the region',

// ── Features ──
'features.eyebrow': 'One application',
'features.title': 'Everything your practice needs, in one place',
'features.subtitle': 'Clinical, operational, and commercial — unified.',
'features.booking.title': 'Online Booking',
'features.booking.desc': 'Patients book available slots in real time, 24/7.',
'features.notifications.title': 'Notifications',
'features.notifications.desc': 'Automatic reminders cut no-shows for staff and patients.',
'features.reports.title': 'Reports',
'features.reports.desc': 'Clear revenue, booking, and performance reporting.',
'features.products.title': 'Products',
'features.products.desc': 'List and sell products and services from your storefront.',
'features.doctors.title': 'Doctor Management',
'features.doctors.desc': 'Onboard and manage your clinical team in one dashboard.',
'features.scheduling.title': 'Scheduling',
'features.scheduling.desc': 'Flexible calendars across doctors and centers.',

// ── How it works ──
'how.eyebrow': 'How it works',
'how.title': 'Up and running in five steps',
'how.register.title': 'Register',
'how.register.desc': 'Create your account in minutes.',
'how.center.title': 'Create Center',
'how.center.desc': 'Set up your clinic or medical center profile.',
'how.doctors.title': 'Add Doctors',
'how.doctors.desc': 'Invite your clinical team and set their schedules.',
'how.appointments.title': 'Receive Appointments',
'how.appointments.desc': 'Start taking online bookings right away.',
'how.manage.title': 'Manage Business',
'how.manage.desc': 'Track performance and grow from one dashboard.',

// ── For clinicians ──
'for_clinicians.eyebrow': 'For clinicians',
'for_clinicians.title': 'Run your practice, not your paperwork',
'for_clinicians.subtitle': 'Tools built for doctors and medical centers.',
'for_clinicians.benefit1': 'Manage doctors, schedules, and centers in one place.',
'for_clinicians.benefit2': 'Reduce no-shows with automatic reminders.',
'for_clinicians.benefit3': 'See revenue and performance at a glance.',
'for_clinicians.cta': 'See clinician tools',

// ── For patients ──
'for_patients.eyebrow': 'For patients',
'for_patients.title': 'Care that fits your schedule',
'for_patients.subtitle': 'Find, book, and manage appointments with ease.',
'for_patients.benefit1': 'Book trusted doctors and centers online, anytime.',
'for_patients.benefit2': 'Get reminders so you never miss a visit.',
'for_patients.benefit3': 'Discover offers and products in one app.',
'for_patients.cta': 'Explore the patient app',
```

> If Q6 adds a `for-patients` nav link, also append `'nav.for_patients': 'For patients'`.

---

## 8. Folder Structure Additions

Phase 4 deltas only (builds on Phase 3 layout):

```text
lib/src/landing/
  data/
    landing_content.dart                   ← NEW: FeatureItem · HowStep · AudienceContent · LogoMark catalogs
  presentation/
    sections/
      logos/
        logos_section.dart                 ← NEW: SectionWrapper(id: 'logos')
        widgets/
          logo_tile.dart                   ← NEW: placeholder logo mark
      features/
        features_section.dart              ← NEW: SectionWrapper(id: 'features'), preview + list
        widgets/
          feature_row.dart                 ← NEW: icon badge + title + desc
      how_it_works/
        how_it_works_section.dart          ← NEW: SectionWrapper(id: 'how-it-works'), timeline
        widgets/
          step_node.dart                   ← NEW: numbered badge + icon + title + desc
      audience/
        audience_section.dart              ← NEW: reusable for clinicians + patients
      sections.dart                        ← UPDATE: export the 4 new sections
    pages/
      landing_page.dart                    ← UPDATE: swap 5 placeholders → real sections (§6.1)
    sections/placeholders/
      placeholder_section.dart             ← UPDATE: remove 5 built ids, re-number remaining (§6.2)
  core/i18n/
    landing_translations.dart              ← UPDATE: append logos/features/how/for_* keys (§7.2)
```

No new assets required (Material icons + reused Hero mockup idiom). No `pubspec.yaml` change — `visibility_detector` (via `FadeInOnScroll`) is already present.

---

## 9. Implementation Task Breakdown

Suggested order. Once Group A lands, Groups B–E are largely independent and can run in parallel.

**Group A — Foundation (blocks the rest)**

1. ⬜ Create `landing_content.dart` (`FeatureItem`, `HowStep`, `AudienceContent`, `LogoMark` + catalogs).
2. ⬜ Append all `logos.*` / `features.*` / `how.*` / `for_clinicians.*` / `for_patients.*` keys to `landing_translations.dart`.
3. ⬜ Add a **light-background frame variant** of `HeroVisual` (parameterize its frame, or sibling `ContentVisual`) — Features preview + both Audience media depend on it; the Hero frame is white-on-gradient and invisible on light backgrounds (§5.2 / Q8).

**Group B — Logos**

4. ⬜ `logo_tile.dart` — placeholder mark.
5. ⬜ `logos_section.dart` — `SectionWrapper(id: 'logos')`, centered `Wrap`, anchor registration.

**Group C — Features**

6. ⬜ `feature_row.dart` — icon badge + title + desc.
7. ⬜ `features_section.dart` — preview-beside-list (laptop+) / stacked (tablet+mobile), staggered list, anchor `features`.

**Group D — How it works**

8. ⬜ `step_node.dart` — numbered badge + icon + title + desc.
9. ⬜ `how_it_works_section.dart` — horizontal timeline laptop+ / vertical mobile, connectors, anchor `how-it-works`.

**Group E — Audience (clinicians + patients)**

10. ⬜ `audience_section.dart` — reusable media+copy block (`mediaOnLeft` flips side), anchors `for-clinicians` / `for-patients`.

**Group F — Wiring & order**

11. ⬜ Swap the five placeholder slivers in `landing_page.dart` for real sections (§6.1); drop their `background:` args.
12. ⬜ Remove the five built ids from `placeholder_section.dart` maps; re-number the remaining four (§6.2).
13. ⬜ Update `sections.dart` barrel exports.
14. ⬜ (If Q6) add `for-patients` nav link to `_navLinks` + `_drawerLinks` and `nav.for_patients` key.

**Group G — Verification & polish**

15. ⬜ `flutter analyze .` clean (zero errors/warnings in new files). Web debug build compiles end-to-end.
16. ⬜ Breakpoint sweep 360 / 480 / 768 / 1024 / 1280 / 1440 / 1600 / 1920 / 2400 px — no horizontal overflow in any of the five. *(manual — `flutter run -d chrome`)*
17. ⬜ Features: preview-beside-list at laptop+, cleanly stacked below; list stagger fires once. *(manual)*
18. ⬜ How-it-works: horizontal connectors at laptop+, vertical rail on mobile, no node crush. *(manual)*
19. ⬜ Audience: media side alternates (clinicians left / patients right) desktop; stacks on mobile. *(manual)*
20. ⬜ Existing nav links (`Features`, `How it works`, `For clinicians`) scroll to the now-real sections; active-highlight works. *(manual)*
21. ⬜ Deferred placeholders (`pricing` … `cta`) still render, scroll, and show re-numbered badges. *(manual)*
22. ⬜ `FadeInOnScroll` entrance and (where used) staggered items honor `MediaQuery.disableAnimations`. *(manual)*

Estimated effort: **3–4 working days** for one engineer (five sections, one of them reused across two slots).

---

## 10. Constitution Compliance Check

Per `.specify/memory/constitution.md`:

| Principle | How Phase 4 honors it |
|-----------|----------------------|
| I. GetX state & nav | Sections self-register with `LandingScrollController` (GetX); no new routing/go_router; entrance animation is local/UI-only. |
| II. Feature-first clean arch | New code under `landing/`; static catalogs in `data/landing_content.dart`; no API → no repo/usecase. `IconData` in data follows the accepted Phase 3 static-catalog exception. |
| III. Type & null safety | No `!` on reactive values; any `AnimationController` disposed; visibility latches prevent double-fire (reuse `FadeInOnScroll` semantics). |
| IV. UI & styling discipline | `AppSpacing` tokens for gaps, `LandingColors.*`, `CustomText` w/ `role`, shared radius/badge idioms — no raw layout pixels, no raw `Text`. |
| V. Observability | Anchor mis-registration / unknown-id paths logged via `log(..., name: ...)`; no `print`. |
| VI. Testability & app modes | Feature list, steps, audience content, and logos externalized in `landing_content.dart` so tests can stub and counts are data-driven. |
| VII. Quality gate | `flutter analyze .` zero errors before merge; new anchor ids verified against the existing registry. |

No anticipated violations. Complexity Tracking entries: **none**.

---

## 11. Acceptance Criteria (Definition of Done)

### 11.1 Logos
- [ ] Caption + 6 placeholder marks render and reflow (3/2 per row) without overflow at 360px.
- [ ] Section registered as anchor `logos`; entrance via `FadeInOnScroll`.

### 11.2 Features
- [ ] Six features render with icon + title + desc across all breakpoints.
- [ ] Preview-beside-list at laptop+; stacked (preview on top) at tablet/mobile; no horizontal overflow.
- [ ] List items enter staggered; entrance via `FadeInOnScroll`; anchor `features`.

### 11.3 How it works
- [ ] Five steps render with number + icon + title + desc.
- [ ] Horizontal connected timeline at laptop+, vertical rail on tablet/mobile, no node crush at 360px.
- [ ] Section registered as anchor `how-it-works`.

### 11.4 For clinicians / For patients
- [ ] Both render eyebrow + title + subtitle + 3–4 benefits + media via one reusable `AudienceSection`.
- [ ] Media side alternates (clinicians left, patients right) at laptop+; stacks on mobile.
- [ ] Anchors `for-clinicians` and `for-patients` registered; entrance via `FadeInOnScroll`.

### 11.5 Order, navigation & quality
- [ ] All five placeholders replaced; canonical order matches §6; background alternation reads cleanly top-to-bottom.
- [ ] Existing nav links (`Features`, `How it works`, `For clinicians`) scroll to the real sections with active-highlight.
- [ ] Deferred placeholders (`pricing`/`testimonials`/`faq`/`cta`) still render with re-numbered badges and scroll correctly.
- [ ] Every new visible string flows through `.tr` with a key in `landing_translations.dart`.
- [ ] `flutter analyze .` zero errors/warnings in new files; no `print()`, no raw layout-pixel literals, all controllers disposed.

---

## 12. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------:|-------:|------------|
| 5-up horizontal How-it-works timeline crushes between laptop min and content max | Medium | Medium | Fall back to vertical layout earlier (e.g. below desktop) if nodes measure too narrow; verify §9 task 18. |
| Features `Row` (preview + list) overflows at narrow laptop widths | Medium | Medium | Constrain preview by aspect ratio + `Expanded` list; switch to stacked at/under tablet; test at 1024px. |
| Audience media+copy `Row` unbalanced or overflowing | Low | Medium | Equal `Expanded` halves with max-width copy column; stack on tablet/mobile. |
| Background alternation collides after swapping 5 placeholders | Medium | Low | §6.1 alternation table; flip one `SectionWrapper(background:)` if two neighbors match. |
| Placeholder badge numbers wrong after removing 5 ids | Low | Low | Re-number remaining four in task 12; cosmetic only. |
| Reusing one `AudienceSection` over-couples clinicians/patients copy | Low | Low | Drive entirely from `AudienceContent` data variant; widget holds no audience-specific literals. |
| A proposed Material icon name doesn't exist / reads poorly | Low | Low | All names are standard Material symbols; confirm at build, swap to nearest match. |

---

## 13. Open Questions (resolve before / during Group A)

1. **`for-patients` nav link** — add to nav/drawer, or keep passive like `logos`? (Q6) Default: passive.
2. **Logo marks** — confirm placeholder tiles are acceptable until brand assets arrive; how many marks (default 6)?
3. **Features count/labels** — six per `plan.md` Phase 6; confirm none added/removed.
4. **How-it-works steps** — five per `plan.md` Phase 8; confirm wording/order.
5. **Audience benefits copy** — three bullets each are placeholders; product-review before release.
6. **Soft CTA text** — `for_*.cta` strings are non-navigating in Phase 4; confirm no link target wanted yet.
7. **Hero visual reuse** — `HeroVisual` is reusable and asset-driven, but its frame is styled for the dark Hero gradient and is invisible on light backgrounds. Confirm the approach: parameterize `HeroVisual`'s frame vs. add a sibling `ContentVisual` for light sections (Q8).
8. **`plan.md` Phase 7 (Application Screens Showcase)** — has **no wired placeholder** and no section here. Confirm it is intentionally folded into the Features preview / deferred (see §14), not dropped.

---

## 14. Out of Scope — Reserved for Later Phases

| Phase | Scope (tentative, post-reconciliation) |
|-------|----------------------------------------|
| Phase 5 | **Pricing, Testimonials, FAQ, CTA** content (the four sections deferred from this doc); Arabic + RTL audit; visible dark-mode / language toggle |
| Phase 6 | Lead-capture / registration forms, analytics events, real CTA destinations, live data from API |
| Phase 7 | SEO meta, Open Graph, Lighthouse ≥ 95, real brand/logo + screenshot assets |

> **`plan.md` Phase 7 (Application Screens Showcase — Dashboard, Booking, Doctor Profile, …)** has **no wired placeholder** in `landing_page.dart` and is **not** built in detailed Phase 4. It is considered partly covered by the Features preview (§5.2) and otherwise deferred; revisit when real screenshot assets land. Flagged so a `plan.md` cross-reader doesn't think it was dropped (§13 Q8).

---

## 15. References

- [phase_1.md](phase_1.md) — Foundation & Architecture.
- [phase_2.md](phase_2.md) — Shell sections, NavBar, Hero, Footer, routing.
- [phase_3.md](phase_3.md) — Statistics + Services (§6 "Phase 4" tags for pricing/testimonials/faq/cta superseded by §6 here; §0 numbering pattern continued here).
- `plan.md` — master marketing roadmap (Phase 6 = Features, Phase 8 = How It Works; the audience sections are landing-specific, not separately numbered there).
- `.specify/memory/constitution.md` — Principles I–VII.
- Existing code idioms reused: `SectionWrapper`, `FadeInOnScroll`, `Responsive<T>`/`ScreenSizeX`, `AppSpacing`, `LandingColors`, `CustomText`, section anchor lifecycle (`stats_section.dart`), `_NumberBadge` (icon/number badge) and `_DecorativeDivider` (gradient line) from `placeholder_section.dart`, Hero placeholder-mockup idiom.

---

**End of Phase 4 plan. No implementation begins until this document is approved. Resolve §13 Q1 (`for-patients` nav link) and Q7 (Hero mockup reuse) before Group A.**
