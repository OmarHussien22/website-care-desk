import 'package:coursaty/src/core/utils/validation/implementation/password_validator/password_validator.dart';
import 'package:coursaty/src/core/utils/general_utils.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/default_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../../core/services/lang/translate_extention.dart';
import '../../../../../../core/styles/colors/app_colors.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    required this.controller,
    this.node,
    this.isRequired = true,
    this.validation,
    this.onComplete,
    this.hint,
    this.headerText,
    this.fillColor,
    this.withHeader = false,
    this.headerTitle,
  });

  final TextEditingController? controller;
  final FocusNode? node;
  final bool isRequired;
  final Color? fillColor;
  final String? Function(String?)? validation;
  final Function()? onComplete;
  final String? hint;
  final String? headerText;
  final bool withHeader;
  final String? headerTitle;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldDefault(
      isRequired: false,
      header: widget.withHeader
          ? TFFHeader(
              title: widget.headerTitle ?? widget.hint ?? "enter_password",
            )
          : const TFFNone(),
      isRequiredInHint: widget.isRequired,
      controller: widget.controller,

      suffix: SuffixPassword(
        showPassword: isPasswordVisible,
        onTap: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
          printDM('isPasswordVisible: $isPasswordVisible');
        },
      ),
      fillColor: widget.fillColor,
      maxLines: 1,

      autoFocus: false,
      isFilled: widget.fillColor != null,
      inputDecoration: InputDecorationWithBorder(
        filledColor: widget.fillColor,
        disableBorderColor: widget.fillColor,
        enableBorderColor: widget.fillColor,
        errorBorderColor: widget.fillColor,
        focusBorderColor: widget.fillColor,
        borderColor: widget.fillColor,
      ),
      hint: TFFHint(title: (widget.hint ?? "enter_password").toTr()),
      // label: TFFLabel(
      //   title: widget.hint?.toTr() ?? "enter_password".toTr(),
      // ),
      validation: widget.validation ?? PasswordValidator.instance.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onComplete: widget.onComplete,
    );
  }
}
