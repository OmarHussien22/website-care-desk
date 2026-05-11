import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/data_sources/register_api_service.dart';

class RegisterRepository extends RepoInterface<UserEntity> {
  RegisterRepository._();
  static final instance = RegisterRepository._();
  @override
  ServicesInterface get serviceInstance => RegisterApiService.instance;
  @override
  UserEntity Function(dynamic data) get onParse => (data) {
    return UserModel.fromJson(data);
  };

  @override
  UserEntity? get testData => UserEntity.examples.first;
}
