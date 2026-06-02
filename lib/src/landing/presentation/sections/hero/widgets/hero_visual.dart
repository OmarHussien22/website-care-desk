import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Right visual column of the hero section.
/// Wraps the illustration in a soft white frame with a tinted glow so it
/// lifts off the gradient background.
class HeroVisual extends StatelessWidget {
  const HeroVisual({
    super.key,
    this.assetPath = LandingBrand.heroIllustration,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isMobile = size == ScreenSize.mobile;
    final maxHeight = isMobile ? 280.0 : 460.0;

    return RepaintBoundary(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Center(
          child: AspectRatio(
            aspectRatio: 480 / 400,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.20),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 40,
                    offset: const Offset(0, 24),
                  ),
                  BoxShadow(
                    color: LandingColors.accentGradientStart
                        .withValues(alpha: 0.35),
                    blurRadius: 60,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SvgPicture.asset(
                    assetPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
