import 'dart:async';
import 'dart:math' as math;
import 'dart:io';
import 'dart:convert';
import 'package:coursaty/src/core/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dar';
import '../../shared/domain/entities/language.dart';
import '../services/lang/translate_extention.dart';
import '../services/storage/src/storage_constants.dart';
import 'general_utils.dart';

class Utils {
  Utils._();

  static final StorageService<int> _box = StorageService<int>();

  static Locale get cachedLocale {
    return LanguageData.locale(_box.read(stgLang) ?? 1);
  }

  static void changeLanguage(int id) {
    _box.save(stgLang, value: id);
  }

  static Language get cachedLanguageData {
    printDM("language system : ${_box.read(stgLang)}");
    return LanguageData.languageData(_box.read(stgLang) ?? 1);
  }

  static Future<void> applyHapticFeedback({bool vibration = false}) async {
    if (vibration) {
      await HapticFeedback.vibrate();
    } else {
      await HapticFeedback.heavyImpact();
    }
  }

  static String translateLabel(String value) {
    return value.toTr();
  }

  //   /// returns scanned qr code as a string
  //   ///This method depends on [FlutterBarcodeScanner] package
  //   /// requires extra steps for Ios configuration
  //   static Future<String> scanQRCode({ScanMode scanMode = ScanMode.QR}) async {
  //     String scannedQr;
  //
  //     ///TODO : add configuration to ios
  //     try {
  //       scannedQr = await FlutterBarcodeScanner.scanBarcode(
  //         "#1196c1",
  //         "cancel".tr,
  //         true,
  //         scanMode,
  //       );
  //     } on PlatformException {
  //       scannedQr = "";
  //     } catch (e) {
  //       printDM("Error in scanning QR is : => $e");
  //       scannedQr = "";
  //     }
  //     return scannedQr;
  //   }
  // }

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

  static bool isArabic() {
    return true;
  }

  /// ------------------------------ Snack -------------------------------------
  /// snackBar

  /// ------------------------------ toast --------------------------------------
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

  /// gets random number
  static int randomNumber({int nextInt = 1000}) {
    return math.Random().nextInt(nextInt) + 100;
  }

  static bool isTextArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  static Future<String> convertFileToBase64(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      final bytes = await file.readAsBytes();

      // Detect MIME type using file extension or content
      final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

      // Base64 encode the file content
      final base64String = base64Encode(bytes);

      // Return base64 with correct MIME type prefix
      return 'data:$mimeType;base64,$base64String';
    } else {
      throw Exception('File not found at: $filePath');
    }
  }
}
