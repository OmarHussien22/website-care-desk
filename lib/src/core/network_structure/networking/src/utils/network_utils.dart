import 'package:coursaty/src/shared/presentation/widgets/general_widgets/dialogs/app_dialogs.dart';

class NetworkUtils {
  NetworkUtils._();
  static final NetworkUtils instance = NetworkUtils._();
  //<editor-fold desc="UTILS METHOD">

  void showDialog(bool status) {
    if (status) {
      AppDialogs.showLoadingDialog();
    }
  }

  void closeDialog(bool status) {
    if (status) {
      AppDialogs.closeOpenDialogs();
    }
  }

  //</editor-fold>
}
