import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/forgot_password_api_service.dart';

class ForgotPasswordRepository extends RepoInterface<bool> {
  ForgotPasswordRepository._();

  static final instance = ForgotPasswordRepository._();

  @override
  ServicesInterface get serviceInstance => ForgotPasswordApiService.instance;
  @override
  bool Function(dynamic data) get onParse => (data) {
    return true;
  };
  @override
  ResponseType get responseType => ResponseType.withoutData;
}
