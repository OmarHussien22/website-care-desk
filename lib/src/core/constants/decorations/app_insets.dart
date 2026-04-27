import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/cupertino.dart';

class AppInsets {
  AppInsets._();

  static const double defaultScreenPadding = 16.0;
  static const double defaultCardPadding = 12.0;
  static const double defaultC = 16.0;

  /// Screen Padding
  static EdgeInsets defaultScreenALL = EdgeInsets.all(
    defaultScreenPadding.toRad(),
  );
  static EdgeInsets defaultScreenHorizontal = EdgeInsets.symmetric(
    horizontal: defaultScreenPadding.toW(),
  );
  static EdgeInsets defaultScreenVertical = EdgeInsets.symmetric(
    vertical: defaultScreenPadding.toH(),
  );

  /// Card Padding
  static EdgeInsets defaultCardALL = EdgeInsets.symmetric(
    horizontal: defaultCardPadding.toW(),
    vertical: defaultCardPadding.toH(),
  );
  static EdgeInsets defaultCardHorizontal = EdgeInsets.symmetric(
    horizontal: defaultCardPadding.toW(),
  );
  static EdgeInsets defaultCardVertical = EdgeInsets.symmetric(
    vertical: defaultCardPadding.toH(),
  );
}
