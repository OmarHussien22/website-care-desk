import 'package:get/get.dart';
import '../../shared/managers/check_network_controller.dart';
import '../../shared/managers/user_controller.dart';

class AppDataBinding {
  AppDataBinding._();
  factory AppDataBinding() => _instance;
  static final AppDataBinding _instance = AppDataBinding._();

  void init() {
    Get.lazyPut(() => CheckNetworkController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
