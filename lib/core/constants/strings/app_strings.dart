import 'dart:io';

import '../../../flavors/flavor_holder.dart';
import '../../services/package_info/package_info.dart';

// TODO 2 : Add app name and app description here

const String kDummyData =
    "هذا نص تجريبي للتطبيق ولا يحتوي على أي معلومات حقيقية وهو مجرد نص تجريبي للتطبيق";

class AppStrings {
  AppStrings._();

  static final _flavor = FlavorHolder.instance.flavor;

  static const String appName = 'Coursaty';
  static final String appNameArabic = _flavor.appName;
  static final String appNameEnglish = _flavor.appName;
  static const String oTPInitialCode = 'EG';
  static const String appLegale = 'Ⓒ2025 $appName ';
  static const String androidIconPath = '@mipmap/ic_launcher';
  static const String fontFamily = "URW";
  static final String appKey = _flavor.apiKey;
  static const String fontFamilySecondary = "";
  static final String appIcon = _flavor.appIcon;
  static final String appAndroidVersion =
      "${PackageInfoGetter.version} + ${PackageInfoGetter.buildNumber}";
  static final String appIOSVersion = PackageInfoGetter.version;
  static const String appCompanyName = "TechLab";
  static const String appCompanyLink = "https://techlabeg.com/";
  static String appDefaultCountryCode = "+966";
  static final String appVersion = PackageInfoGetter.version;
  static final String appBuildNumber = PackageInfoGetter.buildNumber;
  static final String _appStoreId = PackageInfoGetter.packageName;
  static final String playStoreUrl =
      'https://play.google.com/store/apps/details?id=$appName';
  static final String appStoreUrl =
      'https://apps.apple.com/us/app/$appName/id$_appStoreId';
  static final String directTrainingUrl =
      'https://student.success.sa/';
  static final String appID = PackageInfoGetter.packageName;
  static const String mapKey = '';
  static const String fcmToken = '';
  static const String appStoreID = '';
  static const String appUserVisitorPhone = "01017100093";
  static const String appUserVisitorPassword = "123123123";
  static const int dbVersion = 1;
  static const int localAppAndroidVersion = 1;
  static const int localAppIosVersion = 1;
  // static const String iosStatusTitle = "ios_old_status";
  static const String iosStatusTitle = "ios_new_status";

  static const String androidStatusTitle = "android_old_status";
// static const String androidStatusTitle = "android_new_status";
}

String get getOS => Platform.operatingSystem;

String get ios => "ios";

String get android => "android";
