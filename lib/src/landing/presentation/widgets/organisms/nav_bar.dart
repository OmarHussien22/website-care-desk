import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:coursaty/src/landing/presentation/controllers/nav_bar_controller.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/language_toggle.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/nav_bar_drawer.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/nav_link.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

const double _navBarHeight = 64.0;

const List<({String labelKey, String sectionId})> _navLinks = [
  (labelKey: 'nav.services', sectionId: 'services'),
  (labelKey: 'nav.features', sectionId: 'features'),
  (labelKey: 'nav.how_it_works', sectionId: 'how-it-works'),
  (labelKey: 'nav.for_clinicians', sectionId: 'for-clinicians'),
  (labelKey: 'nav.pricing', sectionId: 'pricing'),
  (labelKey: 'nav.faq', sectionId: 'faq'),
];

/// Sticky responsive NavBar: transparent over the hero, solid after 24px scroll.
class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<NavBarController>();
    final size = ScreenSizeX.of(context);
    final isDesktop = size.isLaptopOrLarger;

    return Obx(() {
      final scrolled = ctrl.scrolledPastThreshold.value;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        height: _navBarHeight,
        decoration: BoxDecoration(
          color: scrolled ? LandingColors.surfaceElevated : Colors.transparent,
          border: scrolled
              ? Border(
                  bottom: BorderSide(
                    color: LandingColors.borderSubtle,
                    width: 1,
                  ),
                )
              : null,
          boxShadow: scrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.isLaptopOrLarger ? 48 : 20,
          ),
          child: isDesktop
              ? _DesktopBar(scrolled: scrolled, ctrl: ctrl)
              : _MobileBar(scrolled: scrolled, ctrl: ctrl),
        ),
      );
    });
  }
}

// ── Desktop ─────────────────────────────────────────────────────────────────

class _DesktopBar extends StatelessWidget {
  const _DesktopBar({required this.scrolled, required this.ctrl});
  final bool scrolled;
  final NavBarController ctrl;

  @override
  Widget build(BuildContext context) {
    final linkColor = scrolled ? null : Colors.white;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo — inverse (white) on transparent, regular (dark) on solid
        _Logo(scrolled: scrolled),

        // Nav links — centered in remaining space between logo and CTA
        Expanded(
          child: Center(
            child: Wrap(
              spacing: 4,
              children: [
                for (final link in _navLinks)
                  NavLink(
                    labelKey: link.labelKey,
                    sectionId: link.sectionId,
                    textColor: linkColor,
                  ),
              ],
            ),
          ),
        ),

        // Language switcher
        LanguageToggle(onSurface: scrolled),
        const SizedBox(width: 8),

        // CTA button
        _CtaButton(scrolled: scrolled),
      ],
    );
  }
}

// ── Mobile / tablet ──────────────────────────────────────────────────────────

class _MobileBar extends StatelessWidget {
  const _MobileBar({required this.scrolled, required this.ctrl});
  final bool scrolled;
  final NavBarController ctrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _Logo(scrolled: scrolled),
        const Spacer(),
        LanguageToggle(onSurface: scrolled),
        const SizedBox(width: 4),
        Semantics(
          button: true,
          label: 'nav.menu.open'.tr,
          child: IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: scrolled ? LandingColors.textPrimary : Colors.white,
              size: 26,
            ),
            onPressed: () => _openDrawer(context),
          ),
        ),
      ],
    );
  }

  void _openDrawer(BuildContext context) {
    ctrl.openDrawer();
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 280),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (ctx, animation, _) => const NavBarDrawer(),
        transitionsBuilder: (ctx, animation, _, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  const _Logo({required this.scrolled});
  final bool scrolled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<NavBarController>().navigateTo('hero'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SvgPicture.asset(
          scrolled ? LandingBrand.logo : LandingBrand.logoInverse,
          height: 32,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  const _CtaButton({required this.scrolled});
  final bool scrolled;

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  Future<void> _onTap() async {
    final uri = Uri.parse(LandingBrand.demoUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _hovered ? LandingColors.accentHover : LandingColors.accent;

    return Semantics(
      button: true,
      label: 'nav.cta.demo'.tr,
      child: Focus(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: _onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0, _hovered ? -1 : 0, 0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: LandingColors.accent
                        .withValues(alpha: _hovered ? 0.35 : 0.20),
                    blurRadius: _hovered ? 16 : 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomText(
                  'nav.cta.demo'.tr,
                  scaleFont: false,
                  fontSize: 14,
                  fontWeight: FW.semiBold,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
