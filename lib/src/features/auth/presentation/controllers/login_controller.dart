import 'package:flutter/material.dart';

import '../../../../../packages_index.dart';
import '../../../../core/Utils/Validation/app_validator.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/services/device_info/device_info_service.dart';
import '../../../../core/services/storage/src/storage_constants.dart';
import '../../../../core/services/storage/storage_service.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../Super/Controllers/Resources/get/get_controller_interface.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/presentation/controllers/user_controller.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../core/params/login_params.dart';
import '../../domain/use_cases/login_use_case.dart';

class LoginController extends GetControllerInterface<UserEntity> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final StorageService<int> _box = StorageService<int>();

  String countryCode = "+20";

  bool _isButtonDisabled = true;

  bool get isButtonDisabled => _isButtonDisabled;

  @override
  void onInit() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    phoneController.addListener(_checkButtonState);
    passwordController.addListener(_checkButtonState);
    super.onInit();
  }

  void onCountryCodeChange(String value) {
    countryCode = value;
    update();
  }

  Future<void> login() async {
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        await _loginRequest();
      },
    );
  }

  Future<void> _loginRequest() async {
    final useCase = LoginUseCase();
    state = await useCase(
      params: LoginParams(
        phone: phoneController.text,
        password: passwordController.text,
        countryCode: countryCode,
        deviceId: await DeviceInfoService.instance.getDeviceId(),
        // TODO: add device token
        deviceToken: "await FCMService.deviceToken",
      ),
    )!;
    if (state is DataSuccess) {
      _cacheUser();
      Get.offAllNamed(AppRoutes.profile);
    } else if (state is DataFailed) {
      ClientSnacks.appStyledSnack(
        title: state.error!.title,
        state: UtilState.error,
      );
    }
  }

  void _cacheUser() {
    if (state.data != null) {
      UserController.get.updateUser(state.data!);
    }
    _box.save(stgBNBIndex, value: 0);
  }

  void _checkButtonState() {
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
    update();
  }
}
