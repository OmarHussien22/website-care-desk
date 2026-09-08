import 'package:coursaty/src/features/clinic_onboarding/presentation/controllers/clinic_registration_controller.dart';
import 'package:coursaty/src/features/clinic_onboarding/presentation/widgets/registration_form.dart';
import 'package:coursaty/src/landing/core/navigation/meddesk_actions.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/presentation/widgets/atoms/brand_logo.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/language_toggle.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicRegistrationPage extends GetView<ClinicRegistrationController> {
  const ClinicRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<ClinicRegistrationController>(
        init: ClinicRegistrationController(),
        builder: (_) => Scaffold(
          backgroundColor: LandingColors.surfaceMuted,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _RegistrationHeader()),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    20.0,
                    36.0,
                    20.0,
                    64.0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 780.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13.0,
                                vertical: 7.0,
                              ),
                              decoration: BoxDecoration(
                                color: LandingColors.accent.withValues(
                                  alpha: 0.08,
                                ),
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                              child: CustomText(
                                'register.eyebrow'.tr,
                                scaleFont: false,
                                fontSize: 12.0,
                                fontWeight: FW.bold,
                                color: LandingColors.accent,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 18.0),
                            CustomText(
                              'register.title'.tr,
                              role: TextRole.displayLG,
                              fontWeight: FW.bold,
                              color: LandingColors.textPrimary,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12.0),
                            CustomText(
                              'register.subtitle'.tr,
                              role: TextRole.bodyLG,
                              color: LandingColors.textSecondary,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 34.0),
                            Container(
                              padding: const EdgeInsets.all(26.0),
                              decoration: BoxDecoration(
                                color: LandingColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(22.0),
                                border: Border.all(
                                  color: LandingColors.borderSubtle,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: LandingColors.accent.withValues(
                                      alpha: 0.08,
                                    ),
                                    blurRadius: 36.0,
                                    offset: const Offset(0, 18.0),
                                  ),
                                ],
                              ),
                              child: const RegistrationForm(),
                            ),
                            const SizedBox(height: 18.0),
                            TextButton(
                              onPressed: MedDeskActions.openClinicLogin,
                              child: CustomText(
                                'register.login'.tr,
                                role: TextRole.bodyMD,
                                color: LandingColors.accent,
                                fontWeight: FW.semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _RegistrationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    height: 68.0,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
      color: LandingColors.surfaceElevated,
      border: Border(bottom: BorderSide(color: LandingColors.borderSubtle)),
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Get.back<void>(),
              tooltip: 'back'.tr,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: LandingColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8.0),
            const BrandLogo(height: 34.0),
            const Spacer(),
            const LanguageToggle(onSurface: true),
          ],
        ),
      ),
    ),
  );
}
