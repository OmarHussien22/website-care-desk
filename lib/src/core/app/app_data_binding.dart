import 'package:get/get.dart';
import '../../shared/presentation/controllers/check_network_controller.dart';
import '../../shared/presentation/controllers/user_controller.dart';

class AppDataBinding {
  AppDataBinding._();
  factory AppDataBinding() => _instance;
  static final AppDataBinding _instance = AppDataBinding._();

  void init() {
    Get.lazyPut(() => CheckNetworkController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
