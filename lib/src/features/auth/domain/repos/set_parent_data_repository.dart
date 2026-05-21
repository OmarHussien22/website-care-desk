import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/data_sources/set_parent_data_api_service.dart';

class SetParentDataRepository extends RepoInterface<UserEntity> {
  SetParentDataRepository._();
  static final instance = SetParentDataRepository._();
  @override
  ServicesInterface get serviceInstance => SetParentDataApiService.instance;
  @override
  UserEntity Function(dynamic data) get onParse => (data) {
    return UserModel.fromJson(data is Map<String, dynamic> ? data : {});
  };

  @override
  UserEntity? get testData => UserEntity.examples.first;
}
