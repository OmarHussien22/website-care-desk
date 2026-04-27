import 'package:flutter/material.dart';

import '../../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/validation/app_validator.dart';
import 'default_text_field.dart';

class AppEmailField extends StatelessWidget {
  final TextEditingController? email;
final bool isEnable;
  final bool isRequired;
  final VoidCallback? onComplete;
  final Color? fillColor;
  final String? headerTitle;
  final bool withHeader;

  const AppEmailField(
      {super.key,
      required this.email,
      this.isRequired = true,
      this.onComplete,
      this.withHeader = false,
      this.fillColor,  this.headerTitle,  this.isEnable=true});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable?1:0.6,
      child: TextFieldDefault(
      enable: isEnable,
        hint:  TFFHint(
          title: "email",
          color: isEnable?null:AppColors.get.grey
        ),
        header: withHeader ?  TFFHeader(title: headerTitle??"email") : const TFFNone(),
        validation: AppValidator.emailValidator.validate,
        isRequiredInHint: isRequired,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        fillColor: fillColor,
        isFilled: fillColor != null,
        inputDecoration: InputDecorationWithBorder(
          filledColor: fillColor,
          disableBorderColor: fillColor,
          enableBorderColor: fillColor,
          errorBorderColor: fillColor,
          focusBorderColor: fillColor,
          borderColor: fillColor,
        ),
        controller: email,
        onComplete: onComplete,
      ),
    );
  }
}
