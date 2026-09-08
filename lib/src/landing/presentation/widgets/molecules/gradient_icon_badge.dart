import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';

/// Visual style for a [GradientIconBadge].
enum BadgeStyle {
  /// Low-opacity brand-gradient fill with a gradient-shaded glyph (subtle).
  tint,

  /// Solid brand-gradient fill with a white glyph and a soft glow (punchy).
  solid,
}

/// Reusable brand-gradient badge holding either an [icon] or a short [label]
/// (e.g. a step number). Consolidates the badge idiom shared by service cards,
/// feature rows, and timeline step nodes.
class GradientIconBadge extends StatelessWidget {
  const GradientIconBadge({
    super.key,
    this.icon,
    this.label,
    this.size = 52,
    this.iconSize = 26,
    this.radius = 16,
    this.style = BadgeStyle.tint,
  }) : assert(icon != null || label != null, 'Provide an icon or a label.');

  final IconData? icon;
  final String? label;
  final double size;
  final double iconSize;
  final double radius;
  final BadgeStyle style;

  LinearGradient get _gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      LandingColors.accentGradientStart,
      LandingColors.accentGradientEnd,
    ],
  );

  @override
  Widget build(BuildContext context) {
    final solid = style == BadgeStyle.solid;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: solid
            ? _gradient
            : LinearGradient(
                colors: [
                  LandingColors.accentGradientStart.withValues(alpha: 0.12),
                  LandingColors.accentGradientEnd.withValues(alpha: 0.12),
                ],
              ),
        borderRadius: BorderRadius.circular(radius),
        border: solid
            ? null
            : Border.all(
                color: LandingColors.accentGradientStart.withValues(
                  alpha: 0.22,
                ),
              ),
        boxShadow: solid
            ? [
                BoxShadow(
                  color: LandingColors.accent.withValues(alpha: 0.32),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: solid ? _solidChild() : _tintChild(),
    );
  }

  Widget _solidChild() {
    if (icon != null) {
      return Icon(icon, size: iconSize, color: Colors.white);
    }
    return CustomText(
      label!,
      scaleFont: false,
      fontSize: iconSize,
      fontWeight: FW.bold,
      fontFamily: 'Montserrat',
      color: Colors.white,
    );
  }

  Widget _tintChild() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => _gradient.createShader(rect),
      child: icon != null
          ? Icon(icon, size: iconSize, color: Colors.white)
          : CustomText(
              label!,
              scaleFont: false,
              fontSize: iconSize,
              fontWeight: FW.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
    );
  }
}
