import 'package:flutter/widgets.dart';

import 'screen_size.dart';

/// A responsive value holder. Unset tiers fall back to the next-smaller defined tier.
///
/// Usage:
/// ```dart
/// const gap = Responsive<double>(mobile: 16, tablet: 20, laptop: 24);
/// final value = gap.resolve(context); // returns 24 on laptop, 20 on tablet, 16 on mobile
/// ```
class Responsive<T> {
  const Responsive({
    required this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.ultraWide,
  });

  final T mobile;
  final T? tablet;
  final T? laptop;
  final T? desktop;
  final T? ultraWide;

  T resolve(BuildContext context) {
    final size = ScreenSizeX.of(context);
    return resolveForSize(size);
  }

  T resolveForSize(ScreenSize size) {
    switch (size) {
      case ScreenSize.ultraWide:
        return ultraWide ?? desktop ?? laptop ?? tablet ?? mobile;
      case ScreenSize.desktop:
        return desktop ?? laptop ?? tablet ?? mobile;
      case ScreenSize.laptop:
        return laptop ?? tablet ?? mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.mobile:
        return mobile;
    }
  }
}

/// Builds different children per breakpoint.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.ultraWide,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? laptop;
  final Widget? desktop;
  final Widget? ultraWide;

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    switch (size) {
      case ScreenSize.ultraWide:
        return ultraWide ?? desktop ?? laptop ?? tablet ?? mobile;
      case ScreenSize.desktop:
        return desktop ?? laptop ?? tablet ?? mobile;
      case ScreenSize.laptop:
        return laptop ?? tablet ?? mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.mobile:
        return mobile;
    }
  }
}
