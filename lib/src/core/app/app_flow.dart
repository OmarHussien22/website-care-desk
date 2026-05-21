import 'package:coursaty/src/core/services/storage/storage_service.dart';
import 'package:coursaty/src/core/services/storage/src/storage_constants.dart';
import 'package:get/get.dart';

import '../../../packages_index.dart';
import '../../shared/caches/user_cache.dart';
import '../../shared/presentation/controllers/user_controller.dart';
import '../constants/enums/app_source.dart';
import '../utils/general_utils.dart';

class AppFlow {
  AppFlow._();
  static final AppFlow instance = AppFlow._();
  static AppSource get currentSource => AppSource.prod;

  final StorageService _storageService = StorageService();
  void controlFlow() {
    if (currentSource == AppSource.prod) {
      _prodFlow();
    } else {
      _devFlow();
    }
  }

  /// [controlFlow] manipulates the return Screen  ( Called before the app runs or in Splash Screen )
  ///

  Future<void> _prodFlow() async {
    final isOnBoardingDone =
        _storageService.read(stgOnBoarding, defaultValue: false) ?? false;
    final isLoggedIn =
        _storageService.read("login", defaultValue: false) ?? false;
    printDM("isLoggedIn: $isLoggedIn");
    final isVisitor = UserCache().isVisitor();
    var user = UserController.get.user;
    printDM("user in app flow ${user?.toJson()}");
    // if (isOnBoardingDone) {
    if (isLoggedIn || isVisitor) {
      // if (user.isVerify ?? false) {

      // Get.offAll(() => const BasePage());

      // }
    } else {
      // Get.offAll(const LoginPage());
    }
    // }
    // else {
    //   Get.offAll(const LoginPage());
    // }
  }

  void _devFlow() {
    // Get.offAll(() => const OnBoardingPage());
  }
}
