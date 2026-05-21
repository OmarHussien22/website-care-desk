import 'dart:async';
import 'dart:math' as math;

import '../../../shared/domain/entities/language_entity.dart';
import '../../constants/decorations/app_shapes.dart';
import '../lang_service/translate_extention.dart';
import 'extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../storage/src/storage_constants.dart';
import '../storage/storage_service.dart';
import 'snack_utils/src/constants/snack_constants.dart';
// TODO : add the most main used functions here !

class Utils {
  Utils._();
  static Locale get cachedLocale {
    return LanguageData.locale(StorageService<int>().read(stgLang) ?? 1);
  }

  static Future<void> applyHapticFeedback({bool vibration = false}) async {
    if (vibration) {
      await HapticFeedback.vibrate();
    } else {
      await HapticFeedback.heavyImpact();
    }
  }

  static void closeOpenDialogs() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

    // in app status controller
  static bool isLower(String current, String target) {
    final currentParts =
        current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final targetParts =
        target.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final maxLength = currentParts.length > targetParts.length
        ? currentParts.length
        : targetParts.length;

    for (int i = 0; i < maxLength; i++) {
      final c = i < currentParts.length ? currentParts[i] : 0;
      final t = i < targetParts.length ? targetParts[i] : 0;

      if (c < t) return true;
      if (c > t) return false;
      // if (c == t) continue; // Implicit by loop
    }
    return false;
  }

  /// Allow you to copy [Text] to clipboard
  static Future<void> copyToClipboard(String text) async {
    // if (text.trim().isEmpty) {
    //   AppSnacks.showSnackNotificationBar(
    //     title: "",
    //     body: "",
    //   );
    //   return;
    // } else {
    //   Clipboard.setData(ClipboardData(text: text)).then((value) {
    //     AppSnacks.showSnackNotificationBar(
    //       title: "تم النسخ بنجاح",
    //       body: text,
    //     );
    //   });
    // }
  }
  static void showToast({
    required String title,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.TOP,
    required UtilState state,
  }) {
    Fluttertoast.showToast(
      msg: title.toTr(),
      backgroundColor: state == UtilState.error
          ? Colors.red
          : state == UtilState.success
              ? Colors.green
              : Colors.blue,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 6,

      // backgroundColor: _toastColor(state),
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static void showDialog({
    Widget? child,
    bool isDismissible = true,
    EdgeInsets insetPadding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
  }) {
    Get.dialog(
      AlertDialog(
        insetPadding: insetPadding,
        contentPadding: contentPadding,
        shape: AppShapes.dialogShape,
        content: SizedBox(
          width: Get.mediaQuery.size.width,
          child: child,
        ),
      ),
      transitionCurve: Curves.fastLinearToSlowEaseIn,
      barrierColor: const Color(0xff333333).toOpacityColor(0.9),
      barrierDismissible: isDismissible,
    );
  }

  /// ------------------------------ Snack -------------------------------------
  /// snackBar

  /// ------------------------------ toast --------------------------------------

  /// gets random number
  static int randomNumber({int nextInt = 1000}) {
    return math.Random().nextInt(nextInt) + 100;
  }

  /// seen ND Un seen notification
  static final notificationSeen = StorageService<bool>();
  static void seenNotification() async {
    await notificationSeen.save(stgNotificationSeen, value: true);
  }

  static void unSeenNotification() async {
    await notificationSeen.save(stgNotificationSeen, value: false);
  }

  static bool fetchNotificationReadStatus() {
    return notificationSeen.read(stgNotificationSeen, defaultValue: false) ??
        false;
  }

  /// 1 ==> version1 > version2
  /// -1 ==> version1 < version2
  /// 0 ==> version1 == version2
  static int compareVersions(String version1, String version2) {
    if (version1.isEmpty && version2.isEmpty) return 0;
    if (version1.isEmpty) return -1;
    if (version2.isEmpty) return 1;
    final parts1 = version1.split('.').map(int.parse).toList();
    final parts2 = version2.split('.').map(int.parse).toList();

    for (int i = 0; i < math.max(parts1.length, parts2.length); i++) {
      final part1 = i < parts1.length ? parts1[i] : 0;
      final part2 = i < parts2.length ? parts2[i] : 0;

      if (part1 != part2) {
        return part1 > part2
            ? 1
            : part1 < part2
                ? -1
                : 0;
      }
    }
    return 0;
  }

  static bool isTextArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  static String numberToLetter(int number) {
    // A has ASCII code 65
    return String.fromCharCode(64 + number);
  }
}
