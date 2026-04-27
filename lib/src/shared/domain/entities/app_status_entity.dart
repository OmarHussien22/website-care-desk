
import '../../../core/network_structure/entities/entity.dart';

class AppStatusEntity extends Entity {
  AppStatus? status;
  int? androidVersion;
  int? iosVersion;
  List<AppLanguage>? appLanguages;
  String? androidUrl;
  String? iosUrl;

  bool? isVisitor;
  bool? iosStatus;
  bool? showPrice;

  AppStatusEntity({
    this.status,
    this.androidVersion,
    this.iosVersion,
    this.androidUrl,
    this.iosUrl,
    this.appLanguages,
    this.isVisitor,
    this.iosStatus,
    this.showPrice,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        androidVersion,
        iosVersion,
        androidUrl,
        iosUrl,
    isVisitor,
    iosStatus,
    showPrice,
      ];

  @override
  // TODO: implement example
  List<AppStatusEntity> get example => [
        AppStatusEntity(
          status: AppStatus.active,
          androidVersion: 1,
          iosVersion: 1,
          androidUrl: "https://example.com/android",
          iosUrl: "https://example.com/ios",
          appLanguages: [],
          isVisitor:false,
          showPrice:false,
          iosStatus:false,
        ),
      ];
}

enum AppStatus {
  active,
  inactive,
  upgrade;

  static AppStatus fromInt(int status) {
    switch (status) {
      case 1:
        return AppStatus.active;
      case 2:
        return AppStatus.inactive;
      case 3:
        return AppStatus.upgrade;
      default:
        return AppStatus.active;
    }
  }
}

enum AppLanguage {
  arabic,
  none,
  english;

  static AppLanguage fromInt(int status) {
    switch (status) {
      case 1:
        return AppLanguage.english;
      case 2:
        return AppLanguage.arabic;
      default:
        return AppLanguage.none;
    }
  }

  static int toInt(AppLanguage status) {
    switch (status) {
      case AppLanguage.arabic:
        return 1;
      case AppLanguage.english:
        return 2;
      default:
        return 0;
    }
  }
}
