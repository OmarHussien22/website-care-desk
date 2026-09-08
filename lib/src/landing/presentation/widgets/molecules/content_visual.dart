import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A framed product-preview visual styled for **light** section backgrounds.
///
/// The Hero's [HeroVisual] frame is white-on-gradient (invisible on white), so
/// content sections (Features, Audience) use this sibling: a soft white card
/// with a subtle accent-tinted backdrop, a faux browser chrome bar, a layered
/// neutral shadow and a faint brand glow — reads as a premium app mockup.
class ContentVisual extends StatelessWidget {
  const ContentVisual({
    super.key,
    this.assetPath = LandingBrand.heroIllustration,
    this.maxWidth = 560,
  });

  final String assetPath;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isMobile = size == ScreenSize.mobile;
    final maxHeight = isMobile ? 300.0 : 440.0;

    return RepaintBoundary(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
        child: Center(
          child: AspectRatio(
            aspectRatio: 480 / 400,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: LandingColors.surfaceElevated,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: LandingColors.borderSubtle),
                boxShadow: [
                  // Soft neutral lift.
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 24),
                  ),
                  // Faint brand glow for depth.
                  BoxShadow(
                    color: LandingColors.accent.withValues(alpha: 0.12),
                    blurRadius: 50,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  children: [
                    const _ChromeBar(),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              LandingColors.accentGradientStart.withValues(
                                alpha: 0.06,
                              ),
                              LandingColors.accentGradientEnd.withValues(
                                alpha: 0.10,
                              ),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: SvgPicture.asset(
                            assetPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Faux browser/app top bar — three traffic-light dots on a tinted strip.
class _ChromeBar extends StatelessWidget {
  const _ChromeBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: LandingColors.surfaceMuted,
        border: Border(bottom: BorderSide(color: LandingColors.borderSubtle)),
      ),
      child: Row(
        children: [
          for (int i = 0; i < 3; i++) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LandingColors.accent.withValues(alpha: 0.18 + i * 0.10),
              ),
            ),
            if (i < 2) const SizedBox(width: 7),
          ],
          const Spacer(),
          Container(
            width: 120,
            height: 10,
            decoration: BoxDecoration(
              color: LandingColors.borderSubtle,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
  }
}
