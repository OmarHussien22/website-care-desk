import 'dart:ui';

import 'package:flutter/src/gestures/tap.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/constants/snack_constants.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/object/snack_object.dart';

import '../../../../../../../packages_index.dart';
import '../../interface/snack_interface.dart';

class ToastImp extends SnackInterface {
  @override
  void showSnack({
    String? title,
    String? message,
    Widget? content,
    SnackPosition? snackPosition,
    SnackObject? snackObject,
    Color? backGroundColor,
    UtilState state = UtilState.none,
  }) {
    // TODO: implement showDefaultSnack
  }

  @override
  void showActionSnack({
    String? title,
    String? body,
    Widget? content,
    SnackObject? snackObject,
    UtilState? state,
    required GestureTapCallback onMainPressed,
    String? actionText,
    Color? actionTextColor,
    Color? actionDisabledTextColor,
    Color? backGroundColor,
  }) {
    // TODO: implement showActionSnack
  }
}
