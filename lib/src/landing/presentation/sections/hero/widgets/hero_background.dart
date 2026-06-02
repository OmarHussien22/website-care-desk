import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:flutter/material.dart';

/// Layered hero background:
///  - base brand gradient
///  - two soft blurred orbs (top-right, bottom-left)
///  - subtle dot grid texture
///  - edge vignette for depth
class HeroBackground extends StatelessWidget {
  const HeroBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRect(
        child: Stack(
          children: [
          // Base gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    LandingColors.accentGradientStart,
                    LandingColors.accentGradientEnd,
                  ],
                ),
              ),
            ),
          ),

          // Top-right orb
          Positioned(
            top: -120,
            right: -80,
            child: _Orb(
              size: 360,
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),

          // Bottom-left orb
          Positioned(
            bottom: -160,
            left: -100,
            child: _Orb(
              size: 420,
              color: LandingColors.accentGradientEnd.withValues(alpha: 0.35),
            ),
          ),

          // Mid-right secondary orb
          Positioned(
            top: 120,
            right: 200,
            child: _Orb(
              size: 180,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),

          // Dot grid texture
          Positioned.fill(
            child: CustomPaint(
              painter: _DotGridPainter(
                color: Colors.white.withValues(alpha: 0.06),
                spacing: 28,
                radius: 1.1,
              ),
            ),
          ),

          // Subtle bottom vignette for depth
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    LandingColors.accent.withValues(alpha: 0.12),
                  ],
                  stops: const [0.7, 1.0],
                ),
              ),
            ),
          ),

          child,
        ],
        ),
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  _DotGridPainter({
    required this.color,
    required this.spacing,
    required this.radius,
  });

  final Color color;
  final double spacing;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter old) =>
      old.color != color || old.spacing != spacing || old.radius != radius;
}
