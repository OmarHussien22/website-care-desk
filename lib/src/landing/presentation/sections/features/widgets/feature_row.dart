import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/data/landing_content.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/gradient_icon_badge.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A single feature: gradient icon badge + title + description.
/// Tints its surface softly on hover (pointer devices).
class FeatureRow extends StatefulWidget {
  const FeatureRow({super.key, required this.item});

  final FeatureItem item;

  @override
  State<FeatureRow> createState() => _FeatureRowState();
}

class _FeatureRowState extends State<FeatureRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _hovered
              ? LandingColors.accent.withValues(alpha: 0.04)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? LandingColors.accent.withValues(alpha: 0.12)
                : Colors.transparent,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientIconBadge(icon: widget.item.icon, size: 48, iconSize: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    widget.item.titleKey.tr,
                    role: TextRole.headingSM,
                    fontWeight: FW.bold,
                    fontFamily: 'Montserrat',
                    color: LandingColors.textPrimary,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    widget.item.descKey.tr,
                    role: TextRole.bodyMD,
                    color: LandingColors.textSecondary,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
