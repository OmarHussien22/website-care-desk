import '../../../../packages_index.dart';
import '../../../core/utils/general_utils.dart';
import 'fetch_app_status_controller.dart';
import 'dart:io';

class AppStatusSettings {
  AppStatusSettings._();

  static final instance = AppStatusSettings._();
  final FetchAppStatusController _controller =
      Get.find<FetchAppStatusController>();

  bool showPrice() {
    try {
      if (Platform.isIOS) {
        if (_controller.state.data?.iosStatus ?? false) {
          return _controller.state.data?.showPrice ?? false;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      printDM("error in app status setting $e");
      return false;
    }
  }

  bool showLoginAsVisitor() {
    try {
      if (Platform.isIOS) {
        return _controller.state.data?.isVisitor ?? false;
      } else {
        return false;
      }
    } catch (e) {
      printDM("error in app status setting $e");
      return false;
    }
  }
}
