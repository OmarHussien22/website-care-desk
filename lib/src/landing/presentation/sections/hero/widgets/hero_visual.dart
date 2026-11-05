import '../../../../core/animations/fade_in_on_scroll.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/theme/landing_colors.dart';
import '../../../../core/typography/text_role.dart';
import '../../../widgets/molecules/product_screenshot.dart';
import '../../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Composited, finite entrances around a cached vector product preview.
class HeroVisual extends StatelessWidget {
  const HeroVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final gap = AppSpacing.md.resolve(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(gap),
          decoration: BoxDecoration(
            color: LandingColors.heroHighlight.withValues(alpha: 0.34),
            borderRadius: BorderRadius.circular(AppSpacing.lg.resolve(context)),
            border: Border.all(
              color: LandingColors.accent.withValues(alpha: 0.09),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacing.xs.resolve(context)),
                    decoration: BoxDecoration(
                      color: LandingColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.sm.resolve(context),
                      ),
                    ),
                    child: Icon(
                      Icons.space_dashboard_outlined,
                      color: LandingColors.accent,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm.resolve(context)),
                  Expanded(
                    child: CustomText(
                      'hero.workspace'.tr,
                      role: TextRole.caption,
                      color: LandingColors.accent,
                    ),
                  ),
                  Icon(Icons.more_horiz_rounded, color: LandingColors.accent),
                ],
              ),
              SizedBox(height: gap),
              FadeInOnScroll(
                delay: const Duration(milliseconds: 160),
                child: Transform.rotate(
                  angle: -0.025,
                  child: const AspectRatio(
                    aspectRatio: 1.5,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: ProductScreenshot.previewWidth,
                        child: ProductScreenshot(useCompactLayout: false),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: gap),
              Container(
                padding: EdgeInsets.all(AppSpacing.sm.resolve(context)),
                decoration: BoxDecoration(
                  color: LandingColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.sm.resolve(context),
                  ),
                  border: Border.all(color: LandingColors.borderSubtle),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppSpacing.xs.resolve(context)),
                      decoration: BoxDecoration(
                        color: LandingColors.success.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: LandingColors.success,
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.resolve(context)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'hero.connected.title'.tr,
                            role: TextRole.bodySM,
                            fontWeight: FW.semiBold,
                            color: LandingColors.textPrimary,
                          ),
                          CustomText(
                            'hero.connected.desc'.tr,
                            role: TextRole.caption,
                            color: LandingColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.auto_awesome_outlined,
                      color: LandingColors.secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.sm.resolve(context)),
        CustomText(
          'hero.preview'.tr,
          role: TextRole.caption,
          color: LandingColors.textSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
