import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Centered section header: a pill eyebrow + display title + optional subtitle.
/// Standardizes the header idiom across content sections.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrowKey,
    required this.titleKey,
    this.subtitleKey,
    this.subtitleMaxWidth = 600,
  });

  final String eyebrowKey;
  final String titleKey;
  final String? subtitleKey;
  final double subtitleMaxWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EyebrowPill(labelKey: eyebrowKey),
        const SizedBox(height: 18),
        CustomText(
          titleKey.tr,
          role: TextRole.displayLG,
          fontWeight: FW.bold,
          fontFamily: 'Montserrat',
          color: LandingColors.textPrimary,
          textAlign: TextAlign.center,
        ),
        if (subtitleKey != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: subtitleMaxWidth),
            child: CustomText(
              subtitleKey!.tr,
              role: TextRole.bodyLG,
              color: LandingColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}

/// Small rounded "eyebrow" pill with a leading dot — brand-accent tinted.
class EyebrowPill extends StatelessWidget {
  const EyebrowPill({super.key, required this.labelKey});

  final String labelKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: LandingColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: LandingColors.accent.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: LandingColors.accent,
            ),
          ),
          const SizedBox(width: 8),
          CustomText(
            labelKey.tr,
            scaleFont: false,
            fontSize: 12.5,
            fontWeight: FW.semiBold,
            fontFamily: 'Montserrat',
            color: LandingColors.accent,
            letterSpacing: 0.6,
          ),
        ],
      ),
    );
  }
}
