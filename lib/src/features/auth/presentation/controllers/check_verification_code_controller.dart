import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Super/Controllers/Resources/get/get_controller_interface.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../core/utils/validation/app_validator.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../core/params/check_verification_code_params.dart';
import '../../domain/use_cases/check_verification_code_use_case.dart';
import 'phone_data_builder.dart';
import 'resend_verification_code_controller.dart';

class CheckVerificationCodeController
    extends GetControllerInterface<UserEntity> {
  TextEditingController? codeController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Timer _timer;
  int countDown = 29;

  final _builder = PhoneDataBuilder.instance;

  void checkVerificationCode() {
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        final useCase = CheckVerificationCodeUseCase();
        state = await useCase(
          params: CheckVerificationCodeParams(
            phone: _builder.phone,
            countryCode: _builder.countryCode,
            verificationCode: codeController!.text,
          ),
        )!;
        if (state is DataSuccess) {
          ClientSnacks.appStyledSnack(
            title: "right_code".toTr(),
            state: UtilState.success,
          );

          _builder.handleVerificationRoute();
        } else {
          ClientSnacks.appStyledSnack(
            title: state.error?.title ?? "",
            state: UtilState.error,
          );
        }
      },
    );
  }

  void startTimer() {
    countDown = 29;
    update();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown == 0) {
        timer.cancel();
        update();
      } else {
        countDown--;
        update();
      }
    });
  }

  void resendCode() {
    if (countDown <= 0) {
      Get.put(ResendVerificationCodeController()).resendCode(
        onSuccess: () {
          startTimer();
        },
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    codeController = TextEditingController();
    startTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    // codeController?.dispose();
    // errorController?.close();
    super.dispose();
  }
}
