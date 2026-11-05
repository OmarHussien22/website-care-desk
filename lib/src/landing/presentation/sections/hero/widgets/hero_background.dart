import '../../../../core/theme/landing_colors.dart';
import 'package:flutter/material.dart';

/// Static radial washes give depth without per-frame gradient or blur work.
class HeroBackground extends StatelessWidget {
  const HeroBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        center: Directionality.of(context) == TextDirection.rtl
            ? Alignment.centerLeft
            : Alignment.centerRight,
        radius: 0.85,
        colors: [
          LandingColors.heroHighlight.withValues(alpha: 0.45),
          LandingColors.surfaceMuted,
        ],
      ),
      border: Border(bottom: BorderSide(color: LandingColors.borderSubtle)),
    ),
    child: child,
  );
}
