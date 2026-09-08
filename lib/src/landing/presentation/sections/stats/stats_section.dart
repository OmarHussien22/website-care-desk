import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_metrics.dart';
import 'package:coursaty/src/landing/presentation/sections/stats/widgets/stat_card.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Statistics band — four animated metrics directly below the Hero.
/// Self-registers anchor id `stats` with [LandingScrollController].
class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  static const String _sectionId = 'stats';
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

    return SectionWrapper(
      sectionKey: _key,
      background: LandingColors.surfaceMuted,
      child: Column(
        children: [
          CustomText(
            'stats.eyebrow'.tr,
            scaleFont: false,
            fontSize: 13,
            fontWeight: FW.semiBold,
            fontFamily: 'Montserrat',
            color: LandingColors.accent,
            letterSpacing: 0.6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _StatsGrid(size: size),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.size});
  final ScreenSize size;

  @override
  Widget build(BuildContext context) {
    final stats = LandingMetrics.stats;

    // Laptop+ → single row of 4.
    if (size.isLaptopOrLarger) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in stats) Expanded(child: StatCard(item: item)),
        ],
      );
    }

    // Tablet / mobile → 2 columns via computed widths (no overflow at 360px).
    final numberFontSize = size.isMobile ? 30.0 : 36.0;
    const columnSpacing = 16.0;
    const runSpacing = 40.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - columnSpacing) / 2;
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: columnSpacing,
          runSpacing: runSpacing,
          children: [
            for (final item in stats)
              SizedBox(
                width: itemWidth,
                child: StatCard(item: item, numberFontSize: numberFontSize),
              ),
          ],
        );
      },
    );
  }
}
