import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/data_sources/login_api_service.dart';

class LoginRepository extends RepoInterface<UserEntity> {
  LoginRepository._();

  static final instance = LoginRepository._();

  @override
  ServicesInterface get serviceInstance => LoginApiService.instance;

  @override
  UserEntity Function(dynamic data) get onParse => (data) {
    return UserModel.fromJson(data);
  };

  @override
  UserEntity? get testData => UserEntity.examples.first;
}
