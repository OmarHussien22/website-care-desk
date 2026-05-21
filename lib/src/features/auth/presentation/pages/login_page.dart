import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/decorations/app_insets.dart';
import '../../../../core/constants/strings/assets/app_images.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/customizable/imports_customizable.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/app_password_field.dart';
import '../../../../shared/presentation/widgets/app_bars/appbar_background.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/src/phone_form_field.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.get.white,
          body: SafeArea(
            child: Form(
              key: controller.globalKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppbarBackground(
                            image: AppImages.background,
                            title: "login_title".toTr(),
                            subtitle: "login_subtitle".toTr(),
                            showBackButton: true,
                          ),
                          Padding(
                            padding: AppInsets.defaultScreenHorizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PhoneFormField(
                                  controller: controller.phoneController,
                                  onCountryCodeChanged:
                                      controller.onCountryCodeChange,
                                  header: "phone_number".toTr(),
                                  hasCountryCode: true,
                                ),
                                16.ESH(),
                                AppPasswordField(
                                  controller: controller.passwordController,
                                  withHeader: true,
                                  headerTitle: "login_password".toTr(),
                                  onComplete: controller.login,
                                ),
                                15.ESH(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.forgotPassword);
                                      },
                                      child: CustomText.subtitle(
                                        "forget_password",
                                        fontSize: context.isTablet ? 12 : 14,
                                        fontWeight: FW.medium,
                                        color: AppColors.get.titleText,
            
                                        decoration:
                                            CustomTextDecoration.underLine,
                                        // color:AppColors.get.,
                                      ),
                                    ),
                                  ],
                                ),
                                80.ESH(),
                              ],
                            ),
                          ),
                          24.ESH(),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<LoginController>(
                    builder: (_) {
                      return Padding(
                        padding: AppInsets.defaultScreenHorizontal,
                        child: ButtonDefault(
                          title: "login".toTr(),
                          onPressed: controller.login,
                          backgroundColor: AppColors.get.primaryLighter,
                          isDisabled: controller.isButtonDisabled,
                        ),
                      );
                    },
                  ),
                  10.ESH(),
                   Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText.subtitle(
                                "dont_have_account".toTr(),
                                fontSize: 14,
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(AppRoutes.register),
                                child: CustomText.subtitle(
                                  "register".toTr(),
                                  color: AppColors.get.primary,
                                  decoration: CustomTextDecoration.underLine,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                  20.ESH(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
