import 'package:coursaty/src/core/styles/colors/interface/color_interface.dart';
import 'package:coursaty/src/core/styles/colors/parts/imports_colors.dart';

class AppColors {
  AppColors._();
  static ColorInterface get = LightColor();
  static void changeColor({required bool isDark, required Function update}) {
    get = isDark ? DarkColor() : LightColor();
    update();
  }
}
