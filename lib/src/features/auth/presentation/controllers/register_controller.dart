import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/Utils/Validation/app_validator.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/services/device_info/device_info_service.dart';
import '../../../../core/services/lang/translate_extention.dart';
import '../../../../core/services/storage/src/storage_constants.dart';
import '../../../../core/services/storage/storage_service.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/presentation/controllers/user_controller.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../../../Super/Controllers/Resources/get/get_controller_interface.dart';
import '../../core/params/register_params.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../../../core/routers/route_args.dart';
import 'phone_data_builder.dart';

class RegisterController extends GetControllerInterface<UserEntity> {
  late TextEditingController phoneController;
  late TextEditingController parentPhoneController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController parentNameController;
  late TextEditingController confirmPasswordController;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final StorageService<int> _box = StorageService<int>();

  String countryCode = '+20';
  String countryCodeParent = '+20';

  bool isTermsAccepted = false;

  bool _isButtonDisabled = true;
  bool get isButtonDisabled => _isButtonDisabled;

  @override
  void onInit() {
    phoneController = TextEditingController();
    parentPhoneController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    parentNameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController.addListener(_checkButtonState);
    passwordController.addListener(_checkButtonState);
    nameController.addListener(_checkButtonState);
    confirmPasswordController.addListener(_checkButtonState);
    isTermsAccepted = false;
    super.onInit();
  }

  void onCountryCodeChange(String value) {
    countryCode = value;
    update();
  }

  void onCountryCodeParentChange(String value) {
    countryCodeParent = value;
    update();
  }

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    _checkButtonState();
    update();
  }

  Future<void> register() async {
    if (!isTermsAccepted) {
      ClientSnacks.appStyledSnack(
        title: 'must_agree'.toTr(),
        state: UtilState.error,
      );
      return;
    }
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        await _registerRequest();
      },
    );
  }

  Future<void> _registerRequest() async {
    final useCase = RegisterUseCase();
    state = await useCase(
      params: RegisterParams(
        phone: phoneController.text,
        countryCode: countryCode,
        password: passwordController.text,
        name: nameController.text,
        parentName: parentNameController.text,
        parentPhone: parentPhoneController.text,
        deviceId: await DeviceInfoService.instance.getDeviceId(),
        // TODO: add device token
        deviceToken: null,
      ),
    )!;

    if (state is DataSuccess) {
      _onRegisterSuccess();
    } else if (state is DataFailed) {
      ClientSnacks.appStyledSnack(
        title: state.error!.title,
        state: UtilState.error,
      );
    }
  }

  void _onRegisterSuccess() {
    if (state.data != null) {
      UserController.get.updateUser(state.data!);
    }
    _box.save(stgBNBIndex, value: 0);

    ClientSnacks.appStyledSnack(
      title: 'snack_register_success'.toTr(),
      state: UtilState.success,
    );

    PhoneDataBuilder.instance.phone = phoneController.text;
    PhoneDataBuilder.instance.countryCode = countryCode;
    PhoneDataBuilder.instance.forRestPassword = false;
    Get.toNamed(
      AppRoutes.verifyCode,
      arguments: VerifyCodeArgs(phone: phoneController.text, viewPhone: true),
    );
  }

  void _checkButtonState() {
    if (phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        isTermsAccepted
        ) {
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
    update();
  }
}
