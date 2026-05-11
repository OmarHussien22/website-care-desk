import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../packages_index.dart';
import '../../../../core/Utils/Validation/app_validator.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/presentation/controllers/user_controller.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../../../Super/Controllers/Resources/get/get_controller_interface.dart';
import '../../core/params/set_parent_data_params.dart';
import '../../domain/use_cases/set_parent_data_use_case.dart';

class SetParentDataController extends GetControllerInterface<UserEntity> {
  late TextEditingController parentNameController;
  late TextEditingController parentPhoneController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String countryCodeParent = "+20";

  bool _isButtonDisabled = true;
  bool get isButtonDisabled => _isButtonDisabled;

  @override
  void onInit() {
    parentNameController = TextEditingController();
    parentPhoneController = TextEditingController();
    parentNameController.addListener(_checkButtonState);
    parentPhoneController.addListener(_checkButtonState);
    super.onInit();
  }

  void onCountryCodeParentChange(String value) {
    countryCodeParent = value;
    update();
  }

  Future<void> setParentData() async {
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        await _setParentDataRequest();
      },
    );
  }

  Future<void> _setParentDataRequest() async {
    final useCase = SetParentDataUseCase();
    state = await useCase(
      params: SetParentDataParams(
        countryCode: countryCodeParent,
        parentName: parentNameController.text,
        parentPhone: parentPhoneController.text,
      ),
    )!;
    if (state is DataSuccess) {
      if (state.data != null) {
        UserController.get.updateUser(state.data!);
      }
      Get.toNamed(AppRoutes.inviteCode);
    } else if (state is DataFailed) {
      ClientSnacks.appStyledSnack(
        title: state.error!.title,
        state: UtilState.error,
      );
    }
  }

  void _checkButtonState() {
    if (parentNameController.text.isNotEmpty &&
        parentPhoneController.text.isNotEmpty) {
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
    update();
  }
}
