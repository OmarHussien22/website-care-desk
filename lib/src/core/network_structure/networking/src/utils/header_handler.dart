

import '../../../../../shared/caches/user_cache.dart';
import '../../../../../shared/presentation/controllers/user_controller.dart';
import '../../../../constants/strings/app_strings.dart';
import '../../../../utils/general_utils.dart';
import '../../../../utils/utils.dart';

class HeaderHandler {
  HeaderHandler._();


  static HeaderHandler instance = HeaderHandler._();

  /// set header
  Map<String, String> setHeaders(bool isAuth) {
    String token = "";
    if (isAuth) {
      token = UserController.get.user?.apiToken ?? "";
      // token = "76|XVeopbKXvNk9Dtc6apwAvMmMmi4Ca4WxHL1d0DKI846991dd";
      printDM("token => $token");
      // // UserCache.instance.data.then((value) {
      // //   if (value != null) {
      // //     token = value.apiToken ?? '';
      // //   }
      // // }
      // // );
      // final user = UserCache.instance.data;
      // token = user?.apiToken ?? "";
    }

    return {
      'Accept-Language': Utils.cachedLocale.languageCode,
      'android_version': AppStrings.androidVersion.toString(),
      'ios_version': AppStrings.iOSVersion.toString(),
      'Accept': 'application/json',
      if (isAuth && (token != "")) 'Authorization': 'Bearer $token',
      if (UserCache.instance.data != null) "userId": "${UserCache.instance.data?.id}",
    };
  }

}
