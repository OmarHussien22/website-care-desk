import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reusable section shell that owns scroll-anchor registration.
class AnchoredSection extends StatefulWidget {
  const AnchoredSection({
    super.key,
    required this.sectionId,
    required this.child,
    this.background,
    this.decoration,
    this.verticalPadding,
  });

  final String sectionId;
  final Widget child;
  final Color? background;
  final BoxDecoration? decoration;
  final Responsive<double>? verticalPadding;

  @override
  State<AnchoredSection> createState() => _AnchoredSectionState();
}

class _AnchoredSectionState extends State<AnchoredSection> {
  final GlobalKey _anchor = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && Get.isRegistered<LandingScrollController>()) {
        Get.find<LandingScrollController>().registerSection(
          widget.sectionId,
          _anchor,
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant AnchoredSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sectionId != widget.sectionId &&
        Get.isRegistered<LandingScrollController>()) {
      final controller = Get.find<LandingScrollController>();
      controller.unregisterSection(oldWidget.sectionId);
      controller.registerSection(widget.sectionId, _anchor);
    }
  }

  @override
  void dispose() {
    if (Get.isRegistered<LandingScrollController>()) {
      Get.find<LandingScrollController>().unregisterSection(widget.sectionId);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SectionWrapper(
    sectionKey: _anchor,
    background: widget.background,
    decoration: widget.decoration,
    verticalPaddingOverride: widget.verticalPadding,
    child: widget.child,
  );
}
