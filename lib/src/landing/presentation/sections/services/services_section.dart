import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/data/landing_metrics.dart';
import 'package:coursaty/src/landing/presentation/sections/services/widgets/service_card.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
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
    Get.find<LandingScrollController>().unregisterSection(_sectionId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: _key,
      background: LandingColors.surfaceElevated,
      child: Column(
        children: [
          const _ServicesHeader(),
          const SizedBox(height: 48),
          _ServicesGrid(size: ScreenSizeX.of(context)),
        ],
      ),
    );
  }
}

class _ServicesHeader extends StatelessWidget {
  const _ServicesHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          'services.eyebrow'.tr,
          scaleFont: false,
          fontSize: 13,
          fontWeight: FW.semiBold,
          fontFamily: 'Montserrat',
          color: LandingColors.accent,
          letterSpacing: 0.6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        CustomText(
          'services.title'.tr,
          role: TextRole.displayLG,
          fontWeight: FW.bold,
          fontFamily: 'Montserrat',
          color: LandingColors.textPrimary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: CustomText(
            'services.subtitle'.tr,
            role: TextRole.bodyLG,
            color: LandingColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ),
      ],
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
            ServiceCard(item: services[i]),
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
            for (final item in services)
              SizedBox(
                width: itemWidth,
                child: ServiceCard(item: item),
              ),
          ],
        );
      },
    );
  }
}
