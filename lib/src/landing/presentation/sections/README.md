# How to Add a New Landing Section

Follow these five steps every time you add a section. Do not deviate — this keeps the architecture consistent across phases.

---

## 1. Create the section folder

```
sections/
  <name>/
    <name>_section.dart     ← main section widget
    widgets/                ← section-local widgets only (not shared)
```

Example: for the "features" section →
`sections/features/features_section.dart`

---

## 2. Write the section widget

The section widget must be a `StatefulWidget` so it can use the `SectionAnchor` mixin.

```dart
class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> with SectionAnchor {
  @override
  String get sectionId => 'features';   // unique string id

  @override
  void initState() {
    super.initState();
    registerAnchor();                    // registers GlobalKey with LandingScrollController
  }

  @override
  void dispose() {
    unregisterAnchor();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: anchorKey,             // forwards the anchor key
      background: LandingColors.surfaceElevated,
      animationWrapper: (child) => FadeInOnScroll(child: child),
      child: /* your content here */,
    );
  }
}
```

**Rules enforced by `SectionWrapper`:**
- Vertical padding is `AppSpacing.section` (override via `verticalPaddingOverride`).
- Content is capped at 1440px on desktop+.
- Mobile/tablet get horizontal padding from `AppSpacing.md`.

---

## 3. Alternate backgrounds

Sections alternate between `surfaceElevated` (white / dark card) and `surfaceMuted` (off-white / dark muted). By convention, odd-indexed sections use `surfaceMuted`:

```dart
background: sectionIndex.isOdd
    ? LandingColors.surfaceMuted
    : LandingColors.surfaceElevated,
```

---

## 4. Register in `LandingPage`

Open `lib/src/landing/presentation/pages/landing_page.dart` and add your section to the `slivers` list in order:

```dart
slivers: [
  SliverSectionWrapper(child: const HeroSection()),
  SliverSectionWrapper(child: const FeaturesSection()),  // ← add here
  ...
],
```

---

## 5. (Optional) Add a navbar link

If the section should appear in the navbar, add an entry to `LandingNavBar`'s link list pointing to the section's `sectionId`. The navbar calls `LandingScrollController.scrollTo(id)` to animate there.

---

## Token cheat-sheet

| Need | Token |
|------|-------|
| Vertical section padding | `AppSpacing.section.resolve(context)` |
| Inner content gap | `AppSpacing.lg.resolve(context)` |
| Card-level gap | `AppSpacing.md.resolve(context)` |
| Typography | `AppTextStyles.of(context, TextRole.displayXL)` |
| Colors | `LandingColors.textPrimary`, `.surfaceMuted`, `.accentGradient`, … |
| Breakpoint check | `context.screenSize`, `ScreenSizeX.of(context)` |
| Staggered entrance | `StaggeredChildren(children: [...])` |
| Hover effect (web) | `HoverScale(child: ...)` |
