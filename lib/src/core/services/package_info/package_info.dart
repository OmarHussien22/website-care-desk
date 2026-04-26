import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoGetter {
  PackageInfoGetter._();
  static PackageInfo? _packageInfo;

  static Future<void> init() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
  }

  static String get version => _packageInfo?.version ?? '0.0.0';

  static String get buildNumber => _packageInfo?.buildNumber ?? '0';

  static String get appName => _packageInfo?.appName ?? 'Unknown App';

  static String get packageName => _packageInfo?.packageName ?? 'Unknown Package';
}

class PackageInfoService {
  PackageInfoService._();

  static final PackageInfoService instance = PackageInfoService._();

  Future<void> init() => PackageInfoGetter.init();

  String get version => PackageInfoGetter.version;

  String get buildNumber => PackageInfoGetter.buildNumber;

  String get appName => PackageInfoGetter.appName;

  String get packageName => PackageInfoGetter.packageName;
}
