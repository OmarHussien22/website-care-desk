
import '../../../../flavors/flavor_holder.dart';

class AppBasicIcons {
  AppBasicIcons._();
  static final String  appIcon = FlavorHolder.instance.flavor.appIcon;
  static final String  splashLogo = FlavorHolder.instance.flavor.appSplashImage;
  static final String  splashPattern = FlavorHolder.instance.flavor.splashPattern;
  static final String  upgradeImage = FlavorHolder.instance.flavor.upgradeImage;

  static  final String  logo = FlavorHolder.instance.flavor.appIcon;
  static  final String  footerSplashImage = "assets/flavors/qudorat/footer_splash_image.png";

  // static const String splashLogo = 'assets/app_icons/splash_logo.png';
  // static const String splashLogo = 'assets/app_icons/logo_primary.png';
 
}
