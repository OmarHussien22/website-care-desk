import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/extensions/color_extension.dart';

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

  static Widget circleShadow({required Widget child, bool isDark = false}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.1,
            blurRadius: 8,
            color: Colors.orange.toOpacityColor(0.3),
          ),
        ],
      ),
      // shape: BoxShape.circle,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }

  /// custom shadow for the card
  static List<BoxShadow>? get defaultShadows => [
    BoxShadow(
      color: AppColors.get.grey.withValues(alpha: 0.2),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ];
  static List<BoxShadow>? get topShadows => [
    BoxShadow(
      color: AppColors.get.grey.toOpacityColor(0.2),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(0, -3),
    ),
  ];
}
