import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/services/utils/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import '../../general_widgets/text/src/imports_text.dart';
import '../../general_widgets/text/src/options/imports_text_options.dart';

class TabsIos extends StatelessWidget {
  final List<String> titles;

  final Function(int) onTap;
  final int tabIndex;
  final Color? activeCardColor;
  final Color? activeTitleColor;
  final Color? disActiveTitleColor;
  final Color backGroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  const TabsIos({
    super.key,
    required this.titles,
    required this.onTap,
    this.tabIndex = 0,
    this.activeCardColor,
    this.backGroundColor = Colors.white,
    this.borderColor,
    this.activeTitleColor,
    this.disActiveTitleColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 343.w,
      height: height ?? 62.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: backGroundColor,
        border: Border.all(
          width: 1,
          color: borderColor ?? AppColors.get.white,
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < titles.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onTap(i);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: tabIndex == i
                          ? activeCardColor ??
                              AppColors.get.primary.toOpacityColor(.7)
                          : Colors.transparent,
                    ),
                    height: 52.h,
                    child: Center(
                      child: CustomText(
                        titles[i],
                        color: tabIndex == i
                            ? activeTitleColor ?? AppColors.get.white
                            : disActiveTitleColor ?? AppColors.get.grey,
                        fontWeight: FW.semiBold,
                        fontSize: context.isTablet ? 9 : 13,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
