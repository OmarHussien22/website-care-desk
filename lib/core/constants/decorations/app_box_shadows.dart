import '../../services/utils/extensions/color_extension.dart';

import 'package:flutter/material.dart';

import '../../styles/colors/app_colors.dart';

class AppBoxShadows {
  AppBoxShadows._();

  /// shadows on buttons as []
  static List<BoxShadow>? buttonShadow({bool isDark = false}) => [
        BoxShadow(
          color: AppColors.get.primary.toOpacityColor(0.3),
          spreadRadius: 0.1,
          blurRadius: 8,
        ),
      ];

  static Widget circleShadow({
    required Widget child,
    bool isDark = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
              spreadRadius: 0.1,
              blurRadius: 8,
              color: Colors.orange.toOpacityColor(0.3))
        ],
      ),
      // shape: BoxShape.circle,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }
}
