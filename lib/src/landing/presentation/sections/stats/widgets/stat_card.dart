import 'package:coursaty/src/landing/core/animations/animated_counter.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_metrics.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A single statistic: gradient icon badge, animated count-up value, and label.
class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.item, this.numberFontSize = 40});

  final StatItem item;
  final double numberFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _IconBadge(icon: item.icon),
        const SizedBox(height: 16),
        AnimatedCounter(
          target: item.target,
          suffix: item.suffix,
          fontSize: numberFontSize,
          color: LandingColors.textPrimary,
        ),
        const SizedBox(height: 6),
        CustomText(
          item.labelKey.tr,
          scaleFont: false,
          fontSize: 15,
          fontWeight: FW.medium,
          fontFamily: 'Montserrat',
          color: LandingColors.textSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LandingColors.accentGradientStart.withValues(alpha: 0.12),
            LandingColors.accentGradientEnd.withValues(alpha: 0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: LandingColors.accentGradientStart.withValues(alpha: 0.20),
        ),
      ),
      alignment: Alignment.center,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (rect) => LinearGradient(
          colors: [
            LandingColors.accentGradientStart,
            LandingColors.accentGradientEnd,
          ],
        ).createShader(rect),
        child: Icon(icon, size: 28, color: Colors.white),
      ),
    );
  }
}
