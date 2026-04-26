import 'package:flutter/material.dart';

import 'interface/color_interface.dart';
import 'parts/imports_colors.dart';

class AppColors {
  AppColors._();
  static ColorInterface get = LightColor();
  static void changeColor({required bool isDark, required Function update}) {
    get = isDark ? DarkColor() : LightColor();
    update();
  }
}

class MainColors {
  MainColors._();
  static final get = MainColors._();

  Color main = AppColors.get.primary;
  Color secondary = AppColors.get.secondary;

  void setMainColor(Color color) {
    main = color;
  }

  void setSecondaryColor(Color color) {
    secondary = color;
  }
}
