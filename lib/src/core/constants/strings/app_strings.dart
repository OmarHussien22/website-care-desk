import 'dart:io';

import '../../services/lang/translate_extention.dart';
import '../../services/package_info/package_info.dart';

String kDummyData = Platform.isAndroid
    ? ""
    //? "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى ...هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى ..."
    : "";

class AppStrings {
  AppStrings._();

  static const String appName = 'Care P.O';
  static const String appDescription =
      '$appName is an e-commerce application that allows users to browse and purchase products online.';
  static final String appLegalese =
      '${"all_rights_reserved".toTr()} $appName © ${DateTime.now().year}';
  static const String androidIconPath = '@mipmap/ic_launcher';
  static const String companyNAme = 'TechLab';
  static const String fontFamilyUrw = "urw";
  static const String fontFamilySar = "sar";
  static const String fontFamilyMochiyPop = "mochiy_pop";
  static const String fontFamilySecondary = "";
  static const String appIcon = "assets/app_icons/logo.png";
  static String appAndroidVersion = PackageInfoGetter.version;
  static String appIOSVersion = PackageInfoGetter.version;
  static String iOSVersion = PackageInfoGetter.buildNumber;
  static String androidVersion = PackageInfoGetter.buildNumber;
  static String appVersion = PackageInfoGetter.version;
  static String appBuildNumber = PackageInfoGetter.buildNumber;
  static const String _appStoreId = 'com.crazyidea.$appName';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=$appName';
  static const String appStoreUrl =
      'https://apps.apple.com/us/app/$appName/id$_appStoreId';
  // static const String _appID = 'com.crazyidea.$appName';
  // static const String _mapKey = '';
  // static const String _FCMToken = '';
  static const String appStoreID = '';
  static const String apiKeyMap = "AIzaSyDs2ePgl_wNl3RIJLzkUhTEcvPsjeB0u7c";
  static const int localAppAndroidVersion = 1;
  static const int localAppIosVersion = 1;

  static String inviteCode = "send_code_to_invite_friends".toTr();
}

String get getOS => Platform.operatingSystem;

String get ios => "ios";

String get android => "android";
