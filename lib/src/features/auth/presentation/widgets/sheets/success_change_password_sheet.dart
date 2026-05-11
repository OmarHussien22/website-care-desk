import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/decorations/app_insets.dart';
import '../../../../../core/constants/strings/assets/app_images.dart';
import '../../../../../core/constants/strings/assets/app_lottie.dart';
import '../../../../../core/routers/app_routes.dart';
import '../../../../../core/services/lang/translate_extention.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../../shared/presentation/widgets/general_widgets/image/generic_image/generic_image.dart';
import '../../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';

class SuccessChangePasswordSheet extends StatelessWidget {
  const SuccessChangePasswordSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.defaultScreenALL,
      decoration: BoxDecoration(
        color: AppColors.get.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.ESH(),
          ImageGeneric.asset(
            url: AppImages.schudaledTrip,
            options: ImageOptions(
              fit: BoxFit.fill,
              height: 150.toH(),
              width: 150.toW(),
            ),
          ),
          24.ESH(),
          CustomText(
            "success_password".toTr(),
            fontSize: 20,
            fontWeight: FW.bold,
            textAlign: TextAlign.center,
            color: AppColors.get.lightPrimary,
          ),
          12.ESH(),
          CustomText(
            "success_password_sub".toTr(),
            fontSize: 16,
            fontWeight: FW.medium,
            color: AppColors.get.lightText,
            textAlign: TextAlign.center,
          ),
          40.ESH(),
          ButtonDefault(
            title: "back_to_login".toTr(),
            backgroundColor: AppColors.get.lightPrimary,
            onPressed: () {
              Get.offAllNamed(AppRoutes.login);
            },
            height: 54.toH(),
            width: double.infinity,
          ),
          24.ESH(),
        ],
      ),
    );
  }
}
