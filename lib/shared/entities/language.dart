import '../../core/constants/strings/assets/app_icons.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Language with EquatableMixin {
  final int? id;
  final String? flag;
  final String? langTitle;
  final Locale locale;

  const Language({
    this.id,
    this.flag,
    required this.locale,
    this.langTitle,
  });

  @override
  List<Object?> get props => [id, flag, langTitle, locale];
}

class LanguageData {
  LanguageData._();

  static final List<Language> _langList = [
    const Language(
      id: 1,
      flag: AppIcons.ar,
      langTitle: 'arabic',
      locale: Locale('ar', 'AR'),
    ),
    const Language(
      id: 2,
      flag: AppIcons.en,
      langTitle: 'english',
      locale: Locale('en', 'US'),
    ),
  ];

  static List<Language> get langList => _langList;

  static Locale locale(int id) {
    switch (id) {
      case 1:
        return const Locale('ar', 'AR');
      case 2:
        return const Locale('en', 'US');
      default:
        return const Locale('en', 'US');
    }
  }
}
