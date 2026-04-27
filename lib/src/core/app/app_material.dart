import '../constants/strings/app_strings.dart';
import '../styles/themes/imports_themes.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/lang/localization_services.dart';
import 'navigator_observer.dart';

class AppMaterial extends StatelessWidget {
  final Widget home;

  const AppMaterial({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [MyRouteObserver()],
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      // scaffoldMessengerKey: Snap.messengerKey,
      // onGenerateRoute: RouterGenerator().goRoutes,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 200),
      translations: LocalizationServices.instance,
      locale: Utils.cachedLocale,
      title: AppStrings.appName,
      theme: ThemeManager.light,
      home: home,
    );
  }
}
