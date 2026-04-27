import 'dart:io';

import '../../../../core/constants/strings/assets/app_basic_icons.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../general_widgets/buttons/customizable/imports_customizable.dart';

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  final AppBar _appBar;
  final double? toolbarHeight;
  final double? bottomHeight;

  const AppBars._(
    this._appBar, {
    Key? key,
    this.toolbarHeight,
    this.bottomHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _appBar;
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);

  // factory AppBars.search(BuildContext context) {
  //   return AppBars._(
  //     AppBar(
  //         toolbarHeight: 170.toH(),
  //         backgroundColor: Colors.transparent,
  //         automaticallyImplyLeading: false,
  //         // flexibleSpace: SearchWidget(),
  //         bottom: const PreferredSize(preferredSize: Size.fromHeight(70), child: SearchWidget())),
  //     // toolbarHeight: (230.toH()),
  //   );
  // }

  factory AppBars.logo({
    double? toolbarHeight,
    Widget? child,
    bool? centerTitle = true,
    List<Widget>? actions,
  }) {
    return AppBars._(
      AppBar(
        toolbarHeight: (toolbarHeight ?? kToolbarHeight).toH(),
        centerTitle: centerTitle,
        title: Padding(
          padding: EdgeInsetsDirectional.only(start: 10.toW()),
          child:
              child ??
              Image.asset(
                AppBasicIcons.logo,
                fit: BoxFit.contain,
                height: 80,
                width: 80,
              ),
        ),
        actions: actions,
      ),
    );
  }

  factory AppBars.basic({
    String? title,
    List<Widget>? actions,
    double? toolbarHeight,
    Widget? titleWidget,
    bool? centerTitle,
    Color? titleColor,
    bool isTitleBold = false,
    bool isBack = true,
    Widget? leading,
    double? elevation,
    double? fontSize,
    Color? backgroundColor,
    Color? arrowBackColor,
  }) {
    return AppBars._(
      AppBar(
        title:
            titleWidget ??
            CustomText(
              title ?? "",
              isBold: isTitleBold,
              color: titleColor ?? AppColors.get.black,
              fontSize: fontSize ?? 16,
              fontWeight: isTitleBold ? FW.bold : FW.semiBold,
            ),
        actions: actions,

        centerTitle: centerTitle ?? true,
        shadowColor: AppColors.get.shadow,
        elevation: elevation ?? 0,
        backgroundColor: backgroundColor ?? AppColors.get.background,
        leading: isBack
            ? ButtonBack(color: arrowBackColor)
            : leading ?? 0.ESH(),
        leadingWidth: leading != null ? 100.toW() : null,
      ),
      toolbarHeight: (toolbarHeight ?? kToolbarHeight).toH(),
    );
  }

  factory AppBars.colored({
    String? title,
    List<Widget>? actions,
    double? toolbarHeight,
    Widget? titleWidget,
    bool? centerTitle,
    Color? titleColor,
    bool isTitleBold = false,
    bool isBack = true,
    Widget? leading,
  }) {
    return AppBars._(
      AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.get.secondaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        title:
            titleWidget ??
            CustomText(
              title ?? "",
              isBold: isTitleBold,
              color: titleColor ?? AppColors.get.black,
              fontSize: 14,
              fontWeight: FW.semiBold,
            ),
        actions: actions,
        centerTitle: centerTitle ?? true,
        shadowColor: AppColors.get.shadow,
        elevation: 0,
        backgroundColor: AppColors.get.secondaryColor,
        leading: isBack
            ? IconButton(
                onPressed: () => Get.back(),
                splashRadius: 20.toRad(),
                icon: Icon(Icons.arrow_back_outlined, size: 24.toRad()),
                color: AppColors.get.opposite,
              )
            : leading ?? 0.ESH(),
      ),
      toolbarHeight: (toolbarHeight ?? kToolbarHeight).toH(),
    );
  }
}

///todo Custom Container in apppbar of icons

class CustomContainerIcons extends StatelessWidget {
  const CustomContainerIcons({
    Key? key,
    required this.child,
    this.width,
    this.height,
  }) : super(key: key);
  final Widget child;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 35,
      height: height ?? 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.get.grey, width: 0.2),
      ),
      child: Align(alignment: Alignment.center, child: child),
    );
  }
}
