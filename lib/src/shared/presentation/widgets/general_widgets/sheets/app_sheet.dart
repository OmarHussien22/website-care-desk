import 'package:coursaty/src/core/constants/decorations/app_shapes.dart';
import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/sheets/src/components/headers/interface/sheet_header_interface.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/sheets/src/resources/sheet_multi_select.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/sheets/src/resources/sheet_single_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/extensions/color_extension.dart';
import '../../../../domain/entities/title_interface.dart';
import 'custom_sheet.dart';
import 'sheet_widget_title.dart';

class AppSheets {
  AppSheets._();

  static AppSheets get get => AppSheets._();

  void closeOpenSheets() {
    if (Get.isBottomSheetOpen == true) {
      Get.back();
    }
  }

  void showBottomSheet(Widget sheetBody, {bool isDismissible = true}) {
    Get.bottomSheet(
      sheetBody,
      backgroundColor: AppColors.get.main,
      elevation: 2,
      shape: AppShapes.bottomSheetShape,
      isDismissible: isDismissible,
      barrierColor: Colors.black87.toOpacityColor(0.7),
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  void showSingleSelection<T extends TitleInterface>({
    Key? key,
    String? title,
    SheetHeaderInterface? header,
    int? selectedId,
    required List<T> items,
    required Function(T) onSave,
    double? height,
  }) {
    showBottomSheet(
      SheetSingleSelect<T>(
        key: key,
        items: items,
        onSave: onSave,
        selectedId: selectedId ?? -1,
        height: height ?? 500.toH(),
        title: title ?? '',
        header: header,
      ),
    );
  }

  void showMultiSelection<T extends TitleInterface>({
    Key? key,
    final String? title,
    final SheetHeaderInterface? header,
    final List<int>? selectedIds,
    required final List<T> items,
    required final Function(List<T>) onSave,
    final Widget Function(T item)? builder,
  }) {
    showBottomSheet(
      SheetMultiSelect<T>(
        key: key,
        items: items,
        onSave: onSave,
        selectedIds: selectedIds ?? [],
        title: title ?? '',
        header: header,
      ),
    );
  }

  void showCountrySelection() {}

  void showCustomSheet(
    Widget body, {
    double? height,
    String title = "",
    String subtitle = '',
    String icon = '',
    Widget? footer,
    Widget? stackWidget,
  }) {
    showBottomSheet(
      CustomSheet(
        body: body,
        height: height,
        title: title,
        subtitle: subtitle,
        icon: icon,
        footer: footer,
        stackWidget: stackWidget,
      ),
    );
  }

  void showSheetWidgetTitle(
    Widget body, {
    Widget title = const SizedBox.shrink(),
    double? height,
  }) {
    showBottomSheet(SheetWidgetTitle(body: body, title: title, height: height));
  }
}
