import 'package:coursaty/src/landing/core/animations/fade_in_on_scroll.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/sliver_section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LandingScrollController>();

    return Scaffold(
      backgroundColor: LandingColors.surfaceElevated,
      body: CustomScrollView(
        controller: ctrl.scrollController,
        slivers: [
          SliverSectionWrapper(
            background: LandingColors.surfaceElevated,
            animationWrapper: (child) => FadeInOnScroll(child: child),
            child: _PlaceholderSection(sectionId: 'placeholder'),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderSection extends StatefulWidget {
  const _PlaceholderSection({required this.sectionId});

  final String sectionId;

  @override
  State<_PlaceholderSection> createState() => _PlaceholderSectionState();
}

class _PlaceholderSectionState extends State<_PlaceholderSection> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<LandingScrollController>().registerSection(widget.sectionId, _key);
      }
    });
  }

  @override
  void dispose() {
    Get.find<LandingScrollController>().unregisterSection(widget.sectionId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.construction, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Phase 1 — Foundation Scaffold',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text('Sections will be added here in Phase 2+.'),
          ],
        ),
      ),
    );
  }
}
