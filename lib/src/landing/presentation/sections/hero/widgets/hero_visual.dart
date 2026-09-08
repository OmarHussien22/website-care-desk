import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/product_screenshot.dart';
import 'package:flutter/material.dart';

/// Right visual column of the hero section.
/// Wraps the illustration in a soft white frame with a tinted glow so it
/// lifts off the gradient background.
class HeroVisual extends StatelessWidget {
  const HeroVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenSizeX.of(context) == ScreenSize.mobile;
    return Transform.rotate(
      angle: isMobile ? 0.0 : -0.012,
      child: const ProductScreenshot(
        frameType: ProductFrameType.browser,
        screen: ProductScreen.dashboard,
        altTextKey: 'product.dashboard',
      ),
    );
  }
}
