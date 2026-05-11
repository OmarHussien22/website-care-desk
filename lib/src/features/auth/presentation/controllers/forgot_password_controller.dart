import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/Utils/Validation/app_validator.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../../../super/Controllers/Resources/get/get_controller_interface.dart';
import '../../core/params/forgot_password_params.dart';
import '../../domain/use_cases/forgot_password_use_case.dart';
import '../../../../core/routers/route_args.dart';
import 'phone_data_builder.dart';

class ForgotPasswordController extends GetControllerInterface<bool> {
  late TextEditingController phoneController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String countryCode = '+20';

  bool _isButtonDisabled = true;

  bool get isButtonDisabled => _isButtonDisabled;
  final _builder = PhoneDataBuilder.instance;

  void onCountryCodeChange(String value) {
    countryCode = value;
    update();
  }

  void forgotPassword() {
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        final useCase = ForgotPasswordUseCase();
        state = await useCase(
          params: ForgotPasswordParams(
            phone: phoneController.text,
            countryCode: countryCode,
          ),
        )!;

        if (state is DataSuccess) {
          _builder.phone = phoneController.text;
          _builder.countryCode = countryCode;
          _builder.forRestPassword = true;
          Get.toNamed(
            AppRoutes.verifyCode,
            arguments: VerifyCodeArgs(
              phone: phoneController.text,
              viewPhone: true,
            ),
          );
        } else {
          ClientSnacks.appStyledSnack(
            title: state.error?.title ?? "",
            state: UtilState.error,
          );
        }
      },
    );
  }

  void _checkButtonState() {
    if (phoneController.text.isNotEmpty) {
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    phoneController.addListener(_checkButtonState);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
