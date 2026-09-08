import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/decorations/app_insets.dart';
import '../../../../../../core/constants/strings/app_strings.dart';
import '../../../../../../core/services/lang/translate_extention.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/extensions/color_extension.dart';
import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../spaces_dividers/spaces.dart';
import '../../text/custom_text_lib.dart';

class ButtonDefault extends StatelessWidget {
  final Widget? child;
  final String? title;

  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? titleColor;
  final Color? disabledColor;
  final Color? color;
  final VoidCallback? onPressed;
  final double elevation;
  final double? height;
  final double? borderRadius;
  final double? width;
  final double? titleSize;
  final bool isDisabled;
  final EdgeInsetsGeometry? padding;

  final String tooltip;

  const ButtonDefault({
    Key? key,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.disabledColor,
    this.color = Colors.white,
    this.onPressed,
    this.elevation = 1.0,
    this.padding,
    this.child,
    this.tooltip = '',
    this.isDisabled = false,
    this.height,
    this.width,
    this.title,
    this.titleColor = Colors.white,
    this.titleSize = 16,
    this.borderRadius,
  }) : super(key: key);

  //
  // Rounded Icon Button -------------------------------------------------------
  factory ButtonDefault.icon({
    /// new
    required final String label,
    IconData icon = Icons.arrow_forward_ios_outlined,

    /// super
    final Color? backgroundColor,
    final Color? disabledBackgroundColor,
    final Color? disabledColor,
    final Color? color,
    final VoidCallback? onPressed,
    final bool isDisabled = false,
    final bool isUpperCase = false,
    final String tooltip = '',
  }) => ButtonDefault(
    tooltip: tooltip,
    onPressed: onPressed,
    isDisabled: isDisabled,
    color: color,
    disabledColor: disabledColor,
    disabledBackgroundColor: disabledBackgroundColor,
    backgroundColor:
        backgroundColor ??
        (isDisabled
            ? AppColors.get.primary.toOpacityColor(0.5)
            : AppColors.get.primary),
    child: Builder(
      builder: (context) {
        // Color? color;
        // if (isDisabled) {
        //   color = AppColors.get.primary;
        // } else {
        //   color = color;
        // }

        return _IconRoundedChild(
          color: color,
          label: label.toTr(),
          icon: icon,
          isUpperCase: isUpperCase,
        );
      },
    ),
  );

  // Rounded Image Button ------------------------------------------------------
  factory ButtonDefault.image({
    /// new
    required final String label,
    required final ImageProvider image,
    final double side = 25,

    /// super
    final Color? backgroundColor,
    final Color? disabledBackgroundColor,
    final Color? disabledColor,
    final double? height,
    final Color? color = Colors.white,
    final VoidCallback? onPressed,
    final bool isDisabled = false,
    final bool isUpperCase = false,
    final EdgeInsetsGeometry? padding,
    final String tooltip = '',
  }) => ButtonDefault(
    padding: padding,
    tooltip: tooltip,
    onPressed: onPressed,
    height: height,
    isDisabled: isDisabled,
    color: color,
    disabledColor: disabledColor,
    disabledBackgroundColor: disabledBackgroundColor,
    backgroundColor: backgroundColor ?? AppColors.get.primary,
    child: Builder(
      builder: (context) {
        Color? color;
        if (isDisabled) {
          color = AppColors.get.disabled;
        } else {
          color = color;
        }
        return _ImageRoundedChild(
          label: label,
          image: image,
          color: color,
          side: side,
          isUpperCase: isUpperCase,
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Color? backgroundColor;
        // Color? color;
        // if (isDisabled) {
        //   backgroundColor = disabledBackgroundColor;
        //   color = disabledColor;
        // } else {
        //   backgroundColor = backgroundColor ?? AppColors.get.secondary;
        //   color = color;
        // }
        return IgnorePointer(
          ignoring: isDisabled,
          child: SizedBox(
            width: width?.toW() ?? double.infinity,
            height: (height ?? 50).toH(),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: backgroundColor ?? AppColors.get.primary,
              disabledColor:
                  disabledColor ?? AppColors.get.primary.toOpacityColor(0.5),
              borderRadius: BorderRadius.circular((borderRadius ?? 15).toRad()),
              minSize: height,
              onPressed: isDisabled ? null : onPressed,
              // child: CustomText("skdjbcishdjb"),
              child: tooltip != ''
                  ? Tooltip(
                      message: tooltip,
                      child:
                          child ??
                          CustomText(
                            "$title",
                            fontSize: (titleSize ?? 18),
                            fontWeight: FW.bold,
                            color: titleColor,
                          ),
                    )
                  : child ??
                        CustomText(
                          "$title",
                          fontSize: (titleSize ?? 18),
                          fontWeight: FW.bold,
                          color: titleColor,
                        ),
            ),
          ),
        );
      },
    );
  }
}

class _IconRoundedChild extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;

  final bool isUpperCase;

  const _IconRoundedChild({
    Key? key,
    required this.label,
    required this.icon,
    this.color,
    required this.isUpperCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.defaultScreenHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              isUpperCase ? label.toUpperCase() : label,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color ?? AppColors.get.white,
                fontFamily: AppStrings.fontFamilyMontserrat,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          10.ESW(),
          Icon(icon, color: color ?? AppColors.get.white),
        ],
      ),
    );
  }
}

class _ImageRoundedChild extends StatelessWidget {
  final String label;
  final ImageProvider image;
  final Color? color;

  final bool isUpperCase;
  final double side;

  const _ImageRoundedChild({
    Key? key,
    required this.label,
    required this.image,
    this.color,
    required this.isUpperCase,
    required this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: image, width: side, height: side),
        XSpace.light,
        CustomText(
          isUpperCase ? label.toUpperCase() : label,
          textAlign: TextAlign.center,
          color: color,
          fontSize: 12,
          fontWeight: FW.medium,
          // fontWeight: FW.MEDIUM,
        ),
      ],
    );
  }
}
