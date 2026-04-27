import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/tff_style_imp.dart';
import 'package:flutter/material.dart';

abstract class TFFTextImp extends TffStyleImp {
  final String? title;
  final String? hintTitle;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? backgroundColor;
  const TFFTextImp({
    this.title,
    this.color,
    this.hintTitle,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
  });
}
