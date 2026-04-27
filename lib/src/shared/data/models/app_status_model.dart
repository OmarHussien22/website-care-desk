import '../../../core/utils/general_utils.dart';
import '../../domain/entities/app_status_entity.dart';

class AppStatusModel extends AppStatusEntity {
  AppStatusModel({
    super.status,
    super.androidVersion,
    super.iosVersion,
    super.androidUrl,
    super.iosUrl,
    super.appLanguages,
    super.isVisitor,
    super.iosStatus,
    super.showPrice,
  });

  AppStatusModel.fromJson(Map<String, dynamic> json) {
    printDM(
        "======================================= AppStatusModel ===============================");
    status = AppStatus.fromInt(json["status"] ?? 0);
    printDM("AppStatusModel  status $status");
    isVisitor = json["is_visitor"] ?? false;
    printDM("AppStatusModel  is_visitor $isVisitor");
    iosStatus = json["ios_new_status"] ?? false;
    // iosStatus = json["ios_old_status"] ?? false;
    printDM("AppStatusModel  iosStatus $iosStatus");
    showPrice = json["show_price"] ?? false;
    printDM("AppStatusModel  show_price $showPrice");
  }
}
