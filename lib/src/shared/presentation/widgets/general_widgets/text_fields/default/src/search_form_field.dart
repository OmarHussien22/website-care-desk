import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../../../core/services/lang/translate_extention.dart';
import '../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../../core/utils/validation/app_validator.dart';
import '../default_text_field.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onCountryCodeChanged;
  final String? Function(String?)? validation;
  final Function()? onComplete;
  final String? header;
  final bool isEnabled;
  final bool hasCountryCode;

  const SearchFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.validation,
    this.onComplete,
    this.header,
    this.isEnabled = true,
    this.onCountryCodeChanged,
    this.hasCountryCode = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldDefault(
      keyboardType: TextInputType.phone,
      header: TFFHeader(title: header ?? 'phone_number'.toTr()),
      hint: TFFHint(title: 'enter_phone_number'.toTr()),
      enable: isEnabled,
      controller: controller,
      onChanged: onChanged,
      validation: AppValidator.phoneValidator.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefix: PrefixWithIconImage(iconImage: AppIcons.phone, scale: 1.2),
      suffix: hasCountryCode
          ? SuffixWithWidget(
              constraintsWidth: 100,
              constraintsHeight: 100,
              widget: CountryCodePicker(
                onChanged: (value) {
                  if (onCountryCodeChanged != null) {
                    onCountryCodeChanged!(value.dialCode ?? "");
                  }
                },
                initialSelection: 'EG',
                favorite: const ['+20', "+966"],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
            )
          : const SuffixNone(),
      onComplete: onComplete,
      fillColor: AppColors.get.greyLight,
      inputDecoration: isEnabled
          ? InputDecorationWithBorder(
              enableBorderColor: AppColors.get.greyLight,
            )
          : InputDecorationWithBorder(
              enableBorderColor: AppColors.get.greyLight,
              disableBorderColor: AppColors.get.greyLight,
            ),
    );
  }
}
