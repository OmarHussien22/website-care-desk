import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_content.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A placeholder partner mark — icon + wordmark in a soft pill.
/// Reads as a muted logo wall; swaps to a real `Image.asset`/SVG later.
class LogoTile extends StatefulWidget {
  const LogoTile({super.key, required this.mark});

  final LogoMark mark;

  @override
  State<LogoTile> createState() => _LogoTileState();
}

class _LogoTileState extends State<LogoTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = LandingColors.textSecondary.withValues(
      alpha: _hovered ? 0.95 : 0.55,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: LandingColors.surfaceElevated.withValues(
            alpha: _hovered ? 1 : 0.6,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: LandingColors.borderSubtle.withValues(
              alpha: _hovered ? 1 : 0.6,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.mark.icon, size: 22, color: color),
            const SizedBox(width: 10),
            CustomText(
              widget.mark.labelKey.tr,
              scaleFont: false,
              fontSize: 16,
              fontWeight: FW.bold,
              fontFamily: 'Montserrat',
              color: color,
              letterSpacing: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
