import 'package:coursaty/src/core/utils/snack_utils/src/constants/snack_constants.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/factory/snack_factory.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/interface/snack_interface.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/object/snack_object.dart';
import 'package:coursaty/src/core/utils/snack_utils/src/resources/snack/snackbar_imp.dart';
import 'package:flutter/material.dart';

import '../../../../../packages_index.dart';
import 'resources/snack/snack_getx_imp.dart';

// AppSnacks.showSnack(); // snap snack - - native snack
// AppSnacks.showActionSnack(); // snap snack - native snack

class AppSnacks {
  AppSnacks._();

  factory AppSnacks() => _instance;
  static final _instance = AppSnacks._();

  // final SnackInterface _snack = SnackBarImp();
  final SnackInterface _snack = SnackGetxImp();

  void showSnack({
    String? title,
    String? body,
    Widget? content,
    SnackObject? snackObject,
    SnackPosition? snackPosition,
    UtilState state = UtilState.none,
    Color? backGroundColor,
  }) {
    final object = snackObject ?? SnackObjectCreator().get(state).object;
    _snack.showSnack(
      title: title,
      content: content,
      message: body,
      snackObject: object,
      state: state,
      snackPosition: snackPosition,
      backGroundColor: backGroundColor,
    );
  }

  void showActionSnack({
    String? title,
    String? body,
    Widget? content,
    SnackObject? snackObject,
    UtilState state = UtilState.none,
    required GestureTapCallback onMainPressed,
    String actionText = SnackConstants.mainActionText,
    Color actionTextColor = SnackConstants.actionTextColor,
    Color actionBackgroundColor = SnackConstants.actionDisabledTextColor,
    Color? backGroundColor,
  }) {
    final object = snackObject ?? SnackObjectCreator().get(state).object;
    _snack.showActionSnack(
      onMainPressed: onMainPressed,
      title: title,
      body: body,
      content: content,
      snackObject: object,
      state: state,
      actionText: actionText,
      actionDisabledTextColor: actionBackgroundColor,
      actionTextColor: actionTextColor,
    );
  }
}
