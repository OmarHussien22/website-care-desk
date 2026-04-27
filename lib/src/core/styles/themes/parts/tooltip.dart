// part of 'imports_parts.dart';

import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/color_extension.dart';

TooltipThemeData getTooltipTheme() => TooltipThemeData(
  decoration: BoxDecoration(
    color: AppColors.get.primary.toOpacityColor(0.4),
    borderRadius: BorderRadius.circular(10),
  ),
  enableFeedback: true,
  textStyle: TextStyle(color: AppColors.get.title),
);
