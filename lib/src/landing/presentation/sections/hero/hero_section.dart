import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/spacing/app_spacing.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/widgets/hero_background.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/widgets/hero_content.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/widgets/hero_visual.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The landing page hero section.
/// Two-column at laptop+, single-column (visual on top) at mobile.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<LandingScrollController>().registerSection('hero', _key);
      }
    });
  }

  @override
  void dispose() {
    Get.find<LandingScrollController>().unregisterSection('hero');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isMobile = size == ScreenSize.mobile;

    return HeroBackground(
      child: SectionWrapper(
        sectionKey: _key,
        // 64 = NavBar height clearance; vertical padding is breathing room below NavBar.
        topPaddingExtra: 64.0,
        verticalPaddingOverride: const Responsive(
          mobile: 48.0,
          tablet: 64.0,
          laptop: 88.0,
          desktop: 104.0,
          ultraWide: 120.0,
        ),
        child: isMobile ? _MobileLayout() : _DesktopLayout(size: size),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.size});
  final ScreenSize size;

  @override
  Widget build(BuildContext context) {
    final leftFlex = size == ScreenSize.tablet ? 1 : 55;
    final rightFlex = size == ScreenSize.tablet ? 1 : 45;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: leftFlex, child: const HeroContent()),
        SizedBox(width: AppSpacing.lg.resolveForSize(size)),
        Expanded(flex: rightFlex, child: const HeroVisual()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeroVisual(),
        SizedBox(height: 32),
        HeroContent(),
      ],
    );
  }
}
