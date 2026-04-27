import 'package:flutter/material.dart';
import '../../../../../../../../../../packages_index.dart';
import '../../../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../../buttons/basic/button_close.dart';
import '../interface/sheet_header_interface.dart';
import '../options/sheet_header_option.dart';
import '../../../utils/constants/sheet_constants.dart';
import '../../../../../text/custom_text_lib.dart';

class SheetHeaderBasic extends SheetHeaderInterface {
  final String title;
  final Widget? action;
  final Widget? closeAction;
  final VoidCallback? onClose;
  SheetHeaderOptions? options;

  SheetHeaderBasic({
    super.key,
    this.title = '',
    this.action,
    this.options,
    this.closeAction,
    this.onClose,
  }) {
    options ??= SheetHeaderOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SheetConstants.get.headerPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          closeAction ??  Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.get.lighterGrey),
            child:
                ButtonClose(onTap: onClose ?? () => Get.back()),
          ),
          CustomText(
            title,
            fontSize: SheetConstants.get.headerTextSize,
            fontWeight: SheetConstants.get.headerTextWeight,
          ),
          action ?? 0.ESW(),
        ],
      ),
    );
  }
}
