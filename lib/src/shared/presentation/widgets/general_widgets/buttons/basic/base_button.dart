import '../../../../../../core/constants/decorations/app_sizes.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { withBorder, withOutBorder }

class BaseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double height;
  final double width;
  final Color? borderColor;
  final double radius;
  final Widget? child;
  final Color? buttonColor;

  const BaseButton({
    Key? key,
    this.borderColor,
    this.child,
    this.radius = AppSizes.radius,
    this.buttonColor,
    this.onTap,
    this.height = 55,
    this.width = 343,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            debugPrint('hello this tap in button');
          },
      child: Container(
        height: height.toH(),
        width: width.toW(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderColor != null ? 1 : 0),
          color: buttonColor ?? AppColors.get.primary,
        ),
        child: child ?? const Center(),
      ),
    );
  }
}
