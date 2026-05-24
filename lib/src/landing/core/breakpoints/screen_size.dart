import 'package:flutter/widgets.dart';

enum ScreenSize { mobile, tablet, laptop, desktop, ultraWide }

extension ScreenSizeX on ScreenSize {
  static ScreenSize of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1920) return ScreenSize.ultraWide;
    if (width >= 1440) return ScreenSize.desktop;
    if (width >= 1024) return ScreenSize.laptop;
    if (width >= 600) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  bool get isMobile => this == ScreenSize.mobile;
  bool get isTablet => this == ScreenSize.tablet;
  bool get isLaptop => this == ScreenSize.laptop;
  bool get isDesktop => this == ScreenSize.desktop;
  bool get isUltraWide => this == ScreenSize.ultraWide;

  /// True for laptop, desktop, and ultraWide — where screenutil scaling is bypassed.
  bool get isLaptopOrLarger => index >= ScreenSize.laptop.index;
}

extension BuildContextScreenSize on BuildContext {
  ScreenSize get screenSize => ScreenSizeX.of(this);
}
