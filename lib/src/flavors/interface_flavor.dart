import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

abstract class InterfaceFlavor {
  String get appName;
  String get flavorName;
  String get appIcon;
  String get appSplashImage;
  String get upgradeImage;
  String get splashPattern;
  Color get primaryColor;
  Color get secondaryColor;
  String get apiUrlDev;
  String get apiUrlProd;
  String get apiKey;
  FirebaseOptions? get firebaseOptions => null;
  bool get qudoratSplash => false;
}
