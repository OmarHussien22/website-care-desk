import '../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../core/services/lang/translate_extention.dart';
import '../../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import 'app_sheet.dart';
import 'src/resources/sheet_single_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/validation/implementation/default_validator/default_validator.dart';
import '../../../../../core/utils/validation/implementation/full_name_validator/full_name_validator.dart';
import '../../../../domain/entities/title_interface.dart';
import '../text_fields/default/default_text_field.dart';
import 'src/resources/sheet_multi_select.dart';
import 'src/resources/sheet_pagination_single_select.dart';

/// general single select sheet
class GeneralSelectSheet<T extends TitleInterface> extends StatelessWidget {
  final String title;
  final int selectedId;
  final String? hintText;
  final String? headerText;
  final List<T> items;
  final Function(T) onSelected;
  final TextEditingController? controller;
  final double? headerTextSize;
  final bool needValidate;
  final bool showCondition;
  final bool isPagination;
  final Color? fillColor;
  final String? failConditionMessage;
  final bool paginationLoading;
  final String? prefixIcon;

  const GeneralSelectSheet({
    super.key,
    required this.title,
    this.hintText,
    required this.items,
    required this.onSelected,
    this.controller,
    this.headerText,
    required this.selectedId,
    this.headerTextSize,
    this.needValidate = true,
    this.showCondition = true,
    this.isPagination = false,
    this.failConditionMessage,
    this.paginationLoading = false,
    this.prefixIcon,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    var node = FocusNode();

    return GestureDetector(
      onTap: () {
        if (showCondition) {
          if (isPagination) {
            AppSheets.get.showBottomSheet(
              SheetPaginationSingleSelect<T>(
                selectedId: selectedId,
                title: title,
                onSave: (value) {
                  Get.back();
                  onSelected(value);
                },
                items: items,
                paginationLoading: paginationLoading,
              ),
            );
          } else {
            AppSheets.get.showBottomSheet(
              SheetSingleSelect<T>(
                selectedId: selectedId,
                title: title,
                onSave: (value) {
                  Get.back();
                  onSelected(value);
                },
                items: items,
              ),
            );
          }
        } else {
          AppSnacks().showSnack(
            title:
                failConditionMessage?.toTr() ?? "this_field_is_disabled".toTr(),
            state: UtilState.error,
          );
        }
      },
      child: TextFieldDefault(
        hint: TFFHint(title: hintText?.tr),
        header: TFFHeader(title: headerText?.tr, fontSize: 13),
        prefix: prefixIcon != null
            ? PrefixWithIconImage(iconImage: prefixIcon ?? '')
            : const PrefixNone(),
        //fillColor: AppColors.get.white,
        suffix: SuffixWithIconData(
          iconData: Icons.keyboard_arrow_down,
          constraintsHeight: 30.toH(),
        ),
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
        // readOnly: true,
        enable: false,
        validation: needValidate ? DefaultValidator.instance.validate : null,
        controller: controller,
        onComplete: () {
          node.nextFocus();
        },
      ),
    );
  }
}

/// general multi select sheet
///

class GeneralMultiSelectSheet<T extends TitleInterface>
    extends StatelessWidget {
  final String title;
  final List<int> selectedIds;
  final String? hintText;
  final String? headerText;
  final String? prefixIcon;
  final List<T> items;
  final Function(List<T> list) onSelected;
  final TextEditingController? controller;
  final double? headerTextSize;

  const GeneralMultiSelectSheet({
    super.key,
    required this.title,
    this.hintText,
    required this.items,
    required this.onSelected,
    this.controller,
    this.headerText,
    this.prefixIcon,
    required this.selectedIds,
    this.headerTextSize,
  });

  @override
  Widget build(BuildContext context) {
    var node = FocusNode();

    return GestureDetector(
      onTap: () {
        AppSheets.get.showBottomSheet(
          SheetMultiSelect<T>(
            selectedIds: selectedIds,
            title: title,
            onSave: (value) {
              onSelected(value);
            },
            items: items,
          ),
        );
        // Get.bottomSheet(
        //   SheetSelect(
        //     selectedId: selectedId,
        //     title: title,
        //     onSave: (value) {
        //       Get.back();
        //       onSelected(value);
        //     },
        //     items: items,
        //   ),
        //   isScrollControlled: true,
        // );
      },
      child: TextFieldDefault(
        hint: TFFHint(title: hintText?.tr),
        header: TFFHeader(title: headerText?.tr, fontSize: headerTextSize),
        prefix: prefixIcon != null
            ? PrefixWithIconImage(iconImage: prefixIcon ?? '')
            : const PrefixNone(),
        fillColor: AppColors.get.white,
        suffix: SuffixWithIconImage(
          scale: 1.5,
          iconImage: AppIcons.downArrow,
          //constraintsHeight: 30.toH(),
        ),
        enable: false,
        validation: DefaultValidator.instance.validate,
        controller: controller,
        onComplete: () {
          node.nextFocus();
        },
      ),
    );
  }
}
