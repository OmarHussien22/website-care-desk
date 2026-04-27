part of 'imports_themes.dart';

// import 'package:coursaty/src/core/styles/colors/app_colors.dart';
// import 'package:flutter/material.dart';

final ThemeData _defaultTheme = ThemeData(
  /// call method later
  primaryColor: AppColors.get.primary,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: AppStrings.fontFamilyUrw,
  // backgroundColor: AppColors.get.background,
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.get.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  buttonBarTheme: const ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
    buttonTextTheme: ButtonTextTheme.primary,
  ),
  tooltipTheme: getTooltipTheme(),
  tabBarTheme: TabBarThemeData(
    indicator: BoxDecoration(
      color: Colors.transparent,
      border: Border(
        bottom: BorderSide(color: AppColors.get.primary, width: 2),
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
  textTheme: TextTheme(titleMedium: TextStyle(color: AppColors.get.title)),
);
