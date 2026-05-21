import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/decorations/app_insets.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../shared/presentation/widgets/app_bars/appbar_background.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/customizable/imports_customizable.dart';
import '../../../../shared/presentation/widgets/general_widgets/sheets/app_sheet.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/src/phone_form_field.dart';
import '../controllers/forgot_password_controller.dart';
import '../widgets/sheets/check_phone_sheet.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.get.white,
          body: SingleChildScrollView(
            child: Form(
              key: controller.globalKey,
              child: Column(
                children: [
                  AppbarBackground(
                    title: "forget_password".toTr(),
                    subtitle: "forgot_password_sub".toTr(),
                    showBackButton: true,
                  ),
                  Padding(
                    padding: AppInsets.defaultScreenHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ESH(),
                        PhoneFormField(
                          controller: controller.phoneController,
                          onCountryCodeChanged: controller.onCountryCodeChange,
                          header: "phone_number".toTr(),
                          onComplete: controller.forgotPassword,
                          hasCountryCode: true,
                        ),
                        100.ESH(),
                        ButtonDefault(
                          title: "send_code".toTr(),
                          backgroundColor: AppColors.get.primary,
                          onPressed: () {

                            AppSheets.get.showBottomSheet(
                              CheckPhoneSheet(
                                onTap: () async {
                                  controller.forgotPassword();
                                },
                                isLoading: controller.state is DataLoading,
                                phone: controller.phoneController.text,
                              ),
                            );
                          },
                          height: 54.toH(),
                          isDisabled: controller.isButtonDisabled,
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
