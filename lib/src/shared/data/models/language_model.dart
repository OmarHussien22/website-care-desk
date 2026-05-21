import 'package:flutter/material.dart';

import '../../domain/entities/language_entity.dart';

class LanguageModel extends LanguageEntity {
  LanguageModel({int? id, String? flag, String? lagTitle, Locale? locale})
    : super(id: id, flag: flag, langTitle: lagTitle, locale: locale!);
}
