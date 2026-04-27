import 'package:country_code_picker/country_code_picker.dart';
import 'package:coursaty/src/core/constants/strings/assets/app_icons.dart';
import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:coursaty/src/core/utils/validation/app_validator.dart';
import 'package:coursaty/src/core/utils/general_utils.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';

class CustomPhoneWithCountryKey extends StatelessWidget {
  final FocusScopeNode? node;
  final TextEditingController? textEditingController;
  final Function(String) onSelect;
  final Function()? onComplete;
  final bool withHeader;
  final String? headerTitle;
  final String? initialCode;
  final Color? fillColor;

  const CustomPhoneWithCountryKey({
    Key? key,
    this.node,
    required this.textEditingController,
    required this.onSelect,
    this.onComplete,
    this.withHeader = false,
    this.initialCode,
    this.fillColor,
    this.headerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printDM("checkou code in phone with code $initialCode");
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          TextFieldDefault(
            // suffix: _.suffixCheckPhone(),
            hint: const TFFHint(title: 'phone_hint'),
            header: withHeader
                ? TFFHeader(title: headerTitle ?? "phone_hint")
                : const TFFNone(),
            validation: AppValidator.phoneValidator.validate,
            keyboardType: TextInputType.phone,
            controller: textEditingController,
            onComplete: onComplete,
            fillColor: fillColor,
            suffix: SuffixWithWidget(
              constraintsWidth: 100,
              constraintsHeight: 100,
              widget: FittedBox(
                child: CountryCodePicker(
                  // backgroundColor: Colors.orange,barrierColor:
                  // Colors.red
                  // ,
                  onChanged: (CountryCode countryCode) {
                    onSelect(countryCode.dialCode!);
                  },
                  initialSelection: initialCode ?? 'EG',
                  favorite: const [
                    '+20',
                    '+966',
                    '+971',
                    '+974',
                    '+973',
                    '+968',
                    '+965',
                    '+962',
                  ],
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: false,
                  showFlagDialog: true,
                  showFlag: true,
                  alignLeft: false,

                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  dialogTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            inputDecoration: InputDecorationWithBorder(
              filledColor: fillColor,
              disableBorderColor: fillColor,
              enableBorderColor: fillColor,
              errorBorderColor: fillColor,
              focusBorderColor: fillColor,
              borderColor: fillColor,
            ),
            isFilled: fillColor != null,
            onChanged: (value) {},
          ),

          // CountryKeys(
          //   onSelect: (String countryKeySelected) {
          //     onSelect(countryKeySelected);
          //   },
          // ),
        ],
      ),
    );
  }
}
