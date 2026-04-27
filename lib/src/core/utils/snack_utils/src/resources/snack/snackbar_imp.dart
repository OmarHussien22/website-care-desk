import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../packages_index.dart';
import '../../constants/snack_constants.dart';
import '../../interface/snack_interface.dart';
import '../../object/snack_object.dart';
import 'snack_bar_behaviour.dart';

class SnackBarImp extends SnackInterface with SnackBarBehaviour {
  @override
  void showSnack({
    String? title,
    String? message,
    Widget? content,
    SnackObject? snackObject,
    UtilState? state,
    SnackPosition? snackPosition,
    Color? backGroundColor,
  }) {
    Get.snackbar(
      title!,
      message!,
      backgroundColor: snackObject?.color,
      duration: snackObject?.appearDuration,
    );
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
    Get.snackbar(
      title!,
      body!,
      backgroundColor: snackObject?.color,
      duration: snackObject?.appearDuration,
    );
  }
}
