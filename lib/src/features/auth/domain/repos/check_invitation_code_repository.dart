import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/repository/repo_interface.dart';
import '../../../../core/network_structure/entities/entity.dart';
import '../../data/data_sources/check_invitation_code_api_service.dart';

class CheckInvitationCodeRepository extends RepoInterface<void> {
  CheckInvitationCodeRepository._();
  static final instance = CheckInvitationCodeRepository._();
  
  @override
  ServicesInterface get serviceInstance => CheckInvitationCodeApiService.instance;
  
  @override
  void Function(dynamic data) get onParse => (data) {
    
  };
  
  @override
  ResponseType get responseType => ResponseType.withoutData;

}
