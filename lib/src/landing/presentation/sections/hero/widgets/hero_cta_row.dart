import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/// Primary + secondary CTA row in the hero section.
/// Stacks vertically on mobile, horizontal on tablet+.
class HeroCtaRow extends StatelessWidget {
  const HeroCtaRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isDesktop = size.isLaptopOrLarger;

    final primary = _PrimaryCta();
    final secondary = _SecondaryCta();

    if (isDesktop || size == ScreenSize.tablet) {
      // Wrap (not Row) so the buttons drop to a second line when the column is
      // too narrow — at tablet the hero is two-column, leaving the CTA only
      // ~half the viewport width, which a fixed Row would overflow.
      return Wrap(
        spacing: 14,
        runSpacing: 12,
        children: [primary, secondary],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [primary, const SizedBox(height: 12), secondary],
    );
  }
}

class _PrimaryCta extends StatefulWidget {
  @override
  State<_PrimaryCta> createState() => _PrimaryCtaState();
}

class _PrimaryCtaState extends State<_PrimaryCta> {
  bool _hovered = false;

  Future<void> _onPressed() async {
    final uri = Uri.parse(LandingBrand.demoUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hovered ? 0.20 : 0.12),
              blurRadius: _hovered ? 24 : 14,
              offset: Offset(0, _hovered ? 10 : 6),
            ),
            BoxShadow(
              color: LandingColors.accentGradientEnd
                  .withValues(alpha: _hovered ? 0.40 : 0.25),
              blurRadius: _hovered ? 22 : 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: LandingColors.accent,
            minimumSize: const Size(0, 54),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                'hero.cta.primary'.tr,
                scaleFont: false,
                fontSize: 16,
                fontWeight: FW.semiBold,
                fontFamily: 'Montserrat',
                color: LandingColors.accent,
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: LandingColors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryCta extends StatefulWidget {
  @override
  State<_SecondaryCta> createState() => _SecondaryCtaState();
}

class _SecondaryCtaState extends State<_SecondaryCta> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: _hovered ? Colors.white.withValues(alpha: 0.12) : null,
        ),
        child: OutlinedButton(
          onPressed: () =>
              Get.find<LandingScrollController>().scrollTo('how-it-works'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.65),
              width: 1.5,
            ),
            minimumSize: const Size(0, 54),
            padding: const EdgeInsets.symmetric(horizontal: 26),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_circle_outline_rounded,
                size: 19,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              CustomText(
                'hero.cta.secondary'.tr,
                scaleFont: false,
                fontSize: 16,
                fontWeight: FW.medium,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
