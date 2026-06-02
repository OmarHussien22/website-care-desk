import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

/// Convenience accessors for landing-specific color tokens.
/// Always reads from the currently active theme (light / dark).
abstract final class LandingColors {
  static Color get surfaceMuted => AppColors.get.surfaceMuted;
  static Color get surfaceElevated => AppColors.get.surfaceElevated;
  static Color get borderSubtle => AppColors.get.borderSubtle;
  static Color get accentGradientStart => AppColors.get.accentGradientStart;
  static Color get accentGradientEnd => AppColors.get.accentGradientEnd;
  static Color get textPrimary => AppColors.get.textPrimary;
  static Color get textSecondary => AppColors.get.textSecondary;
  static Color get textInverse => AppColors.get.textInverse;

  static LinearGradient get accentGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [accentGradientStart, accentGradientEnd],
      );

  /// Solid CTA fill — sky-600, contrasts against gradient and white surfaces.
  static const Color accent = Color(0xFF0284C7);

  /// CTA hover — sky-700.
  static const Color accentHover = Color(0xFF0369A1);

  /// Emerald green for positive indicators and emphasized headline text.
  static Color get success => AppColors.get.success;
}
