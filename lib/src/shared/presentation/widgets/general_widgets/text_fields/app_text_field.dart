import 'package:flutter/material.dart';

import '../../../../../core/services/lang/translate_extention.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/extensions/basic_op_extensions.dart';
import '../../../../../core/utils/validation/app_validator.dart';
import 'default/default_text_field.dart';

class AppFillTextFieldField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? hint;
  final String? header;
  final String? prefixAsset;
  final double? prefixScale;
  final VoidCallback? onTap;
  final bool readOnly;
  final VoidCallback? onComplete;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isSheet;

  const AppFillTextFieldField({
    super.key,
    this.controller,
    this.validation,
    this.hint,
    this.header,
    this.prefixAsset,
    this.prefixScale = 1.5,
    this.onTap,
    this.keyboardType,
    this.readOnly = false,
    this.isSheet = false,
    this.onComplete,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldDefault(
      keyboardType: keyboardType,
      fillColor: AppColors.get.greyLight,
      inputDecoration: InputDecorationWithBorder(
        enableBorderColor: AppColors.get.greyLight,
      ),
      validation: AppValidator.defaultValidator.validate,
      controller: controller,
      hint: TFFHint(title: hint?.toTr()),
      maxLines: maxLines,
      header: TFFHeader(title: header != null ? header?.toTr() : null),
      prefix: prefixAsset != null
          ? PrefixWithIconImage(
              scale: prefixScale,
              iconImage: prefixAsset.noneNull,
            )
          : const PrefixNone(),
      suffix: isSheet
          ? SuffixWithIconData(iconData: Icons.keyboard_arrow_down)
          : const SuffixNone(),
      readOnly: isSheet ? true : readOnly,
      onTap: onTap,
      onComplete: onComplete,
    );
  }
}
