import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'constants/snack_constants.dart';

class AppSnacks {
  AppSnacks._();

  factory AppSnacks() => _instance;

  static final AppSnacks _instance = AppSnacks._();

  void showSnack({
    String? title,
    String? body,
    Widget? content,
    Object? snackObject,
    UtilState state = UtilState.none,
  }) {
    final snackTitle = title ?? '';
    final snackBody = body ?? '';

    if (snackTitle.isEmpty && snackBody.isEmpty && content == null) {
      return;
    }

    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      snackTitle,
      snackBody,
      snackPosition: SnackPosition.TOP,
      backgroundColor: SnackConstants.backgroundColor(state),
      colorText: Colors.white,
      duration: SnackConstants.snackBarDuration,
      margin: const EdgeInsets.all(12),
      messageText: content,
    );
  }

  void showActionSnack({
    String? title,
    String? body,
    Widget? content,
    Object? snackObject,
    UtilState state = UtilState.none,
    required GestureTapCallback onMainPressed,
    String actionText = SnackConstants.mainActionText,
    Color actionTextColor = SnackConstants.actionTextColor,
    Color actionBackgroundColor = SnackConstants.actionDisabledTextColor,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      title ?? '',
      body ?? '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: SnackConstants.backgroundColor(state),
      colorText: Colors.white,
      duration: SnackConstants.snackBarDuration,
      margin: const EdgeInsets.all(12),
      messageText: content,
      mainButton: TextButton(
        onPressed: onMainPressed,
        style: TextButton.styleFrom(backgroundColor: actionBackgroundColor),
        child: Text(
          actionText,
          style: TextStyle(color: actionTextColor),
        ),
      ),
    );
  }

  void showTopToast({
    required String message,
    Toast? toastLength,
    ToastGravity? gravity,
    UtilState? state,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: SnackConstants.backgroundColor(state ?? UtilState.none),
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
