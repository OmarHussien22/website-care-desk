import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/decorations/app_insets.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../core/utils/validation/implementation/password_validator/confirm_password_validator.dart';
import '../../../../shared/presentation/widgets/app_bars/appbar_background.dart';
import '../../../../shared/presentation/widgets/builders/conditional_builder.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/app_password_field.dart';
import '../../../../shared/presentation/widgets/loading/app_loading.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.get.white,
          body: SingleChildScrollView(
            child: Form(
              key: controller.globalKey,
              child: Column(
                children: [
                  AppbarBackground(
                    title: "reset_password".toTr(),
                    subtitle: "reset_password_sub".toTr(),
                    showBackButton: true,
                  ),
                  Padding(
                    padding: AppInsets.defaultScreenHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        40.ESH(),
                        AppPasswordField(
                          controller: controller.passwordController,
                          headerTitle: "enter_new_password".toTr(),
                          hint: "enter_new_password".toTr(),
                          isRequired: true,
                          withHeader: true,
                        ),
                        24.ESH(),
                        AppPasswordField(
                          controller: controller.confirmPasswordController,
                          headerTitle: "confirm_password".toTr(),
                          hint: "re_enter_new_password".toTr(),
                          isRequired: true,
                          withHeader: true,
                          validation: (value) {
                            return ConfirmPasswordValidator.instance.validate(
                              value,
                              {"password": controller.passwordController.text},
                            );
                          },
                        ),
                        270.ESH(),
                        ButtonDefault(
                          title: "save".toTr(),
                          backgroundColor: AppColors.get.lightPrimary,
                          onPressed: () {
                            controller.resetPassword();
                          },
                          height: 54.toH(),
                          isDisabled: controller.isDisabled,
                        ),
                        40.ESH(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
