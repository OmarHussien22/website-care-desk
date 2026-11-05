import '../../../../core/routers/app_routes.dart';
import '../controllers/clinic_registration_controller.dart';
import '../widgets/registration_form.dart';
import '../../../../landing/core/breakpoints/screen_size.dart';
import '../../../../landing/core/navigation/meddesk_actions.dart';
import '../../../../landing/core/spacing/app_spacing.dart';
import '../../../../landing/core/theme/landing_colors.dart';
import '../../../../landing/core/typography/text_role.dart';
import '../../../../landing/presentation/sections/hero/widgets/hero_background.dart';
import '../../../../landing/presentation/widgets/atoms/brand_logo.dart';
import '../../../../landing/presentation/widgets/layout/section_wrapper.dart';
import '../../../../landing/presentation/widgets/molecules/section_header.dart';
import '../../../../landing/presentation/widgets/organisms/language_toggle.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicRegistrationPage extends GetView<ClinicRegistrationController> {
  const ClinicRegistrationPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => GetBuilder<ClinicRegistrationController>(
    init: ClinicRegistrationController(),
    builder: (_) {
      final wide = ScreenSizeX.of(context).isLaptopOrLarger;
      final gap = AppSpacing.lg.resolve(context);
      final form = Container(
        padding: EdgeInsets.all(AppSpacing.md.resolve(context)),
        decoration: BoxDecoration(
          color: LandingColors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppSpacing.md.resolve(context)),
          border: Border.all(color: LandingColors.borderSubtle),
          boxShadow: [
            BoxShadow(
              color: LandingColors.accent.withValues(alpha: 0.06),
              blurRadius: gap,
              offset: Offset(0, AppSpacing.sm.resolve(context)),
            ),
          ],
        ),
        child: const RegistrationForm(),
      );
      return Scaffold(
        backgroundColor: LandingColors.surfaceMuted,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _RegistrationHeader()),
              SliverToBoxAdapter(
                child: HeroBackground(
                  child: SectionWrapper(
                    child: wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(flex: 4, child: _Introduction()),
                              SizedBox(width: gap),
                              Expanded(flex: 6, child: form),
                            ],
                          )
                        : Column(
                            children: [
                              const _Introduction(),
                              SizedBox(height: gap),
                              form,
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _Introduction extends StatelessWidget {
  const _Introduction();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const EyebrowPill(labelKey: 'register.eyebrow'),
      SizedBox(height: AppSpacing.md.resolve(context)),
      CustomText(
        'register.title'.tr,
        role: TextRole.displayLG,
        color: LandingColors.textPrimary,
      ),
      SizedBox(height: AppSpacing.md.resolve(context)),
      CustomText(
        'register.subtitle'.tr,
        role: TextRole.bodyLG,
        color: LandingColors.textSecondary,
      ),
      SizedBox(height: AppSpacing.lg.resolve(context)),
      for (final step in [
        (icon: Icons.domain_add_outlined, label: 'how.register.title'),
        (icon: Icons.tune_rounded, label: 'how.center.title'),
        (icon: Icons.event_available_outlined, label: 'how.appointments.title'),
      ])
        Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.md.resolve(context)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm.resolve(context)),
                decoration: BoxDecoration(
                  color: LandingColors.heroHighlight.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(
                    AppSpacing.sm.resolve(context),
                  ),
                ),
                child: Icon(step.icon, color: LandingColors.accent),
              ),
              SizedBox(width: AppSpacing.sm.resolve(context)),
              Expanded(
                child: CustomText(
                  step.label.tr,
                  role: TextRole.bodyMD,
                  color: LandingColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      TextButton(
        onPressed: MedDeskActions.openClinicLogin,
        child: CustomText(
          'register.login'.tr,
          role: TextRole.bodySM,
          color: LandingColors.accent,
        ),
      ),
    ],
  );
}

class _RegistrationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.page.resolve(context),
      vertical: AppSpacing.sm.resolve(context),
    ),
    decoration: BoxDecoration(
      color: LandingColors.surfaceElevated,
      border: Border(bottom: BorderSide(color: LandingColors.borderSubtle)),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.landing),
          tooltip: 'nav.home'.tr,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: LandingColors.textPrimary,
          ),
        ),
        SizedBox(width: AppSpacing.xs.resolve(context)),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: BrandLogo(
              height:
                  AppSpacing.md.resolve(context) +
                  AppSpacing.xs.resolve(context),
            ),
          ),
        ),
        const LanguageToggle(onSurface: true),
      ],
    ),
  );
}
