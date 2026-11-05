import '../../../../core/routers/app_routes.dart';
import '../../../core/breakpoints/screen_size.dart';
import '../../../core/navigation/meddesk_actions.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/landing_colors.dart';
import '../../controllers/nav_bar_controller.dart';
import '../atoms/app_button.dart';
import '../atoms/brand_logo.dart';
import '../layout/max_content_width.dart';
import 'language_toggle.dart';
import 'nav_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _navLinks = [
  (labelKey: 'nav.product', sectionId: 'product'),
  (labelKey: 'nav.services', sectionId: 'services'),
  (labelKey: 'nav.how_it_works', sectionId: 'how-it-works'),
  (labelKey: 'nav.pricing', sectionId: 'pricing'),
];

/// Floating solid navigation stays legible without expensive backdrop filters.
class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<NavBarController>();
    final size = ScreenSizeX.of(context);
    final desktop = size == ScreenSize.desktop || size == ScreenSize.ultraWide;
    final gap = AppSpacing.sm.resolve(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.page.resolve(context),
        vertical: gap,
      ),
      child: MaxContentWidth(
        child: Obx(
          () => AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(
              horizontal: gap,
              vertical: AppSpacing.xs.resolve(context),
            ),
            decoration: BoxDecoration(
              color: LandingColors.surfaceElevated,
              borderRadius: BorderRadius.circular(
                AppSpacing.md.resolve(context),
              ),
              border: Border.all(color: LandingColors.borderSubtle),
              boxShadow: [
                BoxShadow(
                  color: LandingColors.accent.withValues(
                    alpha: ctrl.scrolledPastThreshold.value ? 0.10 : 0.03,
                  ),
                  blurRadius: AppSpacing.md.resolve(context),
                  offset: Offset(0, AppSpacing.xs.resolve(context)),
                ),
              ],
            ),
            child: Row(
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () => ctrl.navigateTo('hero'),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: BrandLogo(
                        height:
                            AppSpacing.md.resolve(context) +
                            AppSpacing.xs.resolve(context),
                      ),
                    ),
                  ),
                ),
                if (desktop) ...[
                  Expanded(
                    child: Center(
                      child: Wrap(
                        children: [
                          for (final link in _navLinks)
                            NavLink(
                              labelKey: link.labelKey,
                              sectionId: link.sectionId,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const LanguageToggle(onSurface: true),
                  AppButton(
                    label: 'nav.login'.tr,
                    onPressed: MedDeskActions.openClinicLogin,
                    variant: AppButtonVariant.ghost,
                  ),
                  AppButton(
                    label: 'nav.cta.demo'.tr,
                    onPressed: MedDeskActions.openRegistration,
                  ),
                ] else ...[
                  const Spacer(),
                  const LanguageToggle(onSurface: true),
                  IconButton(
                    tooltip: 'nav.menu.open'.tr,
                    onPressed: () async {
                      ctrl.openDrawer();
                      await Get.toNamed<void>(AppRoutes.landingMenu);
                      ctrl.closeDrawer();
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      color: LandingColors.textPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
