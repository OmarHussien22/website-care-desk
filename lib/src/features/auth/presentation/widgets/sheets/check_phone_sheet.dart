import 'package:coursaty/src/Core/Constants/Decorations/app_Insets.dart';
import 'package:coursaty/src/Core/Constants/Strings/Assets/app_icons.dart';
import 'package:coursaty/src/Core/Constants/Strings/Assets/app_lottie.dart';
import 'package:coursaty/src/Core/Services/lang_service/translate_extention.dart';
import 'package:coursaty/src/Core/Styles/Colors/app_colors.dart';
import 'package:coursaty/src/Core/Utils/Extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/Shared/Presentation/Widgets/Builders/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/strings/assets/app_images.dart';
import '../../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../../shared/presentation/widgets/general_widgets/image/generic_image/generic_image.dart';
import '../../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import '../../../../../shared/presentation/widgets/loading/app_loading.dart';

class CheckPhoneSheet extends StatefulWidget {
  final String phone;
  final Future Function()? onTap;
  final bool isLoading;

  const CheckPhoneSheet({
    super.key,
    required this.phone,
    this.onTap,
    this.isLoading = false,
  });

  @override
  State<CheckPhoneSheet> createState() => _CheckPhoneSheetState();
}

class _CheckPhoneSheetState extends State<CheckPhoneSheet> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.defaultScreenALL,
      child: Container(
        width: 375.toW(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.toRad()),
          color: AppColors.get.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.toH(),
              width: 50.toW(),
              decoration: BoxDecoration(
                color: AppColors.get.black,
                borderRadius: BorderRadius.circular(10.toRad()),
              ),
            ),
            20.ESH(),
            ImageGeneric.asset(
              url: AppImages.dialogBackground,
              options: ImageOptions(height: 150.toH(), width: 150.toW()),
            ),
            20.ESH(),
            CustomText(
              widget.phone,
              fontSize: 20,
              fontWeight: FW.bold,
              color: AppColors.get.primary,
            ),
            16.ESH(),
            CustomText(
              'is_this_phone'.toTr(),
              fontSize: 16,
              fontWeight: FW.medium,
              textAlign: TextAlign.center,
              color: AppColors.get.lightText,
            ),
            40.ESH(),
            ConditionalBuilder(
              condition: isLoading,
              onBuild: const AppLoader(),
              onFeedBack: ButtonDefault(
                title: 'yes_im_sure'.toTr(),
                height: 54.toH(),
                width: double.infinity,
                backgroundColor: AppColors.get.lightPrimary,
                onPressed: () async {
                  if (widget.onTap != null) {
                    isLoading = true;
                    setState(() {});
                    await widget.onTap!();
                    isLoading = false;
                    setState(() {});
                  }
                },
              ),
            ),
            20.ESH(),
            GestureDetector(
              onTap: () => Get.back(),
              child: CustomText(
                'edit_number'.toTr(),
                fontSize: 18,
                fontWeight: FW.semiBold,
                color: AppColors.get.lightPrimary,
                decoration: CustomTextDecoration.underLine,
              ),
            ),
            20.ESH(),
          ],
        ),
      ),
    );
  }
}
