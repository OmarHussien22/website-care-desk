import 'dart:io';

import 'package:flutter/services.dart';
import 'package:no_screenshot/no_screenshot.dart';

import '../../utils/general_utils.dart';

class ScreenShotService {
  ScreenShotService._();

  static final ScreenShotService instance = ScreenShotService._();

  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  Future<void> disableScreenshot() async {
    final bool result = await _noScreenshot.screenshotOff();
    printDM('Screenshot Off: $result');
  }

  Future<void> enableScreenshot() async {
    try {
      final bool result = await _noScreenshot.screenshotOn();
      printDM('Screenshot On: $result');
    } catch (e) {
      printDM('Enable Screenshot failed: $e');
    }
  }

  void listenScreenshot({Function? onScreenshotTaken}) {
    _noScreenshot.screenshotStream.listen((event) {
      printDM('Screenshot or screen recording detected: $event');
      onScreenshotTaken?.call();
    });
  }

  void listenStartScreenShot() {
    _noScreenshot.stopScreenshotListening();
  }
}

class ScreenshotWatcher {
  static const MethodChannel _channel =
      MethodChannel('com.crazyidea.qudorat3/screen_security');

  static void initListeners({
    Function()? onScreenshot,
    Function()? onScreenRecording,
  }) {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onScreenshot':
          onScreenshot?.call();
          break;
        case 'onScreenRecording':
          onScreenRecording?.call();
          break;
      }
    });
  }

  static void initSecurityListener({
    Future<void> Function()? onViolation,
  }) {
    if (!Platform.isAndroid) return;

    initListeners(
      onScreenshot: () async {
        printDM('Screenshot detected');
        await onViolation?.call();
      },
      onScreenRecording: () async {
        printDM('Screen recording detected');
        await onViolation?.call();
      },
    );
  }
}
