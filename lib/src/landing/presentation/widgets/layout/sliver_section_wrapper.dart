import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/spacing/app_spacing.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/max_content_width.dart';
import 'package:flutter/widgets.dart';

/// Sliver variant of SectionWrapper for use inside CustomScrollView.
class SliverSectionWrapper extends StatelessWidget {
  const SliverSectionWrapper({
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
  final GlobalKey? sectionKey;
  final Color? background;
  final BoxDecoration? decoration;
  final Widget Function(Widget child)? animationWrapper;
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

    return SliverToBoxAdapter(
      child: Container(
        key: sectionKey,
        width: double.infinity,
        color: decoration == null ? background : null,
        decoration: decoration,
        padding: EdgeInsets.symmetric(vertical: vPad),
        child: MaxContentWidth(child: wrappedContent),
      ),
    );
  }
}
