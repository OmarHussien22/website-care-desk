# Phase 2 — Shell Sections, Navigation & Brand

**Project**: Medical Ecosystem Landing Page
**Phase**: 2 of N — Shell Sections (NavBar · Hero · Footer) + URL Routing + Section Order
**Status**: Planned (not yet implemented)
**Depends on**: Phase 1 ([phase_1.md](phase_1.md)) — must be merged & verified first
**Owner**: Omar
**Date**: 2026-05-24
**Stack**: Flutter (Dart ^3.11.1) · GetX · flutter_screenutil
**Targets**: Web (primary) · iOS · Android · macOS · Windows · Linux

---

## 1. Goal

Land the **outer shell** of the marketing site — the parts that wrap every future section — plus the URL/anchor plumbing that makes the page feel like a real SaaS product instead of a single scrollable Flutter screen.

**Phase 2 ends when** a visitor can:

1. Land on the page, see a polished Hero with two CTAs above the fold on every breakpoint.
2. Scroll and see a sticky NavBar that morphs (transparent → solid) and highlights the active section.
3. Click a NavBar link or share a `#hero` / `#features` URL and the page scrolls to that section.
4. Reach a real Footer at the bottom with navigation columns and social links.
5. On mobile, open a drawer/menu from the NavBar with the same links.

The middle sections (Features, How-it-works, Pricing, …) are **still empty placeholders** at the end of Phase 2. Phase 3 fills them.

---

## 2. Non-Goals (Explicitly Out of Scope)

- Features / How-it-works / Pricing / Testimonials / FAQ / CTA section content — Phase 3+.
- Real product screenshots or final illustrations — Phase 2 uses approved placeholder assets.
- Sign-up / login / lead-capture form logic — Phase 6.
- Analytics events on CTA clicks — Phase 6.
- SEO meta tags / Open Graph — Phase 7.
- i18n switching — Phase 5 (but copy MUST already flow through `.toTr()` keys, see §11).
- Dark-mode toggle in the UI — tokens stay populated, toggle ships in Phase 5.

---

## 3. Inputs Resolved from Phase 1

Phase 1 left five open questions. Phase 2 closes them with the following **proposed defaults**. Each is a single line change away from flipping if you disagree — flag any objections before §17's task list starts.

| # | Question | Proposed default for Phase 2 |
|---|----------|------------------------------|
| Q1 | Landing as `/` or `/landing`? | **`/` on web builds; `/splash` remains for native auth builds.** `AppRouter` branches on `kIsWeb`. |
| Q2 | i18n in Phase 2? | **No visible toggle; all copy goes through `.toTr()` keys from day one.** Single English locale shipped; Arabic added in Phase 5. |
| Q3 | Section order? | Hero → Logos strip → Features → How it works → For clinicians → For patients → Pricing → Testimonials → FAQ → CTA → Footer. (See §8 for full table.) |
| Q4 | Dark-mode toggle in v1? | **No visible toggle.** `DarkColor` tokens stay populated and tested in DevTools, but no public switch until Phase 5. |
| Q5 | Brand palette? | Phase 2 finalizes it (see §9). Default proposed below; awaiting your sign-off. |

If you want to change any of these, override now — they shape every task that follows.

---

## 4. Requirements Recap (Phase 2)

| ID | Requirement | Phase 2 deliverable |
|----|-------------|---------------------|
| R1 | Real, sticky, responsive NavBar | `nav_bar.dart` organism + mobile drawer + scroll-state controller |
| R2 | Hero with two CTAs, no overflow at any breakpoint | `hero_section.dart` + responsive layout split (text/visual) |
| R3 | Footer with columns and social links | `footer.dart` organism + responsive column collapse |
| R4 | URL hash navigation (`/#features`) | Hash sync wired into `LandingScrollController` (web-only) |
| R5 | Active-section highlighting in NavBar | Reactive `currentSectionId` drives link state |
| R6 | Section order locked | `LandingPage` registers placeholder section keys in canonical order |
| R7 | Brand palette finalized | `LightColor` / `DarkColor` token values committed |

---

## 5. NavBar Specification

### 5.1 Anatomy (desktop / laptop / ultrawide)

```
┌──────────────────────────────────────────────────────────────────────┐
│  [Logo]   Features  How it works  For clinicians  Pricing  FAQ   [CTA]│
└──────────────────────────────────────────────────────────────────────┘
```

- Left: logo (SVG, links to `#hero`).
- Center-right: anchor links (text buttons, hover underline).
- Right: primary CTA button ("Book a demo" — copy TBD).

### 5.2 Anatomy (mobile / small tablet)

```
┌────────────────────────────┐
│  [Logo]              [☰]   │
└────────────────────────────┘
```

- Hamburger opens a **full-screen drawer** (not a side drawer — bigger tap targets, more modern).
- Drawer body: stacked links, large type, single CTA button at the bottom.
- Drawer close: top-right `✕`, swipe-down, or tapping any link (auto-close on navigate).

### 5.3 Scroll behavior

- **Position**: sticky to viewport top, full width.
- **Initial state** (over hero): transparent background, white text/logo on top of the hero gradient.
- **After scroll > 24px**: solid background (`surfaceElevated`), border-bottom `borderSubtle`, text becomes `textPrimary`. Transition: 200ms `easeInOutCubic`.
- **Shadow on scroll**: subtle `0 1px 3px rgba(0,0,0,0.06)` after the morph.

### 5.4 Active-section highlighting

- The currently-visible section's link shows an underline (or pill background, see §9.4) using `accentGradientStart`.
- Updated reactively via `LandingScrollController.currentSectionId` (already on the controller from Phase 1; Phase 2 adds the visibility detection).
- Implementation: each `SectionWrapper` reports its key's render-box position on scroll; controller computes which one occupies the central 30% of the viewport.

### 5.5 Keyboard / accessibility

- All links and CTA reachable by Tab, with visible focus ring (`accentGradientStart` 2px outline).
- Drawer open/close announced via `Semantics(label: ...)`.
- Hamburger and close icons have `Semantics(button: true, label: 'Open/close menu')`.

### 5.6 GetX wiring

- `NavBarController extends GetxController` — holds `isDrawerOpen` (reactive), `scrolledPastThreshold` (reactive).
- Subscribes to `LandingScrollController.scrollController` in `onInit`; unsubscribes in `onClose`.
- Drawer state lifted into the controller (not local widget state) so it can be closed from anywhere.

---

## 6. Hero Section Specification

### 6.1 Layout — desktop / laptop / ultrawide

Two columns inside `MaxContentWidth`:

- **Left (55%)**: eyebrow → headline → subheadline → CTA row → trust line.
- **Right (45%)**: hero visual (placeholder illustration / Lottie / animated mockup).

### 6.2 Layout — tablet

Same two-column layout but at 50/50 split, with slightly tighter padding.

### 6.3 Layout — mobile

Single column, stacked: visual on top (smaller), then text block, then CTAs full-width.

### 6.4 Content slots (placeholder copy via `.toTr()`)

| Slot | Key | Phase 2 placeholder |
|------|-----|----------------------|
| Eyebrow | `hero.eyebrow` | "Healthcare, reimagined" |
| Headline | `hero.headline` | "One platform for every clinic and every patient." |
| Subheadline | `hero.subheadline` | "Streamline appointments, records, and care coordination — built for the modern medical practice." |
| Primary CTA | `hero.cta.primary` | "Book a demo" |
| Secondary CTA | `hero.cta.secondary` | "See how it works" |
| Trust line | `hero.trust` | "Trusted by 250+ clinics across the region" |

> Copy is a placeholder — final wording is product-owned and may change before Phase 3. The keys are stable.

### 6.5 Visual asset

- Phase 2 ships **one** placeholder: a layered SVG composition (already-available via `flutter_svg`) of a clinic-themed illustration.
- Reserved swap path: `assets/images/hero/hero_main.svg`. The widget accepts the asset path as a parameter so swapping is a one-line change later.
- Optional subtle Lottie reserved for Phase 3 (gated behind a flag in the widget).

### 6.6 Background

- Soft gradient using `accentGradientStart` → `accentGradientEnd` at 6–10% opacity.
- Optional decorative blurred blobs (positioned widgets with `BackdropFilter` or pre-rendered SVG) — kept performant via `RepaintBoundary`.

### 6.7 Above-the-fold guarantee

- On every supported breakpoint, the headline + subheadline + primary CTA MUST be visible without scrolling.
- Verified at viewport heights: 600 / 720 / 900 / 1080 px.
- If a viewport is too short (e.g. 600px landscape phone), the visual collapses or hides via `ResponsiveBuilder`.

### 6.8 CTA behavior

- Primary CTA: opens an external URL (placeholder `https://example.com/demo`) via `url_launcher` for now.
- Secondary CTA: scrolls to `#how-it-works` via `LandingScrollController.scrollTo('how-it-works')`.

---

## 7. Footer Specification

### 7.1 Anatomy

```
┌──────────────────────────────────────────────────────────────────────┐
│  [Logo + tagline]      Product       Company       Resources         │
│   "Healthcare,         Features      About         Help center        │
│    reimagined."        Pricing       Contact       Privacy            │
│                        How it works  Careers       Terms              │
│                                                                       │
│  [Social: in/x/yt]                                  © 2026 BrandName  │
└──────────────────────────────────────────────────────────────────────┘
```

### 7.2 Responsive collapse

- **Desktop / laptop / ultrawide**: 4 columns (brand + 3 link columns).
- **Tablet**: 2 columns, brand on top spanning full width.
- **Mobile**: stacked accordion — column headings tappable to reveal links; brand block fully expanded by default.

### 7.3 Content slots (placeholder via `.toTr()`)

| Column | Items |
|--------|-------|
| Product | Features, How it works, Pricing |
| Company | About, Contact, Careers |
| Resources | Help center, Privacy, Terms |
| Social | LinkedIn, X, YouTube (icons via `iconsax` or SVG) |

Links targeting in-page sections use `LandingScrollController.scrollTo(id)`; external links open via `url_launcher`.

### 7.4 Bottom strip

- Background: `surfaceMuted` slightly darker than the footer body.
- Left: `© 2026 BrandName. All rights reserved.`
- Right: language selector (disabled in Phase 2, visible in Phase 5).

---

## 8. Canonical Section Order

Locked for Phase 2. Phase 3+ task lists assume this order.

| # | Section id | Phase 2 status | Owner phase |
|--:|------------|----------------|-------------|
| 0 | `hero` | **Built** | Phase 2 |
| 1 | `logos` | Placeholder (skeleton) | Phase 3 |
| 2 | `features` | Placeholder | Phase 3 |
| 3 | `how-it-works` | Placeholder | Phase 3 |
| 4 | `for-clinicians` | Placeholder | Phase 3 |
| 5 | `for-patients` | Placeholder | Phase 3 |
| 6 | `pricing` | Placeholder | Phase 4 |
| 7 | `testimonials` | Placeholder | Phase 4 |
| 8 | `faq` | Placeholder | Phase 4 |
| 9 | `cta` | Placeholder | Phase 4 |
| 10 | `footer` | **Built** | Phase 2 |

A "placeholder" is a `SectionWrapper(id: '<id>')` with a `Container` of fixed responsive height (`Responsive<double>(mobile: 400, …)`) and centered `CustomText('coming soon: <id>')`. This ensures:

- Scrolling distances and anchor jumps work end-to-end.
- Section-key registration is exercised across all sections.
- Phase 3 work is purely "replace inner content" — never re-plumbing.

---

## 9. Brand & Visual Identity

### 9.1 Proposed palette (awaiting confirmation)

A modern, trust-forward medical SaaS palette. Light mode values; dark mode mirrors at §9.2.

| Token | Hex | Use |
|-------|-----|-----|
| `accentGradientStart` | `#0EA5E9` (sky-500) | Primary brand, gradient start |
| `accentGradientEnd` | `#22D3EE` (cyan-400) | Gradient end |
| `accent` | `#0284C7` (sky-600) | Solid CTA fill |
| `accentHover` | `#0369A1` (sky-700) | CTA hover |
| `success` | `#10B981` (emerald-500) | Confirmations / positive trust signals |
| `surface` | `#FFFFFF` | Default background |
| `surfaceMuted` | `#F8FAFC` (slate-50) | Alternating section bg |
| `surfaceElevated` | `#FFFFFF` w/ shadow | Cards |
| `borderSubtle` | `#E2E8F0` (slate-200) | Hairlines |
| `textPrimary` | `#0F172A` (slate-900) | Body |
| `textSecondary` | `#475569` (slate-600) | Captions |
| `textInverse` | `#FFFFFF` | On gradient/dark surfaces |

### 9.2 Dark mode mirror

| Token | Dark hex |
|-------|----------|
| `surface` | `#0B1220` |
| `surfaceMuted` | `#0F172A` (slate-900) |
| `surfaceElevated` | `#1E293B` (slate-800) |
| `borderSubtle` | `#1E293B` |
| `textPrimary` | `#F8FAFC` |
| `textSecondary` | `#94A3B8` (slate-400) |
| `textInverse` | `#0F172A` |
| `accent` family | unchanged (slightly brighter feel against dark) |

### 9.3 Logo

- SVG asset at `assets/images/brand/logo.svg` (placeholder shape if final logo not yet provided).
- Inverted variant `logo_inverse.svg` for use on the transparent hero NavBar.

### 9.4 Component variants now decided

- **Buttons**: filled (gradient), outlined (border `accent`), ghost (transparent, accent text). Heights: 40/48/56 across breakpoints. Radius: `12.toRad()`.
- **Cards**: radius `16`, shadow `0 1px 3px rgba(15,23,42,0.06)`, hover lift `0 8px 24px rgba(15,23,42,0.10)`.
- **Active nav link**: pill background `accentGradientStart` @ 12% opacity, accent text.

---

## 10. URL Hash Navigation

### 10.1 Behavior

- On scroll: when `currentSectionId` changes, update `window.location.hash` to `#<id>` (web-only, no native).
- On page load: if `window.location.hash` is set and matches a known section id, scroll to it after first frame (skip the entrance animation).
- On back/forward: listen to `popstate` and call `scrollTo(id, animate: false)`.

### 10.2 Implementation boundary

- All `dart:html`-using code isolated in `landing_url_sync_web.dart` with a conditional import.
- Non-web stub `landing_url_sync_stub.dart` exposes the same API and does nothing.
- `LandingScrollController` calls into the abstracted `LandingUrlSync` interface; never touches `dart:html` directly.

### 10.3 Edge cases

- Hash referring to unknown id → ignore silently, log via `log('unknown hash: $hash', name: 'LandingUrlSync')`.
- Rapid scroll causing thrashing of `replaceState` → debounce to 120ms.
- User mid-scroll when `popstate` fires → cancel current `scrollTo` animation, jump to new target.

---

## 11. Internationalization Hooks (No Toggle Yet)

Every visible string introduced in Phase 2 MUST go through `.toTr()`. A flat key map lives in:

```
lib/src/landing/core/i18n/landing_translations.dart
```

with English strings only. The map is registered in `AppMaterial.translations` (existing infrastructure).

**Why this matters now**: retrofitting `.toTr()` over hundreds of strings in Phase 5 is expensive; writing keys in Phase 2 is free.

**Key naming convention**: `<section>.<element>` — e.g. `nav.cta.demo`, `hero.headline`, `footer.column.product`, `footer.copyright`.

---

## 12. Folder Structure Additions

Builds on Phase 1's `lib/src/landing/` layout. Phase 2 deltas only:

```text
lib/src/landing/
  core/
    i18n/
      landing_translations.dart            ← NEW: English key map for Phase 2 strings
    url_sync/
      landing_url_sync.dart                ← NEW: interface
      landing_url_sync_stub.dart           ← NEW: native no-op impl
      landing_url_sync_web.dart            ← NEW: dart:html impl
  presentation/
    controllers/
      nav_bar_controller.dart              ← NEW
    sections/
      hero/
        hero_section.dart                  ← NEW
        widgets/
          hero_content.dart                ← left column
          hero_visual.dart                  ← right column
          hero_cta_row.dart                ← two-button row
      footer/
        footer_section.dart                ← NEW
        widgets/
          footer_columns.dart              ← responsive collapse logic
          footer_brand.dart
          footer_social_row.dart
          footer_bottom_strip.dart
      placeholders/
        placeholder_section.dart           ← NEW: shared placeholder widget
    widgets/
      organisms/
        nav_bar.dart                       ← BUILT OUT (was stub in Phase 1)
        nav_bar_drawer.dart                ← NEW: mobile full-screen drawer
        nav_link.dart                      ← NEW: anchor link with active state
    pages/
      landing_page.dart                    ← UPDATED: registers all 11 sections in canonical order
  data/
    landing_brand.dart                     ← NEW: brand constants (logo paths, social URLs)
assets/
  images/
    brand/
      logo.svg                             ← NEW
      logo_inverse.svg                     ← NEW
    hero/
      hero_main.svg                        ← NEW (placeholder)
    social/
      linkedin.svg, x.svg, youtube.svg     ← NEW
```

Asset additions must also land in `pubspec.yaml` under `flutter.assets` — verified in Phase 2 acceptance criteria.

---

## 13. Constitution Compliance Check

Per `.specify/memory/constitution.md`:

| Principle | How Phase 2 honors it |
|-----------|----------------------|
| I. GetX state & nav | `NavBarController`, `LandingScrollController` are `GetxController`s; routing via `AppRoutes` + `AppRouter.pages`; no go_router in landing code |
| II. Feature-first clean arch | `landing/` keeps `core/data/domain/presentation` layout; `data/landing_brand.dart` holds brand constants (no API yet → no repo/usecase needed) |
| III. Type & null safety | No `!` on `currentSectionId` reactive; all controllers dispose in `onClose()`; `dart:html` calls null-checked behind `kIsWeb` |
| IV. UI & styling discipline | Hero/NavBar/Footer use `AppSpacing`, `AppTextStyles`, `AppColors.get.*`; no raw pixels (radius via `.toRad()`); no raw `Text` (use `CustomText` w/ `role`) |
| V. Observability | URL sync, drawer state changes, anchor-jump misses all logged via `log(..., name: 'X')`; no `print` |
| VI. Testability & app modes | Hero CTA URL externalized in `landing_brand.dart` so test mode can stub it; placeholder sections work identically in prod/dev/test |
| VII. Quality gate | New routes (`/` on web) and new asset paths verified before merge; `flutter analyze .` zero errors |

No constitution violations anticipated. Complexity Tracking entries: **none required**.

---

## 14. Acceptance Criteria (Definition of Done)

Phase 2 is complete when **all** of the following are true:

### 14.1 NavBar

- [ ] Sticky on scroll across all breakpoints.
- [ ] Transparent over hero, solid + bordered after 24px scroll, transition smooth.
- [ ] Logo, links, and CTA render at desktop/laptop/ultrawide; hamburger appears at mobile and small tablet.
- [ ] Tapping a link smooth-scrolls to that section (Phase 1 `scrollTo` API).
- [ ] Drawer opens on mobile, closes on link tap, swipe-down, or `✕`.
- [ ] Active section highlighted with accent state.
- [ ] Keyboard navigation reaches every interactive element with visible focus.

### 14.2 Hero

- [ ] Headline + subheadline + primary CTA visible above the fold at 600/720/900/1080 viewport heights.
- [ ] Two-column at laptop+, 50/50 at tablet, single-column at mobile.
- [ ] No horizontal overflow at 360 / 768 / 1280 / 1600 / 2400 px widths.
- [ ] Primary CTA opens external URL via `url_launcher`; secondary CTA scrolls to `#how-it-works`.
- [ ] Gradient background renders using brand tokens.

### 14.3 Footer

- [ ] 4-column layout at laptop+, 2-column at tablet, accordion at mobile.
- [ ] Social icons load from SVG and open external URLs.
- [ ] Bottom strip has dynamic copyright year (`DateTime.now().year`).
- [ ] All section-link items inside the footer scroll to the correct anchor.

### 14.4 URL hash navigation (web only)

- [ ] Scrolling updates `window.location.hash`.
- [ ] Deep-link `/#features` jumps to the features section on load (without animation).
- [ ] Browser back/forward scrolls to the previous/next visited section.
- [ ] Native builds (iOS/Android/desktop) ignore URL hashes without errors.

### 14.5 Section order

- [x] `LandingPage` registers all 11 sections (`hero` + 9 placeholders + `footer`) in §8's order.
- [x] Each placeholder renders a centered "coming soon: `<id>`" label using `CustomText`.

### 14.6 Brand tokens

- [x] All token values in §9 written into `LightColor` and `DarkColor`.
- [ ] Manual DevTools toggle of `AppColors.changeColor(isDark: true)` produces a coherent dark theme (no missing tokens, no jarring contrasts).

### 14.7 Internationalization hooks

- [x] Every visible string in Phase 2 code is a `.toTr()` call.
- [x] `landing_translations.dart` exists and is registered in `AppMaterial.translations`.
- [ ] Toggling Get locale at runtime (DevTools eval) shows the keys (proves the wiring; no Arabic strings yet). *(manual)*

### 14.8 Quality

- [x] `flutter analyze .` returns zero errors/warnings in landing files.
- [x] No `print()`, no raw colors, no raw `Text()` in any new file.
- [x] All `ScrollController`s disposed (in `LandingScrollController.onClose()`); no `TextEditingController`s in scope.
- [x] Asset paths added to `pubspec.yaml` resolve at runtime.

---

## 15. Implementation Task Breakdown

Suggested order. Groups B / C / D can run in parallel after A.

**Group A — Brand & i18n foundation** *(blocks everything)*

1. ✅ Update `LightColor` and `DarkColor` with §9 tokens.
2. ✅ Create `landing_brand.dart` (logo paths, social URLs, demo URL placeholder).
3. ✅ Create `landing_translations.dart` with the Phase 2 key map; register in `AppMaterial.translations`.
4. ✅ Add placeholder SVGs under `assets/images/brand`, `assets/images/hero`, `assets/images/social`; update `pubspec.yaml`.

**Group B — NavBar**

5. ✅ `nav_bar_controller.dart` — drawer state, scroll-past-threshold reactive.
6. ✅ `nav_link.dart` — anchor button with active state.
7. ✅ `nav_bar.dart` — desktop/laptop/ultrawide layout.
8. ✅ `nav_bar_drawer.dart` — mobile full-screen drawer.
9. ✅ Wire NavBar into `landing_page.dart` (above the scroll view as a sticky overlay or persistent header).
10. ✅ Active-section detection wired to `LandingScrollController.currentSectionId`.

**Group C — Hero section**

11. ✅ `hero_content.dart` — left text block.
12. ✅ `hero_cta_row.dart` — two-button row, responsive stacking.
13. ✅ `hero_visual.dart` — right visual container.
14. ✅ `hero_section.dart` — assembles into `SectionWrapper(id: 'hero')`.
15. ⬜ Above-the-fold verification at the four target viewport heights. *(manual — run flutter run -d chrome)*

**Group D — Footer**

16. ✅ `footer_brand.dart`, `footer_columns.dart`, `footer_social_row.dart`, `footer_bottom_strip.dart`.
17. ✅ `footer_section.dart` — assembles into `SectionWrapper(id: 'footer', background: surfaceMuted)`.
18. ✅ Mobile accordion behavior.

**Group E — Placeholders & section order**

19. ✅ `placeholder_section.dart` widget.
20. ✅ Update `landing_page.dart` to register all 11 sections per §8.
21. ⬜ Verify smooth scroll between every pair of anchors. *(manual)*

**Group F — URL hash navigation**

22. ✅ `landing_url_sync.dart` interface.
23. ✅ `landing_url_sync_stub.dart` (native).
24. ✅ `landing_url_sync_web.dart` (web, `dart:html`, conditional import).
25. ✅ `LandingScrollController` integration — debounced hash updates + load-time hash handling + popstate.
26. ⬜ Cross-platform smoke test (web build + one native build). *(manual)*

**Group G — Routing**

27. ✅ `AppRoutes.landing = '/'` for web; keep `/splash` for native.
28. ✅ `AppRouter.pages` branches on `kIsWeb` to choose default route.
29. ⬜ Manual run on `flutter run -d chrome` and `flutter run -d <mobile sim>`. *(manual)*

**Group H — Verification & polish**

30. ⬜ Full breakpoint sweep at 360 / 480 / 768 / 1024 / 1280 / 1440 / 1600 / 1920 / 2400 px. *(manual)*
31. ⬜ Viewport-height sweep at 600 / 720 / 900 / 1080. *(manual)*
32. ✅ `flutter analyze .` clean (zero errors/warnings in landing files).
33. ⬜ Run dark-mode toggle via DevTools — visual sanity check. *(manual)*
34. ⬜ Tab-key keyboard nav across NavBar + Hero CTAs + Footer. *(manual)*

Estimated effort: **5–7 working days** if done sequentially by one engineer.

---

## 16. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------:|-------:|------------|
| `dart:html` accidentally imported on native, breaking iOS/Android | Medium | High | Conditional imports only; CI builds for all platforms after Group F. |
| NavBar transparent-state contrast fails accessibility on light hero | Medium | Medium | Force minimum contrast 4.5:1 verified in §14.1; fallback solid background on systems with `MediaQuery.highContrast`. |
| Active-section detection thrashes between two short sections | Medium | Low | Hysteresis: a new id only wins if it occupies >40% viewport for >150ms. |
| Mobile drawer animation janks on low-end Android | Medium | Medium | Use `AnimatedSwitcher` with `Curves.easeOutCubic`; profile on a low-end device before merge. |
| Hero illustration SVG renders poorly at 4K | Low | Medium | Use vector SVG (scale-free); cap visual container at sensible max. |
| Section order changes after Phase 2 ships → URL hashes break | Low | Medium | Section ids are stable strings; renaming requires a redirect map in `LandingUrlSync` (documented but not built in Phase 2). |
| Footer column links to "Privacy", "Terms" with no destinations | High | Low | Use placeholder `#` href + tooltip "coming soon" until Phase 6. |
| Phase 1 not actually merged yet when Phase 2 starts | Medium | High | **Hard gate**: Phase 1 acceptance criteria (§16 of phase_1.md) MUST all be ✅ before any Phase 2 task starts. |

---

## 17. Open Questions (resolve before Phase 3)

1. **Final brand palette** — the §9 palette is a proposal. Sign-off needed before Group A.
2. **Final logo asset** — placeholder shape ships in Phase 2 unless the real logo is delivered first.
3. **Demo CTA destination URL** — currently `https://example.com/demo`; needs real URL or a "coming soon" landing.
4. **Social media accounts** — Phase 2 wires LinkedIn/X/YouTube; confirm these three are the right channels.
5. **Footer link destinations** — Privacy/Terms/About/Careers all need real URLs eventually; Phase 2 ships with `#` placeholders.
6. **Hero copy** — placeholder copy must be product-reviewed before public release; Phase 2 wiring is copy-agnostic.

---

## 18. Out of Scope — Reserved for Later Phases

| Phase | Scope (tentative) |
|-------|-------------------|
| Phase 3 | Logos strip, Features, How it works, For clinicians, For patients sections |
| Phase 4 | Pricing, Testimonials, FAQ, CTA sections |
| Phase 5 | Arabic + RTL audit, visible dark-mode toggle, language toggle in NavBar/Footer |
| Phase 6 | Lead-capture forms, analytics events, real CTA destinations |
| Phase 7 | SEO meta, Open Graph, sitemap, robots.txt, Lighthouse ≥ 95 |

---

## 19. References

- [phase_1.md](phase_1.md) — Foundation & Architecture (must be complete first).
- `WORKFLOW_RULES.md` — GetX, naming, prohibited patterns.
- `.specify/memory/constitution.md` — Principles I–VII.
- `pubspec.yaml` — packages used in Phase 2: `get`, `flutter_screenutil`, `flutter_svg`, `url_launcher`, `iconsax`, `cached_network_image`.

---

**End of Phase 2 plan. No implementation begins until this document AND the Phase 1 plan are approved.**
