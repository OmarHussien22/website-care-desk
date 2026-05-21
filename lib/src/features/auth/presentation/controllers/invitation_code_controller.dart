import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network_structure/entities/entity.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../../../Super/Controllers/Resources/get/get_controller_interface.dart';
import '../../domain/params/check_invitation_code_params.dart';
import '../../domain/use_cases/check_invitation_code_use_case.dart';

class InvitationCodeController extends GetControllerInterface<void> {
  late TextEditingController invitationCodeController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool _isButtonDisabled = true;
  bool get isButtonDisabled => _isButtonDisabled;

  @override
  void onInit() {
    invitationCodeController = TextEditingController();
    invitationCodeController.addListener(_checkButtonState);
    super.onInit();
  }

  void _checkButtonState() {
    _isButtonDisabled = invitationCodeController.text.isEmpty;
    update();
  }

  Future<void> checkInvitationCode() async {
    if (globalKey.currentState?.validate() ?? false) {
      await _checkInvitationCodeRequest();
    }
  }

  Future<void> _checkInvitationCodeRequest() async {
    final useCase = CheckInvitationCodeUseCase();
    final result = await useCase(
      params: CheckInvitationCodeParams(
        invitationCode: invitationCodeController.text,
      ),
    );

    if (result != null) {
      state = result;
      if (state is DataSuccess) {
        // Handle success (e.g., navigate to home or next step)
        ClientSnacks.appStyledSnack(
          title: state.message ?? "",
          state: UtilState.success,
        );
         Get.offAllNamed(AppRoutes.profile);
      } else if (state is DataFailed) {
        ClientSnacks.appStyledSnack(
          title: state.error!.title,
          state: UtilState.error,
        );
      }
    }
  }

  @override
  void onClose() {
    invitationCodeController.dispose();
    super.onClose();
  }
}
