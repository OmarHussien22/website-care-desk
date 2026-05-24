import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Mixin for section widgets that need to register with [LandingScrollController].
///
/// Usage in a StatefulWidget:
/// ```dart
/// class _HeroSectionState extends State<HeroSection> with SectionAnchor {
///   @override
///   String get sectionId => 'hero';
///
///   @override
///   void initState() {
///     super.initState();
///     registerAnchor();
///   }
///
///   @override
///   void dispose() {
///     unregisterAnchor();
///     super.dispose();
///   }
/// }
/// ```
mixin SectionAnchor<T extends StatefulWidget> on State<T> {
  final GlobalKey anchorKey = GlobalKey();

  String get sectionId;

  void registerAnchor() {
    final ctrl = Get.find<LandingScrollController>();
    ctrl.registerSection(sectionId, anchorKey);
  }

  void unregisterAnchor() {
    final ctrl = Get.find<LandingScrollController>();
    ctrl.unregisterSection(sectionId);
  }
}
