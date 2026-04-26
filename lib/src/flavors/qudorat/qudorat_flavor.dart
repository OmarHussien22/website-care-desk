import 'package:coursaty/src/flavors/interface_flavor.dart';
import 'package:coursaty/src/flavors/qudorat/firebase/qudorat_firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class QudoratFlavor extends InterfaceFlavor {
  @override
  String get appName => 'Qudorat';

  @override
  String get flavorName => 'qudorat';

  @override
  String get appIcon => "assets/flavors/$flavorName/app_icon.png";

  @override
  String get appSplashImage => "assets/flavors/$flavorName/splash_image.png";

  @override
  String get upgradeImage => "assets/flavors/$flavorName/upgrade.png";

  @override
  String get splashPattern => "assets/flavors/$flavorName/splash_pattern.png";

  @override
  Color get primaryColor => const Color(0xff118A38);

  @override
  Color get secondaryColor => const Color(0xff25387A);

  @override
   String get apiUrlProd => "https://sysgenius-sa.com/api/";
 
  // String get apiUrlProd => "https://kodrat.techlabeg.com/api/";
  // String get apiUrlProd => "https://edu.techlabeg.com/api/";

  @override
  String get apiUrlDev => "https://edu.techlabeg.com/api/";

  @override
  // String get apiKey => r'$2y$10$19f6XHO0YBEn/cTdq/ocFOYD7FZP7Ub8qa/9.V3vdzDCgiZa3/xqO'; // techlab dev
  String get apiKey =>
      r'$2y$10$We4aB6Jb/a.JQFVtXRXShuX20UUrX6/KYcNY59do9TWwg3qoVwS3q'; // qudorat prod

  @override
  FirebaseOptions? get firebaseOptions =>
      QudoratFirebaseOptions.currentPlatform;

  @override
  bool get qudoratSplash => true;
}
