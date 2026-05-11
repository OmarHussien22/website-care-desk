import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../core/constants/strings/assets/app_images.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/services/utils/extensions/color_extension.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../general_widgets/image/generic_image/generic_image.dart';
import '../general_widgets/text/custom_text_lib.dart';

class AppbarBackground extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final String? image;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Widget? trailing;

  const AppbarBackground({
    super.key,
    this.title,
    this.subtitle,
    this.subtitleWidget,
    this.image,
    this.showBackButton = true,
    this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.appBarBackground),
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          60.ESH(), // Status bar + some space
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toW()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBackButton)
                  GestureDetector(
                    onTap: onBack ?? () => Get.back(),
                    child: Container(
                      width: 36.toRad(),
                      height: 36.toRad(),
                      decoration: BoxDecoration(
                        color: AppColors.get.white,
                        border: Border.all(color: AppColors.get.darkGrey),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.get.darkGrey,
                        size: 24,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                if (trailing != null) trailing! else const SizedBox.shrink(),
              ],
            ),
          ),
          if (image != null) ...[
            20.ESH(),
            ImageGeneric.asset(
              url: image!,
              options: ImageOptions(height: 140.toH(), fit: BoxFit.contain),
            ),
          ],
          if (title != null) ...[
            20.ESH(),
            CustomText(
              title?.toTr() ?? "",
              fontSize: 24,
              fontWeight: FW.bold,
              color: AppColors.get.black,
              textAlign: TextAlign.center,
            ),
          ],
          if (subtitleWidget != null || subtitle != null) ...[
            10.ESH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.toW()),
              child:
                  subtitleWidget ??
                  CustomText(
                    subtitle!.toTr(),
                    fontSize: 15,
                    fontWeight: FW.semiBold,
                    color: AppColors.get.titleText,
                    textAlign: TextAlign.center,
                  ),
            ),
          ],
          32.ESH(),
        ],
      ),
    );
  }
}
