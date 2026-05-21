import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/decorations/app_insets.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/route_args.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../shared/presentation/widgets/app_bars/appbar_background.dart';
import '../../../../shared/presentation/widgets/builders/conditional_builder.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/otp/otp_text_field.dart';
import '../../../../shared/presentation/widgets/loading/app_loading.dart';
import '../../../../core/utils/extensions/string_extension.dart';
import '../../../../core/services/upgrade/pin_code_service.dart';
import '../controllers/check_verification_code_controller.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key, required this.args});

  final VerifyCodeArgs args;

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(CheckVerificationCodeController());

    return Scaffold(
      backgroundColor: AppColors.get.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppbarBackground(
              title: 'verify_your_phone_title',
              showBackButton: true,
              subtitleWidget: ConditionalBuilder(
                condition: args.viewPhone,
                onBuild: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'enter_code_first_subtitle'.toTr(),
                    style: TextStyle(
                      color: AppColors.get.titleText,
                      fontSize: 16.toFS(),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: '${args.phone}  ',
                        style: TextStyle(
                          color: AppColors.get.lightPrimary,
                          fontSize: 14.toFS(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: 'enter_code_second_subtitle'.toTr()),
                    ],
                  ),
                ),
                onFeedBack: CustomText(
                  'verify_your_phone_sub_title'.toTr(),
                  fontSize: 16,
                  fontWeight: FW.medium,
                  color: AppColors.get.lightText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: AppInsets.defaultScreenALL,
              child: Form(
                key: controller.globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PinCodeServices.pinCodeWidget(
                    //   context: context,
                    //   textEditingController: controller.codeController!,
                    //   errorController: controller.errorController!,
                    // ),
                    64.ESH(),
                    ButtonDefault(
                      height: context.isTablet ? 35 : 56,
                      width: double.infinity,
                      title: "send_code".toTr(),
                      backgroundColor: AppColors.get.primaryLighter,
                      onPressed: () {
                        controller.checkVerificationCode();
                      },
                    ),
                    12.ESH(),
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.resendCode;
                            },
                            child: CustomText(
                              'resend_code',
                              fontSize: 14,
                              fontWeight: FW.medium,
                              color: AppColors.get.primaryLighter,
                            ),
                          ),
                          GetBuilder<CheckVerificationCodeController>(
                            builder: (controller) => GestureDetector(
                              onTap: () {
                                controller.startTimer();
                              },
                              child: CustomText(
                                color: AppColors.get.lightText,
                                controller.countDown > 0
                                    ? '(00 : ${controller.countDown} )'
                                    : '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
