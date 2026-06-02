import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/presentation/sections/footer/widgets/footer_bottom_strip.dart';
import 'package:coursaty/src/landing/presentation/sections/footer/widgets/footer_brand.dart';
import 'package:coursaty/src/landing/presentation/sections/footer/widgets/footer_columns.dart';
import 'package:coursaty/src/landing/presentation/sections/footer/widgets/footer_social_row.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The landing page footer section.
/// 4-column at laptop+, brand-full-width then 2×2 at tablet, stacked at mobile.
class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<LandingScrollController>().registerSection('footer', _key);
      }
    });
  }

  @override
  void dispose() {
    Get.find<LandingScrollController>().unregisterSection('footer');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isDesktop = size.isLaptopOrLarger;

    return Column(
      children: [
        SectionWrapper(
          sectionKey: _key,
          background: LandingColors.surfaceMuted,
          verticalPaddingOverride: const Responsive(
            mobile: 64.0,
            tablet: 80.0,
            laptop: 100.0,
          ),
          child: isDesktop
              ? _DesktopFooterBody()
              : _MobileTabletFooterBody(size: size),
        ),
        ColoredBox(
          color: LandingColors.surfaceMuted,
          child: const FooterBottomStrip(),
        ),
      ],
    );
  }
}

class _DesktopFooterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FooterBrand(),
              const SizedBox(height: 20),
              const FooterSocialRow(),
            ],
          ),
        ),
        const SizedBox(width: 64),
        const Expanded(child: FooterColumns()),
      ],
    );
  }
}

class _MobileTabletFooterBody extends StatelessWidget {
  const _MobileTabletFooterBody({required this.size});
  final ScreenSize size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FooterBrand(),
        const SizedBox(height: 20),
        const FooterSocialRow(),
        const SizedBox(height: 48),
        const FooterColumns(),
      ],
    );
  }
}
