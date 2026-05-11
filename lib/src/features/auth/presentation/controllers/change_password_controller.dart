import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routers/app_routes.dart';
import '../../../../core/services/lang_service/translate_extention.dart';
import '../../../../core/utils/validation/app_validator.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../../../super/controllers/resources/get/get_controller_interface.dart';
import '../../core/params/change_password_params.dart';
import '../../domain/use_cases/change_password_use_case.dart';

class ChangePasswordController extends GetControllerInterface<bool> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool _isButtonDisabled = true;

  bool get isButtonDisabled => _isButtonDisabled;

  void changePassword() {
    if (newPasswordController.text == oldPasswordController.text) {
      ClientSnacks.requestError(error: "validate_password_same_as_old".toTr());

      return;
    }
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        _changePasswordRequest();
      },
    );
  }

  Future<void> _changePasswordRequest() async {
    final ChangePasswordUseCase useCase = ChangePasswordUseCase();
    state = await useCase(
      params: ChangePasswordParams(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      ),
    )!;
    if (state.data ?? false) {
      Get.offAllNamed(AppRoutes.login);

      ClientSnacks.appStyledSnack(
        title: 'success_password'.toTr(),
        state: UtilState.success,
      );
    } else {
      ClientSnacks.appStyledSnack(
        title: state.error?.title ?? 'حدث خطا ما',
        state: UtilState.error,
      );
    }
  }

  void _checkButtonState() {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      _isButtonDisabled = false;
      update();
    } else {
      _isButtonDisabled = true;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    confirmPasswordController = TextEditingController();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    oldPasswordController.addListener(() {
      _checkButtonState();
    });
    newPasswordController.addListener(() {
      _checkButtonState();
    });
    confirmPasswordController.addListener(() {
      _checkButtonState();
    });
  }

  @override
  void onClose() {
    super.onClose();
    confirmPasswordController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
  }
}
