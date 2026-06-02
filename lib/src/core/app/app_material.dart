import '../constants/strings/app_strings.dart';
import '../routers/app_routes.dart';
import '../routers/app_router.dart';
import '../styles/themes/imports_themes.dart';
import '../utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/lang/localization_services.dart';
import 'navigator_observer.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [MyRouteObserver()],
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 200),
      translations: LocalizationServices.instance,
      locale: Utils.cachedLocale,
      title: AppStrings.appName,
      theme: ThemeManager.light,
      getPages: AppRouter.pages,
      initialRoute: kIsWeb ? AppRoutes.landingRoot : AppRoutes.landing,
    );
  }
}
