import 'package:flutter/material.dart';
extension ColorToStringExtension on Color {
  /// Convert a color to a hex string representation.
  /// Ex: Colors.red.toHex() => '#FF0000'
  String toHex() {
    return '#${value.toRadixString(16).substring(2)}';
  }
}
extension StringToColorExtension on String {
  /// Convert a hex string to a color.
  /// Ex: '#FF0000'.toColor() => Colors.red
  Color toCustomColor() {
    return Color(int.parse('0xff${substring(1)}'));
  }
}
extension ColorToOpacityColorExtension on Color {
  /// Add opacity to color
  Color toOpacityColor(double  opacity) {
return withValues(
      red: r.toDouble(),
      green: g.toDouble(),
      blue: b.toDouble(),
      alpha: opacity ,
    );
  }
}






