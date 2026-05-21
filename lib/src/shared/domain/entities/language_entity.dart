import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/strings/assets/app_images.dart';

class LanguageEntity with EquatableMixin {
  int? id;
  String? flag;
  String? langTitle;
  String? langShortTitle;
  Locale locale;

  LanguageEntity({
    this.id,
    this.flag,
    required this.locale,
    this.langTitle,
    this.langShortTitle,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, flag, langTitle, locale];
}

class LanguageData {
  LanguageData._();
  static final List<LanguageEntity> _langList = [
    LanguageEntity(
      id: 1,
      flag: AppImages.enFlag,
      langTitle: "arabic",
      langShortTitle: "ar",
      locale: const Locale('ar', 'AR'),
    ),
    LanguageEntity(
      id: 2,
      flag: AppImages.enFlag,
      langTitle: "english",
      langShortTitle: "en",
      locale: const Locale("en", "US"),
    ),
  ];
  static List<LanguageEntity> get langList => _langList;

  static Locale locale(int id) {
    if (id == 1) {
      return const Locale('ar', 'AR');
    } else if (id == 2) {
      return const Locale("en", "US");
    } else {
      return const Locale("en", "US");
    }
  }

  static LanguageEntity languageData(int id) {
    int index = _langList.indexWhere((element) => element.id == id);
    if (index != -1) {
      return _langList[index];
    } else {
      return _langList[1];
    }
  }

  //<editor-fold desc="Data Methods">
  //</editor-fold>
}
