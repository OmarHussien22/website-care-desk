import 'package:get/get.dart';

mixin SnackBarBehaviour {
  void closeAllSnacks() => Get.closeAllSnackbars();
  void closeCurrentSnack() => Get.back();
  bool get isShown => Get.isSnackbarOpen;
}
