import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/spacing/app_spacing.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/max_content_width.dart';
import 'package:flutter/widgets.dart';

/// Standard wrapper for every landing page section.
///
/// Handles:
/// - Outer vertical padding (AppSpacing.section)
/// - Full-width background (color or decoration)
/// - MaxContentWidth centering at 1440px
/// - Inner horizontal padding on mobile/tablet
/// - Optional anchor [GlobalKey] forwarding for scroll-to-anchor
/// - Optional on-enter animation trigger via [animationWrapper]
class SectionWrapper extends StatelessWidget {
  const SectionWrapper({
    super.key,
    required this.child,
    this.sectionKey,
    this.background,
    this.decoration,
    this.animationWrapper,
    this.verticalPaddingOverride,
  }) : assert(
          background == null || decoration == null,
          'Provide either background or decoration, not both.',
        );

  final Widget child;

  /// Key registered with LandingScrollController for anchor navigation.
  final GlobalKey? sectionKey;

  /// Flat background color. Mutually exclusive with [decoration].
  final Color? background;

  /// Full background decoration (gradient, image…). Mutually exclusive with [background].
  final BoxDecoration? decoration;

  /// Wraps the inner content with an animation (e.g. FadeInOnScroll).
  /// If null, child is rendered directly.
  final Widget Function(Widget child)? animationWrapper;

  /// Override vertical padding (defaults to AppSpacing.section).
  final Responsive<double>? verticalPaddingOverride;

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final vPad = (verticalPaddingOverride ?? AppSpacing.section).resolveForSize(size);
    final hPad = size.isLaptopOrLarger ? 0.0 : AppSpacing.md.resolveForSize(size);

    final innerContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: child,
    );

    final wrappedContent = animationWrapper != null
        ? animationWrapper!(innerContent)
        : innerContent;

    final body = Container(
      key: sectionKey,
      width: double.infinity,
      color: decoration == null ? background : null,
      decoration: decoration,
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: MaxContentWidth(child: wrappedContent),
    );

    return body;
  }
}
