import 'package:coursaty/src/core/app/meddesk_config.dart';
import 'package:coursaty/src/core/routers/app_routes.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

abstract final class MedDeskActions {
  static void openRegistration() => Get.toNamed(AppRoutes.register);

  static Future<void> openClinicLogin() async {
    final uri = Uri.parse(MedDeskConfig.clinicLoginUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static void scrollTo(String sectionId) {
    if (Get.isRegistered<LandingScrollController>()) {
      Get.find<LandingScrollController>().scrollTo(sectionId);
    }
  }
}
