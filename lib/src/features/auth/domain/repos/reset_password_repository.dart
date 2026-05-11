import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/data_sources/reset_password_api_service.dart';

class ResetPasswordRepository extends RepoInterface<UserEntity> {
  ResetPasswordRepository._();

  static final instance = ResetPasswordRepository._();

  @override
  ServicesInterface get serviceInstance => ResetPasswordApiService.instance;
  @override
  UserEntity Function(dynamic data) get onParse => (data) {
    return UserModel.fromJson(data);
  };
  @override
  ResponseType get responseType => ResponseType.withData;
  @override
  UserEntity? get testData => UserEntity.examples.first;
}
