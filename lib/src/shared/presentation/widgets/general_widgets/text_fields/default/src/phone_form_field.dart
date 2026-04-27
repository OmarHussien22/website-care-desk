import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../../../../../core/app/app_settings.dart';
import '../../../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../../../core/services/lang/translate_extention.dart';
import '../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../../core/utils/validation/app_validator.dart';
import '../default_text_field.dart';

class PhoneFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onCountryCodeChanged;
  final String? Function(String?)? validation;
  final Function()? onComplete;
  final String? header;
  final String? hint;
  final bool isEnabled;
  final bool hasCountryCode;

  const PhoneFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.validation,
    this.onComplete,
    this.header,
    this.isEnabled = true,
    this.onCountryCodeChanged,
    this.hasCountryCode = false,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldDefault(
      keyboardType: TextInputType.phone,
      header: header == null
          ? const TFFNone()
          : TFFHeader(title: header ?? 'phone_number'.toTr(), hintTitle: hint),
      hint: TFFHint(title: 'enter_phone_number'.toTr()),
      enable: isEnabled,
      controller: controller,
      onChanged: onChanged,
      validation: AppValidator.phoneValidator.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      prefix: PrefixWithIconImage(
        iconImage: AppIcons.phone,
        scale: 1.2,
        constraintsHeight: 16,
      ),
      suffix: hasCountryCode
          ? SuffixWithWidget(
              constraintsWidth: 100,
              constraintsHeight: 100,
              widget: IgnorePointer(
                ignoring: AppSettings.isCountryCodeConst,
                child: CountryCodePicker(
                  // flagDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  onChanged: (value) {
                    if (onCountryCodeChanged != null) {
                      onCountryCodeChanged!(value.dialCode ?? "");
                    }
                  },
                  initialSelection: AppSettings.countryCode,
                  favorite: const ["+966"],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
              ),
            )
          : const SuffixNone(),
      onComplete: onComplete,
      fillColor: AppColors.get.greyLight,
      autoFocus: false,
      // inputDecoration: isEnabled
      //     ? InputDecorationWithBorder(
      //         enableBorderColor: AppColors.get.greyLight)
      //     : InputDecorationWithBorder(
      //         enableBorderColor: AppColors.get.greyLight,
      //         disableBorderColor: AppColors.get.greyLight,
      //       ),
    );
  }
}
