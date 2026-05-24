import 'package:flutter/widgets.dart';

import '../breakpoints/responsive.dart';

/// Responsive spacing tokens. Use these everywhere in landing code — no raw pixel literals.
///
/// Section vertical padding  → AppSpacing.section
/// Inner section content gap → AppSpacing.lg
/// Element-to-element gap    → AppSpacing.md or smaller
/// Horizontal page padding   → AppSpacing.md (mobile/tablet); on laptop+ MaxContentWidth takes over
abstract final class AppSpacing {
  static const xxs = Responsive<double>(mobile: 4, tablet: 4, laptop: 4, desktop: 4, ultraWide: 4);
  static const xs = Responsive<double>(mobile: 8, tablet: 8, laptop: 8, desktop: 8, ultraWide: 8);
  static const sm = Responsive<double>(mobile: 12, tablet: 14, laptop: 16, desktop: 16, ultraWide: 16);
  static const md = Responsive<double>(mobile: 16, tablet: 20, laptop: 24, desktop: 24, ultraWide: 24);
  static const lg = Responsive<double>(mobile: 24, tablet: 32, laptop: 40, desktop: 48, ultraWide: 56);
  static const xl = Responsive<double>(mobile: 40, tablet: 56, laptop: 72, desktop: 88, ultraWide: 104);
  static const section = Responsive<double>(mobile: 64, tablet: 80, laptop: 96, desktop: 120, ultraWide: 144);

  /// Convenience: resolve a token directly from context.
  static double resolve(BuildContext context, Responsive<double> token) =>
      token.resolve(context);
}
