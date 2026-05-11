import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Super/Controllers/Resources/get/get_controller_interface.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../core/utils/validation/app_validator.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../core/params/reset_password_params.dart';
import '../../domain/use_cases/reset_password_use_case.dart';
import '../../../../shared/presentation/widgets/general_widgets/sheets/app_sheet.dart';
import '../widgets/sheets/success_change_password_sheet.dart';
import 'phone_data_builder.dart';

class ResetPasswordController extends GetControllerInterface<UserEntity> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool _isDisabled = true;

  final _builder = PhoneDataBuilder.instance;

  bool get isDisabled => _isDisabled;

  @override
  void onInit() {
    super.onInit();
    confirmPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController.addListener(checkButtonState);
    passwordController.addListener(checkButtonState);
  }

  void checkButtonState() {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _isDisabled = true;
    } else {
      _isDisabled = false;
    }
    update();
  }

  void resetPassword() {
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        _resetPasswordRequest();
      },
    );
  }

  Future<void> _resetPasswordRequest() async {
    final ResetPasswordUseCase useCase = ResetPasswordUseCase();
    state = await useCase(
      params: ResetPasswordParams(
        password: passwordController.text,
        phone: _builder.phone,
        countryCode: _builder.countryCode,
        verificationCode: _builder.verificationCode,
      ),
    )!;
    if (state is DataSuccess) {
      AppSheets.get.showBottomSheet(
        const SuccessChangePasswordSheet(),
        isDismissible: false,
      );
    } else if (state is DataFailed) {
      ClientSnacks.appStyledSnack(
        title: state.error?.title ?? "",
        state: UtilState.error,
      );
    }
  }
}
