import '../../../core/network_structure/data_source/service_interface.dart';
import '../../../core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/fetch_app_status_api_service.dart';
import '../../data/models/app_status_model.dart';
import '../entities/app_status_entity.dart';

class FetchAppStatusRepo extends RepoInterface<AppStatusEntity>{
  FetchAppStatusRepo._();
 static final instance =FetchAppStatusRepo._();
  @override
  // TODO: implement onParse
  AppStatusEntity Function(dynamic data) get onParse => (data){
    return AppStatusModel.fromJson(data);
  };

  @override
  // TODO: implement serviceInstance
  ServicesInterface get serviceInstance => FetchAppStatusApiService.instance;
}