import 'package:flutter/material.dart';

enum UtilState {
  success,
  warning,
  error,
  none,
}

class SnackConstants {
  SnackConstants._();

  static const Duration snackBarDuration = Duration(seconds: 3);
  static const String mainActionText = 'OK';
  static const Color actionDisabledTextColor = Colors.grey;
  static const Color actionTextColor = Colors.white;

  static Color backgroundColor(UtilState state) {
    switch (state) {
      case UtilState.success:
        return Colors.green;
      case UtilState.warning:
        return Colors.orange;
      case UtilState.error:
        return Colors.red;
      case UtilState.none:
        return Colors.blue;
    }
  }
}
