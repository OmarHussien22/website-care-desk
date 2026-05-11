import 'package:get/get.dart';

import '../../../../Core/services/lang_service/translate_extention.dart';
import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../core/utils/snack_utils/snack_utils.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';
import '../../../../super/controllers/resources/get/get_controller_interface.dart';
import '../../core/params/resend_verification_code_params.dart';
import '../../domain/use_cases/resend_verification_code_use_case.dart';
import 'phone_data_builder.dart';

class ResendVerificationCodeController extends GetControllerInterface<bool> {
  final _builder = PhoneDataBuilder.instance;

  void resendCode({void Function()? onSuccess}) async {
    final useCase = ResendVerificationCodeUseCase();
    state = await useCase(
      params: ResendVerificationCodeParams(
        phone: _builder.phone,
        countryCode: _builder.countryCode,
      ),
    )!;

    if (state is DataSuccess) {
      ClientSnacks.appStyledSnack(
        title: "code_resend_successfully".toTr(),
        state: UtilState.success,
      );
      onSuccess?.call();
    } else {
      ClientSnacks.appStyledSnack(
        title: state.error?.title ?? "",
        state: UtilState.error,
      );
    }
  }
}
