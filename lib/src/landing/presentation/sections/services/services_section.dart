import '../../../core/breakpoints/screen_size.dart';
import '../../../core/scrolling/landing_scroll_controller.dart';
import '../../../core/theme/landing_colors.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../widgets/molecules/section_header.dart';
import '../../../data/landing_metrics.dart';
import 'widgets/service_card.dart';
import '../../widgets/layout/section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Services grid — six offering cards.
/// Self-registers anchor id `services` with [LandingScrollController].
class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  static const String _sectionId = 'services';
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
    if (Get.isRegistered<LandingScrollController>()) {
      Get.find<LandingScrollController>().unregisterSection(_sectionId);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: _key,
      background: LandingColors.surfaceElevated,
      child: Column(
        children: [
          const SectionHeader(
            eyebrowKey: 'services.eyebrow',
            titleKey: 'services.title',
            subtitleKey: 'services.subtitle',
          ),
          SizedBox(height: AppSpacing.lg.resolve(context)),
          _ServicesGrid(size: ScreenSizeX.of(context)),
        ],
      ),
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  const _ServicesGrid({required this.size});
  final ScreenSize size;

  int _columnsFor(ScreenSize size) {
    if (size.isLaptopOrLarger) return 3;
    if (size == ScreenSize.tablet) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final services = LandingMetrics.services;
    final columns = _columnsFor(size);
    const gap = 24.0;

    if (columns == 1) {
      return Column(
        children: [
          for (int i = 0; i < services.length; i++) ...[
            if (i > 0) const SizedBox(height: gap),
            ServiceCard(item: services[i], featured: i == 0, index: i),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (int index = 0; index < services.length; index++)
              SizedBox(
                width: itemWidth,
                child: ServiceCard(
                  item: services[index],
                  featured: index == 0,
                  index: index,
                ),
              ),
          ],
        );
      },
    );
  }
}
