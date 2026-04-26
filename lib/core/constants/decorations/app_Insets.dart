import '../../services/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/cupertino.dart';

class AppInsets {
  AppInsets._();
  static const double _defaultScreenPadding = 16.0;
  static EdgeInsets defaultScreenALL =
      EdgeInsets.all(_defaultScreenPadding.toRad());
  static EdgeInsets defaultScreenHorizontal =
      EdgeInsets.symmetric(horizontal: _defaultScreenPadding.toW());
  static EdgeInsets defaultScreenVertical =
      EdgeInsets.symmetric(vertical: _defaultScreenPadding.toH());
}
