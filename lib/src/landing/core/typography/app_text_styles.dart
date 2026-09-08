import 'package:flutter/widgets.dart';

import '../breakpoints/responsive.dart';
import '../breakpoints/screen_size.dart';
import 'text_role.dart';

/// Font families used by the landing page.
abstract final class _Fonts {
  static const montserrat = 'Montserrat';
}

/// Responsive font-size tables per TextRole (logical px).
const _sizes = {
  TextRole.displayXL: Responsive<double>(
    mobile: 36,
    tablet: 44,
    laptop: 56,
    desktop: 64,
    ultraWide: 72,
  ),
  TextRole.displayLG: Responsive<double>(
    mobile: 28,
    tablet: 34,
    laptop: 42,
    desktop: 48,
    ultraWide: 54,
  ),
  TextRole.headingLG: Responsive<double>(
    mobile: 22,
    tablet: 26,
    laptop: 30,
    desktop: 34,
    ultraWide: 38,
  ),
  TextRole.headingMD: Responsive<double>(
    mobile: 18,
    tablet: 20,
    laptop: 22,
    desktop: 24,
    ultraWide: 26,
  ),
  TextRole.headingSM: Responsive<double>(
    mobile: 16,
    tablet: 17,
    laptop: 18,
    desktop: 19,
    ultraWide: 20,
  ),
  TextRole.bodyLG: Responsive<double>(
    mobile: 16,
    tablet: 17,
    laptop: 18,
    desktop: 18,
    ultraWide: 18,
  ),
  TextRole.bodyMD: Responsive<double>(
    mobile: 14,
    tablet: 15,
    laptop: 16,
    desktop: 16,
    ultraWide: 16,
  ),
  TextRole.bodySM: Responsive<double>(
    mobile: 12,
    tablet: 13,
    laptop: 14,
    desktop: 14,
    ultraWide: 14,
  ),
  TextRole.caption: Responsive<double>(
    mobile: 11,
    tablet: 12,
    laptop: 12,
    desktop: 12,
    ultraWide: 12,
  ),
  TextRole.button: Responsive<double>(
    mobile: 14,
    tablet: 15,
    laptop: 16,
    desktop: 16,
    ultraWide: 16,
  ),
};

const _weights = {
  TextRole.displayXL: FontWeight.w700,
  TextRole.displayLG: FontWeight.w700,
  TextRole.headingLG: FontWeight.w600,
  TextRole.headingMD: FontWeight.w600,
  TextRole.headingSM: FontWeight.w600,
  TextRole.bodyLG: FontWeight.w400,
  TextRole.bodyMD: FontWeight.w400,
  TextRole.bodySM: FontWeight.w400,
  TextRole.caption: FontWeight.w500,
  TextRole.button: FontWeight.w600,
};

const _families = {
  TextRole.displayXL: _Fonts.montserrat,
  TextRole.displayLG: _Fonts.montserrat,
  TextRole.headingLG: _Fonts.montserrat,
  TextRole.headingMD: _Fonts.montserrat,
  TextRole.headingSM: _Fonts.montserrat,
  TextRole.bodyLG: _Fonts.montserrat,
  TextRole.bodyMD: _Fonts.montserrat,
  TextRole.bodySM: _Fonts.montserrat,
  TextRole.caption: _Fonts.montserrat,
  TextRole.button: _Fonts.montserrat,
};

/// Line-height multipliers.
double _lineHeight(TextRole role) {
  if (role == TextRole.displayXL || role == TextRole.displayLG) return 1.1;
  if (role == TextRole.caption) return 1.4;
  if (role.name.startsWith('body') || role == TextRole.button) return 1.5;
  return 1.25; // headings
}

/// Letter spacing in em (approximated as a fraction of font size).
double? _letterSpacing(TextRole role, double fontSize) {
  if (role == TextRole.displayXL || role == TextRole.displayLG)
    return -0.02 * fontSize;
  if (role.name.startsWith('heading')) return -0.01 * fontSize;
  if (role == TextRole.caption) return 0.02 * fontSize;
  return null; // body / button: 0
}

abstract final class AppTextStyles {
  /// Returns a [TextStyle] for the given [role] resolved for [context]'s breakpoint.
  ///
  /// On laptop+ the size is a fixed logical px value (no screenutil scaling).
  /// On mobile/tablet callers may wrap in screenutil if desired, but the token
  /// already encodes appropriate sizes for those tiers.
  static TextStyle of(BuildContext context, TextRole role, {Color? color}) {
    final size = ScreenSizeX.of(context);
    final fontSize = _sizes[role]!.resolveForSize(size);
    return TextStyle(
      fontFamily: _families[role],
      fontSize: fontSize,
      fontWeight: _weights[role],
      height: _lineHeight(role),
      letterSpacing: _letterSpacing(role, fontSize),
      color: color,
    );
  }
}
