import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutSwitcher extends StatelessWidget {
  final Widget mobileDesign;
  final Widget? tabletDesign;

  const LayoutSwitcher({
    super.key,
    required this.mobileDesign,
    this.tabletDesign,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isTablet && tabletDesign != null) {
      return tabletDesign!;
    }
    return mobileDesign;
  }
}
