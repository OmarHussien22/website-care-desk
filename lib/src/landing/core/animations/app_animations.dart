import 'package:flutter/animation.dart';

/// Animation timing and curve tokens for the landing page.
abstract final class AppAnimations {
  // Durations
  static const fast = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 400);
  static const slow = Duration(milliseconds: 700);
  static const entrance = Duration(milliseconds: 900);

  // Curves
  static const standard = Curves.easeInOutCubic;
  static const entranceCurve = Curves.easeOutCubic;
  static const emphasized = Curves.easeOutBack;

  /// Stagger step between successive children in a list entrance.
  static const staggerStep = Duration(milliseconds: 80);
}
