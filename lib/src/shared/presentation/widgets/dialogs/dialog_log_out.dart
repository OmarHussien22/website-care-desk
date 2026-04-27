import 'package:coursaty/src/core/constants/decorations/app_shapes.dart';
import 'package:coursaty/src/core/constants/strings/assets/app_icons.dart';
import 'package:coursaty/src/core/styles/colors/app_colors.dart';
import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/caches/user_cache.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../general_widgets/buttons/basic/custom_outlined_button.dart';
import '../general_widgets/image/generic_image/generic_image.dart';
import '../general_widgets/text/src/options/imports_text_options.dart';
import '../general_widgets/text/src/imports_text.dart';

class DialogLogOut extends StatelessWidget {
  const DialogLogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: ImageGeneric.svg(
            url: "",
            options: ImageOptions(width: 220.toW(), height: 180.toH()),
          ),
        ),
        16.ESH(),
        const CustomText('want_sign_out', fontSize: 16, fontWeight: FW.medium),
        8.ESH(),
        CustomText.subtitle('cant_back', fontSize: 12, fontWeight: FW.regular),
        24.ESH(),
        Row(
          children: [
            Expanded(
              child: ButtonDefault(
                height: 52,
                title: 'sure',
                onPressed: () {
                  // LogoutController logoutController = Get.put(
                  //   LogoutController(),
                  // );
                  // logoutController.logOut();
                },
              ),
            ),
            16.ESW(),
            Expanded(
              child: CustomOutlinedButton(
                height: 52,
                title: 'cancel',

                // borderColor: AppColors.get.primary,
                titleColor: AppColors.get.primary,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
