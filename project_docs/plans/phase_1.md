# Phase 1 — Foundation & Architecture

**Project**: Medical Ecosystem Landing Page
**Phase**: 1 of N — Foundation & Architecture
**Status**: Planned (not yet implemented)
**Owner**: Omar
**Date**: 2026-05-24
**Stack**: Flutter (Dart ^3.11.1) · GetX · flutter_screenutil
**Targets**: Web (primary) · iOS · Android · macOS · Windows · Linux

---

## 1. Goal

Establish the structural, responsive, and visual foundation for the Medical Ecosystem Landing Page so that all later phases (section content, animations, integrations) can be added by composition without revisiting the core. No business sections are built in this phase — only the scaffolding.

**Phase 1 ends when** a developer can drop a new section into `lib/src/landing/presentation/sections/` and have it:

- Render at the correct width on every breakpoint without overflow.
- Inherit consistent vertical rhythm and horizontal padding.
- Use the shared typography scale.
- Animate in on scroll with a single line of code.
- Register itself with the landing scroll controller for anchor navigation.

---

## 2. Non-Goals (Explicitly Out of Scope)

The following will NOT be touched in Phase 1:

- Hero section, Features, Pricing, Testimonials, FAQ, CTA, Footer content.
- Real copy, real images, real medical content.
- Backend integration, forms, auth, analytics events.
- SEO meta tags, structured data, sitemap.
- i18n (Arabic/English toggle) — deferred to a dedicated phase.
- Dark mode polish — tokens reserved; full theme audit deferred.
- Pixel-perfect Figma matching — Phase 1 ships a consistent skeleton, not finished visuals.

---

## 3. Requirements Recap

| ID | Requirement | Phase 1 deliverable |
|----|-------------|---------------------|
| R1 | Fully responsive | Breakpoint system + responsive widgets |
| R2 | No overflow | Layout primitives that constrain width and wrap safely |
| R3 | Consistent spacing | Spacing tokens + section wrapper enforcing rhythm |
| R4 | Clean modern SaaS structure | Folder layout + naming conventions documented |
| R5 | Fancy & professional layout | Typography scale + animation hooks + max-content-width container |
| R6 | Component-based architecture | Atoms → molecules → organisms → sections hierarchy |
| R7 | Easy to extend later | "Add a new section" recipe in `sections/README.md` |

---

## 4. Breakpoint System

Five named breakpoints. Numbers are the **minimum** width for each tier (mobile-first).

| Tier | Min width (logical px) | Typical device |
|------|------------------------|----------------|
| `mobile` | 0 | phones |
| `tablet` | 600 | small tablets, large phones landscape |
| `laptop` | 1024 | iPads landscape, small laptops |
| `desktop` | 1440 | standard desktop monitors |
| `ultraWide` | 1920 | 4K, ultrawide monitors |

**Design content max-width**: `1440px`. Beyond `ultraWide`, content stays centered with empty gutters; only the background extends edge-to-edge.

**Implementation contract** (no code in this doc — only the API surface):

- `enum ScreenSize { mobile, tablet, laptop, desktop, ultraWide }`
- `ScreenSize ScreenSizeX.of(BuildContext)` — derives from `MediaQuery.size.width`.
- `Responsive<T>` — a value holder: `Responsive<double>(mobile: 16, tablet: 20, laptop: 24, desktop: 28, ultraWide: 32).resolve(context)`. Missing tiers fall back to the next-smaller defined tier.
- `ResponsiveBuilder` widget — builds different children per breakpoint without manually checking widths.

**screenutil interaction**: `flutter_screenutil` stays as the unit system for **mobile/tablet** (`.toW`, `.toH`, `.toFS`). For `laptop+`, the page switches to fixed/constrained layouts where `screenutil` scaling is bypassed in favor of the `Responsive<T>` API. This avoids the "huge text on 4K" pitfall.

---

## 5. Spacing System

Global spacing tokens defined once in `AppSpacing`. No raw pixel literals anywhere in landing code.

**Token scale** (each token is itself a `Responsive<double>`):

| Token | Mobile | Tablet | Laptop | Desktop | Ultrawide |
|-------|-------:|-------:|-------:|--------:|----------:|
| `xxs` | 4 | 4 | 4 | 4 | 4 |
| `xs` | 8 | 8 | 8 | 8 | 8 |
| `sm` | 12 | 14 | 16 | 16 | 16 |
| `md` | 16 | 20 | 24 | 24 | 24 |
| `lg` | 24 | 32 | 40 | 48 | 56 |
| `xl` | 40 | 56 | 72 | 88 | 104 |
| `section` | 64 | 80 | 96 | 120 | 144 |

**Usage rules**:

- Section vertical padding = `AppSpacing.section`.
- Inner section content gap = `AppSpacing.lg`.
- Element-to-element gap within a card/row = `AppSpacing.md` or smaller.
- Horizontal page padding = `AppSpacing.md` (mobile/tablet) auto-resolved; on `laptop+` the page max-width of 1440 takes over.
- Existing `.ESH()` / `.ESW()` helpers remain valid for mobile-only widgets, but **landing code** uses `AppSpacing` exclusively for consistency.

---

## 6. Typography System

Two font families already bundled: `URW` (display/heading) + `Montserrat` (body). Phase 1 picks display vs body assignments and defines a responsive scale.

**Roles & responsive sizes** (font size in logical px):

| Role | Family | Weight | Mobile | Tablet | Laptop | Desktop | Ultrawide |
|------|--------|--------|-------:|-------:|-------:|--------:|----------:|
| `displayXL` | URW | 700 | 36 | 44 | 56 | 64 | 72 |
| `displayLG` | URW | 700 | 28 | 34 | 42 | 48 | 54 |
| `headingLG` | URW | 600 | 22 | 26 | 30 | 34 | 38 |
| `headingMD` | URW | 600 | 18 | 20 | 22 | 24 | 26 |
| `headingSM` | URW | 600 | 16 | 17 | 18 | 19 | 20 |
| `bodyLG` | Montserrat | 400 | 16 | 17 | 18 | 18 | 18 |
| `bodyMD` | Montserrat | 400 | 14 | 15 | 16 | 16 | 16 |
| `bodySM` | Montserrat | 400 | 12 | 13 | 14 | 14 | 14 |
| `caption` | Montserrat | 500 | 11 | 12 | 12 | 12 | 12 |
| `button` | Montserrat | 600 | 14 | 15 | 16 | 16 | 16 |

**Line-height ratios**: display = 1.1, heading = 1.25, body = 1.5, caption = 1.4.

**Letter spacing**: display = `-0.02em`, heading = `-0.01em`, body = `0`, caption = `0.02em`.

`CustomText` (already used by the project per `WORKFLOW_RULES.md`) gets a `role` parameter that maps to these tokens. Raw `TextStyle` overrides remain possible but discouraged.

---

## 7. Section Architecture

Every landing section is a self-contained widget that extends a thin `LandingSection` contract.

**Contract**:

- Each section has a unique string id (`hero`, `features`, `pricing`, …).
- Each section registers a `GlobalKey` with `LandingScrollController` on mount so the navbar can scroll-to-anchor.
- Each section wraps its body in `SectionWrapper`, which handles:
  - Outer vertical padding (`AppSpacing.section`).
  - Outer background (color, gradient, or image — passed in).
  - Inner content centered and capped at `1440px` max width.
  - Inner horizontal padding for `mobile`/`tablet`.
  - Optional id/anchor key forwarding.
  - Optional on-enter animation trigger.

**Folder convention** — one folder per section:

```
sections/
  hero/
    hero_section.dart           ← extends LandingSection
    widgets/                    ← section-local widgets only
  features/
    features_section.dart
    widgets/
  …
  sections.dart                 ← barrel re-exports
  README.md                     ← "How to add a new section" recipe
```

**Add-a-section recipe** (lives in `sections/README.md`):

1. Create `sections/<name>/` folder.
2. Create `<name>_section.dart` extending `LandingSection`.
3. Wrap the build output in `SectionWrapper(id: '<name>', child: ...)`.
4. Add the section to `LandingPage`'s ordered list.
5. (Optional) Add a navbar link entry pointing to the section id.

This recipe is the **contract** that keeps Phase 2+ work mechanical.

---

## 8. Shared Widgets — Atomic Hierarchy

```
widgets/
  atoms/                ← single-purpose primitives, zero composition
    app_button.dart     ← primary / secondary / ghost variants
    app_icon.dart       ← wraps Iconsax / SVG
    app_image.dart      ← wraps cached_network_image + flutter_svg
    app_divider.dart
    app_gradient_text.dart
  molecules/            ← small compositions of atoms
    stat_card.dart      ← number + label + optional icon
    feature_card.dart   ← icon + heading + body
    badge_chip.dart
    avatar.dart
  organisms/            ← complex composites used across sections
    nav_bar.dart        ← responsive nav (drawer on mobile)
    footer.dart         ← (skeleton only in Phase 1)
    cta_block.dart
  layout/               ← layout primitives, no visual identity
    section_wrapper.dart        ← the section contract host
    responsive_builder.dart     ← per-breakpoint child switcher
    max_content_width.dart      ← 1440px cap + centering
    responsive_row.dart         ← row that becomes column on mobile
    responsive_grid.dart        ← 1/2/3/4-col grid by breakpoint
    sliver_section_wrapper.dart ← sliver variant for nested scrolls
```

Phase 1 ships **only the layout primitives + skeletons of atoms** (button, icon, image). Molecules and organisms are stubs with TODOs — they get bodies in Phase 2 alongside the sections that use them.

---

## 9. Scrolling Foundation

**Decision**: single-page landing with anchor navigation. `CustomScrollView` + `SliverList` is the spine.

**Why CustomScrollView**: lets future sections inject `SliverAppBar`, `SliverPersistentHeader`, or parallax slivers without restructuring the page.

**Controller** (`LandingScrollController`, GetX):

- Holds the `ScrollController`.
- Holds a `Map<String, GlobalKey>` registered by sections on mount.
- Exposes `scrollTo(String sectionId, {Duration? duration, Curve? curve})`.
- Exposes `currentSectionId` (reactive) for nav-link highlighting in Phase 2.
- Disposes the `ScrollController` in `onClose()`.

**Smooth scrolling**:

- `Curves.easeInOutCubic`, `duration` = 600–900ms based on distance.
- On web, suppress default browser anchor scroll-jump (use `Router` neglect on hash changes if URLs are used later).

**Performance guardrails**:

- All section widgets are `const` where possible.
- Heavy widgets (images, animations) gated behind `VisibilityDetector`-style hooks (added in Phase 2; structure prepared now).

---

## 10. Animation Structure

Phase 1 ships the **tokens and reusable wrappers**, not actual animated content.

**Tokens** (`AppAnimations`):

- Durations: `fast = 200ms`, `medium = 400ms`, `slow = 700ms`, `entrance = 900ms`.
- Curves: `standard = Curves.easeInOutCubic`, `entrance = Curves.easeOutCubic`, `emphasized = Curves.easeOutBack`.
- Stagger step: `80ms` (used by lists of cards entering one-by-one).

**Reusable animation wrappers**:

- `FadeInOnScroll` — fades + slides up child when it enters viewport. Configurable delay + offset.
- `StaggeredChildren` — applies `FadeInOnScroll` with incremental delays to a list of children.
- `HoverScale` — web-only hover scale + shadow lift for interactive cards.
- `GradientShimmer` — subtle background animation primitive for hero/CTAs.

`flutter_staggered_animations` (already in `pubspec.yaml`) backs the stagger wrapper; `lottie` remains available for richer illustrations introduced in later phases.

**Constraints**:

- No section may animate more than 2 concurrent properties (opacity + offset) on mobile.
- Animations respect `MediaQuery.disableAnimations` (accessibility).

---

## 11. Theming

Reuse the existing `AppColors.get.*` system. Phase 1 adds **landing-specific tokens** without breaking the auth-screen palette.

**New tokens** (added to `LightColor` and `DarkColor`):

- `surfaceMuted` — section background alternation
- `surfaceElevated` — card background
- `borderSubtle` — 1px hairlines
- `accentGradientStart` / `accentGradientEnd` — hero/CTA gradients
- `textPrimary`, `textSecondary`, `textInverse`

**Background alternation rule**: every other section uses `surfaceMuted` to create visual rhythm. The `SectionWrapper` reads an optional `background` parameter; the page-level orchestration alternates by default.

**Dark mode**: tokens defined in both `LightColor` and `DarkColor` from day one, even if the visual polish lands later.

---

## 12. Routing

**Phase 1 routes**:

- `AppRoutes.landing = '/landing'` (or `/` — see Decision below).
- Registered in `AppRouter.pages` per project convention.

**Decision — landing as root vs `/landing`**: the app currently uses `/splash` as the default landing. Phase 1 keeps `/landing` as a distinct route to avoid disturbing the existing auth flow. A later phase decides whether the landing replaces splash for web builds.

**Anchor URLs (web)**: out of scope for Phase 1. The `LandingScrollController` exposes `scrollTo(id)`; URL hash sync (`#features`, `#pricing`) is a Phase 2 task.

---

## 13. State Management

GetX only, per the project constitution.

**Controllers introduced in Phase 1**:

- `LandingScrollController` — owns the scroll controller, section keys, scroll-to API.
- `LandingThemeController` *(optional, deferred)* — only if dark-mode toggle ships in Phase 1; otherwise Phase 3+.

Sections themselves remain stateless until a section needs interactivity. No per-section controllers in Phase 1.

---

## 14. Proposed Folder Structure

```text
lib/
  src/
    landing/                                  ← NEW feature root
      core/
        breakpoints/
          screen_size.dart                    ← enum + BuildContext extension
          responsive.dart                     ← Responsive<T> + ResponsiveBuilder
        spacing/
          app_spacing.dart                    ← spacing tokens
        typography/
          app_text_styles.dart                ← role→TextStyle map
          text_role.dart                      ← enum TextRole
        animations/
          app_animations.dart                 ← durations, curves, stagger
          fade_in_on_scroll.dart
          staggered_children.dart
          hover_scale.dart
        scrolling/
          landing_scroll_controller.dart
          section_anchor.dart                 ← mixin/helper for key registration
        theme/
          landing_colors.dart                 ← landing-specific token getters
      presentation/
        pages/
          landing_page.dart                   ← single-page scaffold
        sections/                             ← EMPTY in Phase 1
          README.md                           ← add-a-section recipe
          sections.dart                       ← barrel (empty list for now)
        widgets/
          atoms/
            app_button.dart                   ← skeleton + variants enum
            app_icon.dart
            app_image.dart
            app_divider.dart
          molecules/                          ← stub files with TODOs
          organisms/                          ← stub files with TODOs
          layout/
            section_wrapper.dart
            responsive_builder.dart
            max_content_width.dart
            responsive_row.dart
            responsive_grid.dart
            sliver_section_wrapper.dart
```

**What stays untouched**: `lib/src/core/*`, `lib/src/features/auth/*`, `lib/src/shared/*`, `lib/src/super/*`. Phase 1 is additive only.

---

## 15. Constitution Compliance Check

Per `.specify/memory/constitution.md` and `WORKFLOW_RULES.md`:

| Principle | How Phase 1 honors it |
|-----------|----------------------|
| I. GetX state & nav | `LandingScrollController` is a `GetxController`; routing via `AppRoutes` + `AppRouter.pages` |
| II. Feature-first clean arch | `landing/` follows `core/data/domain/presentation` layout (data/domain empty — added when sections need APIs) |
| III. Type & null safety | No `!` on responsive maps; missing-tier fallback explicit; controllers disposed in `onClose()` |
| IV. UI & styling discipline | No raw pixels in landing code (tokens only); no hardcoded colors (`AppColors.get.*`); no raw `Text` (`CustomText`); no `google_fonts` (URW + Montserrat already bundled) |
| V. Observability | All controllers use `log('...', name: '...')`; no `print` |
| VI. Testability & app modes | Landing has no network calls in Phase 1, so `testData` N/A; will apply when data-driven sections arrive |
| VII. Quality gate | `flutter analyze .` must pass before Phase 1 PR merges; new route added to `AppRoutes` + `AppRouter.pages` |

No constitution violations anticipated. No Complexity Tracking entries needed.

---

## 16. Acceptance Criteria (Definition of Done)

Phase 1 is complete when **all** of the following are true:

- [ ] `lib/src/landing/` folder exists with the structure in §14.
- [ ] `ScreenSize` enum + `Responsive<T>` work in a smoke widget at every breakpoint (verify via `flutter run -d chrome` and resizing the window).
- [ ] `AppSpacing` tokens resolve correctly per breakpoint.
- [ ] `AppTextStyles` produces a different size for `displayXL` at mobile vs ultrawide.
- [ ] `SectionWrapper` renders a placeholder section that:
  - Never overflows horizontally at any breakpoint (verified at 360, 768, 1280, 1600, 2400 px widths).
  - Caps inner content at 1440px on desktop+.
  - Applies `AppSpacing.section` vertical padding.
- [ ] `FadeInOnScroll` animates a placeholder child when scrolled into view.
- [ ] `LandingScrollController` exposes `scrollTo('placeholder')` and a registered key actually scrolls there smoothly.
- [ ] `LandingPage` renders one placeholder `SectionWrapper` (proves the spine works end-to-end).
- [ ] `AppRoutes.landing` is reachable via `Get.toNamed`.
- [ ] `flutter analyze .` returns zero errors.
- [ ] `sections/README.md` documents the add-a-section recipe.
- [ ] No hardcoded colors, no raw pixel values, no raw `Text()` widgets in any new file.

---

## 17. Implementation Task Breakdown

Suggested order (one PR per group, or a single Phase 1 PR if preferred):

**Group A — Tokens & responsive primitives** *(blocks everything else)*

1. `screen_size.dart` — enum + extension.
2. `responsive.dart` — `Responsive<T>` + `ResponsiveBuilder`.
3. `app_spacing.dart` — spacing tokens.
4. `app_text_styles.dart` + `text_role.dart` — typography tokens.
5. `landing_colors.dart` + amend `LightColor` / `DarkColor` with new tokens.

**Group B — Layout primitives** *(depends on A)*

6. `max_content_width.dart`.
7. `section_wrapper.dart` (no-anim variant first; anim hook added in Group D).
8. `responsive_row.dart` + `responsive_grid.dart`.
9. `sliver_section_wrapper.dart`.

**Group C — Scrolling**

10. `landing_scroll_controller.dart`.
11. `section_anchor.dart` mixin.

**Group D — Animations**

12. `app_animations.dart`.
13. `fade_in_on_scroll.dart`.
14. `staggered_children.dart`.
15. `hover_scale.dart`.
16. Wire `SectionWrapper` to optionally use `FadeInOnScroll`.

**Group E — Atoms (skeleton only)**

17. `app_button.dart` with variants enum, no styling yet.
18. `app_icon.dart`, `app_image.dart`, `app_divider.dart`.

**Group F — Page & route**

19. `landing_page.dart` with one placeholder section.
20. Register `AppRoutes.landing` + `AppRouter.pages` entry.

**Group G — Docs & verification**

21. `sections/README.md` add-a-section recipe.
22. Run `flutter analyze .`, fix any issues.
23. Manual breakpoint sweep at 360 / 768 / 1280 / 1600 / 2400 px on Chrome.

Estimated effort: **2–3 working days** if done in a single push.

---

## 18. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------:|-------:|------------|
| Mixing `screenutil` scaling with `Responsive<T>` causes inconsistent sizes | Medium | High | Document clear rule: screenutil for mobile/tablet only; `Responsive<T>` overrides on laptop+. Add lint comment in `screen_size.dart`. |
| Sections built later ignore `SectionWrapper` and reintroduce raw padding | Medium | High | Code review checklist + `sections/README.md` recipe is authoritative. |
| 4K / ultrawide produces oversized text because nothing caps it | High if not addressed | High | Typography table in §6 has explicit ultrawide caps; max-content-width at 1440 prevents horizontal stretch. |
| Animations cause jank on low-end mobile | Medium | Medium | Animation rules in §10 (max 2 concurrent properties on mobile, respect `disableAnimations`). |
| Dark-mode tokens added later cause a big-bang refactor | Low | Medium | Both `LightColor` and `DarkColor` get the new tokens in Phase 1 even if values are placeholders. |
| URL hash navigation (`#features`) becomes hard to retrofit | Low | Low | Scroll API is centralized in `LandingScrollController`; adding URL sync is one file change in Phase 2. |

---

## 19. Open Questions (to confirm before Phase 2)

These do **not** block Phase 1 but should be answered before Phase 2 starts:

1. **Landing as root or separate route?** Currently planned as `/landing`. If web build replaces splash, this changes.
2. **i18n in Phase 2 or later?** Affects whether section copy uses `.toTr()` from day one.
3. **Section order?** Hero → Features → How-it-works → For-clinicians → For-patients → Pricing → Testimonials → FAQ → CTA → Footer — needs product sign-off.
4. **Dark mode toggle visible in v1 launch?** Affects controller scope.
5. **Brand color palette confirmed?** Phase 1 uses placeholder accents; final palette before Phase 2.

---

## 20. Out of Scope — Reserved for Later Phases

| Phase | Scope (tentative) |
|-------|-------------------|
| Phase 2 | Hero + NavBar + Footer real content; section order finalized; URL hash navigation |
| Phase 3 | Features, How-it-works, For-clinicians, For-patients sections |
| Phase 4 | Pricing, Testimonials, FAQ sections + CTA |
| Phase 5 | i18n (Arabic/English), RTL audit, dark mode polish |
| Phase 6 | SEO, analytics, lead-capture form integration |
| Phase 7 | Performance pass: image optimization, code-splitting (web), Lighthouse target ≥ 95 |

---

## 21. References

- `WORKFLOW_RULES.md` — naming, GetX patterns, prohibited patterns.
- `.specify/memory/constitution.md` — Principles I–VII.
- `pubspec.yaml` — already-available packages used by Phase 1 (`get`, `flutter_screenutil`, `flutter_svg`, `lottie`, `flutter_staggered_animations`, `cached_network_image`, `iconsax`).

---

**End of Phase 1 plan. No implementation begins until this document is approved.**
