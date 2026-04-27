import 'package:flutter/material.dart';

import '../../domain/entities/language.dart';

class LanguageModel extends Language {
  LanguageModel({
    int? id,
    String? flag,
    String? lagTitle,
    Locale? locale,
  }) : super(id: id, flag: flag, langTitle: lagTitle, locale: locale!);
}
