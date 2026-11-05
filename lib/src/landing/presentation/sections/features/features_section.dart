import '../../../core/breakpoints/screen_size.dart';
import '../../../core/navigation/meddesk_actions.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/landing_colors.dart';
import '../../../core/typography/text_role.dart';
import '../../../data/landing_content.dart';
import '../../widgets/atoms/app_button.dart';
import '../../widgets/layout/anchored_section.dart';
import '../../widgets/molecules/section_header.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// An editorial overview and compact capability matrix avoid a long repeated list.
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = ScreenSizeX.of(context).isLaptopOrLarger;
    final gap = AppSpacing.lg.resolve(context);
    final introduction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowPill(labelKey: 'features.eyebrow'),
        SizedBox(height: AppSpacing.md.resolve(context)),
        CustomText(
          'features.title'.tr,
          role: TextRole.displayLG,
          color: LandingColors.textPrimary,
        ),
        SizedBox(height: AppSpacing.md.resolve(context)),
        CustomText(
          'features.subtitle'.tr,
          role: TextRole.bodyLG,
          color: LandingColors.textSecondary,
        ),
        SizedBox(height: AppSpacing.md.resolve(context)),
        AppButton(
          label: 'hero.cta.primary'.tr,
          onPressed: MedDeskActions.openRegistration,
          trailingIcon: const Icon(Icons.arrow_forward_rounded),
        ),
      ],
    );
    return AnchoredSection(
      sectionId: 'features',
      background: LandingColors.surfaceMuted,
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: introduction),
                SizedBox(width: gap),
                const Expanded(flex: 7, child: _CapabilityGrid()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                introduction,
                SizedBox(height: gap),
                const _CapabilityGrid(),
              ],
            ),
    );
  }
}

class _CapabilityGrid extends StatelessWidget {
  const _CapabilityGrid();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final gap = AppSpacing.sm.resolve(context);
      final columns = ScreenSizeX.of(context).isMobile ? 1 : 2;
      final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final feature in LandingContent.features)
            SizedBox(
              width: width,
              child: Container(
                padding: EdgeInsets.all(AppSpacing.sm.resolve(context)),
                decoration: BoxDecoration(
                  color: LandingColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.sm.resolve(context),
                  ),
                  border: Border.all(color: LandingColors.borderSubtle),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(feature.icon, color: LandingColors.accentGradientEnd),
                    SizedBox(width: AppSpacing.sm.resolve(context)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            feature.titleKey.tr,
                            role: TextRole.bodySM,
                            fontWeight: FW.semiBold,
                            color: LandingColors.textPrimary,
                          ),
                          SizedBox(height: AppSpacing.xxs.resolve(context)),
                          CustomText(
                            feature.descKey.tr,
                            role: TextRole.caption,
                            color: LandingColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}
