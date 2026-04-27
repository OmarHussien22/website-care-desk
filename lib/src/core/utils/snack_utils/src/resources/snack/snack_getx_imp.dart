import 'package:flutter/material.dart';

import '../../../../../../../packages_index.dart';
import '../../constants/snack_constants.dart';
import '../../interface/snack_interface.dart';
import '../../object/snack_object.dart';

class SnackGetxImp extends SnackInterface {
  @override
  void showSnack(
      {String? title,
      String? message,
      Widget? content,
      SnackObject? snackObject,
      UtilState? state,
      SnackPosition? snackPosition,
      Color? backGroundColor}) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title ?? "",
      message ?? "",

      titleText: Text(
        title ?? "",
        style: TextStyle(
          color: snackObject?.titleColor,
          fontSize: snackObject?.titleSize,
          fontWeight: snackObject?.titleFontWeight,
        ),
      ),
      animationDuration: const Duration(
        seconds: 2,
      ),
      messageText: message != null && message.isNotEmpty
          ? Text(
              message,
              style: TextStyle(
                color: snackObject?.messageColor,
                fontSize: snackObject?.messageSize,
                fontWeight: snackObject?.messageFontWeight,
              ),
            )
          : null,
      colorText: snackObject?.titleColor,
      backgroundColor: snackObject?.color,
      duration: snackObject?.appearDuration,
      // shape: snackObject?.shape,
      // padding: snackObject?.padding,
      // behavior: snackObject?.behavior,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      // Reduce padding
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      // Add margin for spacing
      snackPosition: snackPosition ?? SnackPosition.TOP,
    );
  }

  @override
  void showActionSnack(
      {String? title,
      String? body,
      Widget? content,
      SnackObject? snackObject,
      UtilState? state,
      required GestureTapCallback onMainPressed,
      String? actionText,
      Color? actionTextColor,
      Color? actionDisabledTextColor,
      Color? backGroundColor}) {
    // Get.showDefaultSnack(
    //   title: title,
    //   titleSize: snackObject?.titleSize,
    //   titleColor: snackObject?.titleColor,
    //   titleWeight: snackObject?.titleFontWeight,
    //   message: body,
    //   messageSize: snackObject?.messageSize,
    //   messageColor: snackObject?.messageColor,
    //   messageWeight: snackObject?.messageFontWeight,
    //   content: content,
    //   backgroundColor: snackObject?.color,
    //   duration: snackObject?.appearDuration,
    //   shape: snackObject?.shape,
    //   padding: snackObject?.padding,
    //   behavior: snackObject?.behavior,
    //   action: SnackBarAction(
    //     label: actionText ?? SnackConstants.mainActionText,
    //     onPressed: onMainPressed,
    //     textColor: actionTextColor,
    //     disabledTextColor: actionDisabledTextColor,
    //   ),
    // );
  }
}
