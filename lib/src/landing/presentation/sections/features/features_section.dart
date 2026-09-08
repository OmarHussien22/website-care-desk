import 'package:coursaty/src/landing/core/animations/fade_in_on_scroll.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_content.dart';
import 'package:coursaty/src/landing/presentation/sections/features/widgets/feature_row.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/product_screenshot.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Features section — app preview beside a labelled feature list.
/// Two-column at laptop+, stacked (preview on top) at tablet/mobile.
/// Self-registers anchor id `features` with [LandingScrollController].
class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  static const String _sectionId = 'features';
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<LandingScrollController>().registerSection(_sectionId, _key);
      }
    });
  }

  @override
  void dispose() {
    Get.find<LandingScrollController>().unregisterSection(_sectionId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isWide = size.isLaptopOrLarger;

    return SectionWrapper(
      sectionKey: _key,
      background: LandingColors.surfaceElevated,
      child: Column(
        children: [
          const SectionHeader(
            eyebrowKey: 'features.eyebrow',
            titleKey: 'features.title',
            subtitleKey: 'features.subtitle',
          ),
          const SizedBox(height: 56),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                      flex: 5,
                      child: ProductScreenshot(
                        screen: ProductScreen.patients,
                        altTextKey: 'product.patients',
                      ),
                    ),
                    SizedBox(width: 56),
                    Expanded(flex: 6, child: _FeatureList()),
                  ],
                )
              : Column(
                  children: const [
                    ProductScreenshot(
                      screen: ProductScreen.patients,
                      altTextKey: 'product.patients',
                    ),
                    SizedBox(height: 40),
                    _FeatureList(),
                  ],
                ),
        ],
      ),
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  @override
  Widget build(BuildContext context) {
    final features = LandingContent.features;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < features.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          FadeInOnScroll(
            delay: Duration(milliseconds: 70 * i),
            slideOffset: 16,
            child: FeatureRow(item: features[i]),
          ),
        ],
      ],
    );
  }
}
