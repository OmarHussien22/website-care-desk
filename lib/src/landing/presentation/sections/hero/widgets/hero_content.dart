import '../../../../core/breakpoints/screen_size.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/theme/landing_colors.dart';
import '../../../../core/typography/text_role.dart';
import '../../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hero_cta_row.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final centered = !ScreenSizeX.of(context).isLaptopOrLarger;
    final alignment = centered ? TextAlign.center : TextAlign.start;
    final headline = 'hero.headline'.tr;
    final emphasis = 'hero.headline.emph'.tr;
    final emphasisIndex = headline.indexOf(emphasis);

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm.resolve(context),
            vertical: AppSpacing.xs.resolve(context),
          ),
          decoration: BoxDecoration(
            color: LandingColors.surfaceElevated,
            borderRadius: BorderRadius.circular(AppSpacing.xl.resolve(context)),
            border: Border.all(
              color: LandingColors.accent.withValues(alpha: 0.14),
            ),
          ),
          child: CustomText(
            'hero.eyebrow'.tr,
            role: TextRole.caption,
            color: LandingColors.accentGradientEnd,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: AppSpacing.md.resolve(context)),
        Semantics(
          header: true,
          child: Column(
            crossAxisAlignment: centered
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              CustomText(
                emphasisIndex > 0
                    ? headline.substring(0, emphasisIndex).trim()
                    : headline,
                role: TextRole.displayXL,
                color: LandingColors.textPrimary,
                textAlign: alignment,
              ),
              if (emphasisIndex > 0)
                CustomText(
                  headline.substring(emphasisIndex),
                  role: TextRole.displayXL,
                  color: LandingColors.accentGradientEnd,
                  textAlign: alignment,
                ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.md.resolve(context)),
        CustomText(
          'hero.subheadline'.tr,
          role: TextRole.bodyLG,
          color: LandingColors.textSecondary,
          textAlign: alignment,
        ),
        SizedBox(height: AppSpacing.lg.resolve(context)),
        const HeroCtaRow(),
        SizedBox(height: AppSpacing.md.resolve(context)),
        CustomText(
          'hero.trust'.tr,
          role: TextRole.caption,
          color: LandingColors.textSecondary,
          textAlign: alignment,
        ),
      ],
    );
  }
}
