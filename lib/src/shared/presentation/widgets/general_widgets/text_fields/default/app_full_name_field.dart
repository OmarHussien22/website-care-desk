import 'package:flutter/material.dart';

import '../../../../../../core/utils/validation/app_validator.dart';
import 'default_text_field.dart';

class AppFullNameField extends StatelessWidget {
  final TextEditingController? controller;
  final String icon;
  final Color? fillColor;
  final bool withHeader;
  final String? headerTitle;
  final String? hintText;
  final VoidCallback? onComplete;
  final String? Function(String?)? validation;
  const AppFullNameField({super.key,  this.controller, required this.icon,  this.withHeader=false, this.onComplete,this.fillColor, this.headerTitle, this.hintText, this.validation});

  @override
  Widget build(BuildContext context) {
    return    TextFieldDefault(
      controller: controller,
      isRequiredInHint: true,
      hint:  TFFHint(title:hintText?? 'full_name'),
      header: withHeader? TFFHeader(title:headerTitle?? "full_name"):const TFFNone(),
      validation:validation?? AppValidator.fullNameValidator.validate,
      onComplete: onComplete,
      fillColor:fillColor ,
      inputDecoration:   InputDecorationWithBorder(
    filledColor: fillColor,
      disableBorderColor: fillColor,
      enableBorderColor: fillColor,
      errorBorderColor: fillColor,
      focusBorderColor: fillColor,
      borderColor: fillColor,
    ),
      isFilled: fillColor!=null,
      prefix:
      PrefixWithIconImage(iconImage: icon),
    );
  }
}
