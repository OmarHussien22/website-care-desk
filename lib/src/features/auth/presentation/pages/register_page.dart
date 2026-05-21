import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/decorations/app_insets.dart';
import '../../../../core/constants/strings/assets/app_icons.dart';
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
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/app_full_name_field.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.get.white,
          body: Form(
            key: controller.globalKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppbarBackground(
                          // image: AppImages.login,
                          title: "register_title".toTr(),
                          subtitle: "register_subtitle".toTr(),
                          showBackButton: true,
                        ),
                        Padding(
                          padding: AppInsets.defaultScreenHorizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFullNameField(
                                controller: controller.nameController,
                                icon: AppIcons.user,
                                withHeader: true,
                                headerTitle: "profile_full_name".toTr(),
                              ),
                              16.ESH(),
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
                              ),
                              16.ESH(),
                              AppPasswordField(
                                controller:
                                    controller.confirmPasswordController,
                                withHeader: true,
                                headerTitle: "profile_confirm_new_password"
                                    .toTr(),
                                onComplete: controller.register,
                              ),
                              16.ESH(),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      value: controller.isTermsAccepted,
                                      activeColor: AppColors.get.primary,
                                      onChanged: (value) =>
                                          controller.toggleTerms(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  8.ESW(),
                                  CustomText.subtitle(
                                    "i_agree_to".toTr(),
                                    fontSize: 14,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.termsConditions),
                                    child: CustomText.subtitle(
                                      "profile_terms_conditions".toTr(),
                                      color: AppColors.get.primary,
                                      decoration:
                                          CustomTextDecoration.underLine,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              10.ESH(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GetBuilder<RegisterController>(
                  builder: (_) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.toW()),
                      child: ButtonDefault(
                        title: "register".toTr(),
                        onPressed: controller.register,
                        backgroundColor: AppColors.get.lightPrimary,
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
                      "already_have_account".toTr(),
                      fontSize: 14,
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: CustomText.subtitle(
                        "login".toTr(),
                        color: AppColors.get.primary,
                        decoration: CustomTextDecoration.underLine,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                10.ESH(),
              ],
            ),
          ),
        );
      },
    );
  }
}
