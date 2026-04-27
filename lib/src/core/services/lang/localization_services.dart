import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../shared/domain/entities/language.dart';
import '../utils/general_utils.dart';
import '../utils/utils.dart';
import '../storage/src/storage_constants.dart';
import 'ar_ae.dart';
import 'en_us.dart';

class LocalizationServices extends Translations {
  LocalizationServices._();

  static final LocalizationServices instance = LocalizationServices._();

  static Locale? get locale => Utils.cachedLocale;

  static const Locale fallBackLocale = Locale('en', 'US');

  static bool get isRTL => currentLanguageKey == 1;

  @override
  Map<String, Map<String, String>> get keys => {
        'ar_AE': arAE,
        'en_US': enUS,
      };

  static void changeLanguage({required int languageKey}) {
    printDM('changeLanguage $languageKey');
    GetStorage().write(stgLang, languageKey);
    Get.updateLocale(LanguageData.locale(languageKey));
  }

  static int get currentLanguageKey => GetStorage().read(stgLang) ?? 1;

  static Locale get cachedLocale {
    return LanguageData.locale(GetStorage().read(stgLang) ?? 0);
  }

  static String get currentLocaleKey {
    final int id = GetStorage().read(stgLang) ?? 0;
    if (id == 1) return 'ar';
    if (id == 2) return 'en';
    return Get.deviceLocale?.languageCode ?? 'en';
  }

  static void checkCurrentLanguage() {
    if (currentLanguageKey == LanguageData.langList[0].id!) {
      changeLanguage(languageKey: LanguageData.langList[0].id!);
    } else {
      changeLanguage(languageKey: LanguageData.langList[1].id!);
    }
  }

  static void toggleLanguage() {
    if (currentLanguageKey == LanguageData.langList[0].id!) {
      changeLanguage(languageKey: LanguageData.langList[1].id!);
    } else {
      changeLanguage(languageKey: LanguageData.langList[0].id!);
    }
  }
}
