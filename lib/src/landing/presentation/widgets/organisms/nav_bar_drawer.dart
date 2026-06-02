import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:coursaty/src/landing/presentation/controllers/nav_bar_controller.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/language_toggle.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

const List<({String labelKey, String sectionId})> _drawerLinks = [
  (labelKey: 'nav.features', sectionId: 'features'),
  (labelKey: 'nav.how_it_works', sectionId: 'how-it-works'),
  (labelKey: 'nav.for_clinicians', sectionId: 'for-clinicians'),
  (labelKey: 'nav.pricing', sectionId: 'pricing'),
  (labelKey: 'nav.faq', sectionId: 'faq'),
];

/// Full-screen mobile drawer for the NavBar.
/// Closes on link tap, swipe-down gesture, or ✕ button.
class NavBarDrawer extends StatelessWidget {
  const NavBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<NavBarController>();

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 200) {
          _close(context, ctrl);
        }
      },
      child: Scaffold(
        backgroundColor: LandingColors.surfaceElevated,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(LandingBrand.logo, height: 32),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LanguageToggle(onSurface: true),
                        Semantics(
                          button: true,
                          label: 'nav.menu.close'.tr,
                          child: IconButton(
                            icon: Icon(Icons.close_rounded,
                                color: LandingColors.textPrimary),
                            onPressed: () => _close(context, ctrl),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // ── Links ────────────────────────────────────────────────────
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  children: [
                    for (final link in _drawerLinks)
                      _DrawerLink(
                        labelKey: link.labelKey,
                        sectionId: link.sectionId,
                        onTap: () => _close(context, ctrl,
                            navigateTo: link.sectionId),
                      ),
                  ],
                ),
              ),

              // ── CTA ──────────────────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LandingColors.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  child: CustomText(
                    'nav.cta.demo'.tr,
                    scaleFont: false,
                    fontSize: 16,
                    fontWeight: FW.semiBold,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _close(BuildContext context, NavBarController ctrl,
      {String? navigateTo}) {
    ctrl.closeDrawer();
    Navigator.of(context).pop();
    if (navigateTo != null) {
      ctrl.navigateTo(navigateTo);
    }
  }
}

class _DrawerLink extends StatelessWidget {
  const _DrawerLink({
    required this.labelKey,
    required this.sectionId,
    required this.onTap,
  });

  final String labelKey;
  final String sectionId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: CustomText(
          labelKey.tr,
          scaleFont: false,
          fontSize: 20,
          fontWeight: FW.semiBold,
          fontFamily: 'Montserrat',
          color: LandingColors.textPrimary,
        ),
      ),
    );
  }
}
