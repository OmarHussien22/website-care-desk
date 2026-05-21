import 'package:get/get_core/src/get_main.dart';

import '../../../../../packages_index.dart';
import '../../../../core/routers/app_routes.dart';
import '../../../../core/services/utils/general_utils.dart';
import '../../../../shared/presentation/widgets/general_widgets/snackbar/client_snacks.dart';

class PhoneDataBuilder {
  PhoneDataBuilder._();

  static PhoneDataBuilder instance = PhoneDataBuilder._();

  String phone = "";
  String countryCode = "";
  String verificationCode = "";
  bool forRestPassword = false;

  void handleVerificationRoute() {
    if (forRestPassword) {
      printDM("forRestPassword1: $forRestPassword");
      Get.offNamed(AppRoutes.resetPassword);
    } else {
      printDM("forRestPassword2: $forRestPassword");
      Get.offAllNamed(AppRoutes.setEducationInfo);
    }
  }
}
