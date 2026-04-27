import 'package:coursaty/src/core/utils/snack_utils/src/constants/snack_constants.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/object/snack_object.dart';
import 'package:flutter/material.dart';

import '../../../../../../packages_index.dart';

abstract class SnackInterface {
  void showSnack({
    String? title,
    String? message,
    Widget? content,
    SnackObject? snackObject,
    UtilState state,
    SnackPosition? snackPosition,

    Color? backGroundColor,
  });

  void showActionSnack({
    String? title,
    String? body,
    Widget? content,
    SnackObject? snackObject,
    UtilState state,
    required GestureTapCallback onMainPressed,
    String actionText,
    Color? actionTextColor,
    Color? actionDisabledTextColor,
    Color? backGroundColor,
  });
}
