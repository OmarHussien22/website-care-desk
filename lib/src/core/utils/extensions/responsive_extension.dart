import 'package:coursaty/app_imports.dart';
import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Maximum content width that prevents stretching on wide screens.
  /// Returns [double.infinity] on phones so nothing changes for phone layout.
  double get contentMaxWidth =>
      isLargeTablet ? 800.0 : (isSmallTablet ? 650.0 : double.infinity);

  /// Returns the appropriate value for the current breakpoint.
  /// Falls back: largeTablet → tablet → mobile.
  T adaptiveValue<T>({required T mobile, T? tablet, T? largeTablet}) {
    if (isLargeTablet) return largeTablet ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}
