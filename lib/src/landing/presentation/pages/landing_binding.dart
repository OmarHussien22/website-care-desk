import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/presentation/controllers/nav_bar_controller.dart';
import 'package:get/get.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingScrollController>(LandingScrollController.new);
    Get.lazyPut<NavBarController>(NavBarController.new);
  }
}
