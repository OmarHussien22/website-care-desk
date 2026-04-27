import 'dart:io';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'app_layout.dart';
import 'http_client.dart';
import '../network_structure/networking/network_service.dart';
import '../services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


import '../../../firebase_options.dart';
import '../../../packages_index.dart';
import '../../shared/presentation/widgets/error/app_error_builder.dart';
import '../constants/strings/app_strings.dart';
import '../services/package_info/package_info.dart';
import '../utils/general_utils.dart';
import '../utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';


/// Contains All The Methods needed to be run before MyApp Compiles
class AppInitializer {
  AppInitializer._();

  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// * Storage Service Initialization
    await StorageService().init();

    /// * Package info initialization
    await PackageInfoGetter.init();

    /// * FireBase Initialization
    // TODO: setup - uncomment option attribute when init firebase
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      printDM("Firebase Error: $e");
    }

    /// * Date Fromatting Configuration
    await initializeDateFormatting('ar', null);


    /// * Error Widget Configuration
    ErrorWidget.builder = (FlutterErrorDetails details) =>
        AppErrorBuilder(details);

    /// * Http Client Configuration
    HttpOverrides.global = MyHttpOverrides();

    /// * ScreenShot Configuration
    // Helper.screenShot.secureApp();

    /// * Network Service Initialization
    NetworkService().init();

    /// * Map Initialization
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    // }
    // await BackgroundLocation.startLocationService();
    // Helper.location.determinePosition();

    /// * App Orientation Configuration
    await AppLayout.fixedOrientation();

    /// * Crashlytics Firebase Configuration
    /// * commented because you use sentry
    // if (kReleaseMode) {
    // FlutterError.onError =
    //     FirebaseCrashlytics.instance.recordFlutterFatalError;
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };
    // }

  }
}
