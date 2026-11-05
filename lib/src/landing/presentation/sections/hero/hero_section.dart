import '../../../core/breakpoints/responsive.dart';
import '../../../core/animations/fade_in_on_scroll.dart';
import '../../../core/breakpoints/screen_size.dart';
import '../../../core/scrolling/landing_scroll_controller.dart';
import '../../../core/spacing/app_spacing.dart';
import 'widgets/hero_background.dart';
import 'widgets/hero_content.dart';
import 'widgets/hero_visual.dart';
import '../../widgets/layout/section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The landing page hero section.
/// Two columns on desktop; message and actions come first on smaller screens.
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
    if (Get.isRegistered<LandingScrollController>()) {
      Get.find<LandingScrollController>().unregisterSection('hero');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final useStackedLayout = !size.isLaptopOrLarger;

    return HeroBackground(
      child: SectionWrapper(
        sectionKey: _key,
        topPaddingExtra:
            AppSpacing.lg.resolve(context) + AppSpacing.md.resolve(context),
        verticalPaddingOverride: const Responsive(
          mobile: 48.0,
          tablet: 56.0,
          laptop: 64.0,
          desktop: 64.0,
          ultraWide: 80.0,
        ),
        child: useStackedLayout
            ? const _MobileLayout()
            : _DesktopLayout(size: size),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.size});
  final ScreenSize size;

  @override
  Widget build(BuildContext context) {
    const leftFlex = 46;
    const rightFlex = 54;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: leftFlex,
          child: FadeInOnScroll(child: const HeroContent()),
        ),
        SizedBox(width: AppSpacing.lg.resolveForSize(size)),
        Expanded(flex: rightFlex, child: const HeroVisual()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const HeroContent(),
        SizedBox(height: AppSpacing.xl.resolve(context)),
        const HeroVisual(),
      ],
    );
  }
}
