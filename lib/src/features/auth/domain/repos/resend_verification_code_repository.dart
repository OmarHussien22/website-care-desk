import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/resend_verification_code_api_service.dart';

class ResendVerificationCodeRepository extends RepoInterface<bool> {
  ResendVerificationCodeRepository._();

  static final instance = ResendVerificationCodeRepository._();

  @override
  ServicesInterface get serviceInstance => ResendVerificationCodeApiService.instance;

  @override
  bool Function(dynamic data) get onParse => (data) {
    return true;
  };
  
  @override
  ResponseType get responseType => ResponseType.withoutData;
}
