import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/use_case/user_case.dart';
import '../params/check_invitation_code_params.dart';
import '../repos/check_invitation_code_repository.dart';

class CheckInvitationCodeUseCase extends UseCase<void, CheckInvitationCodeParams> {
  @override
  Future<DataState<void>>? call({CheckInvitationCodeParams? params}) {
    return CheckInvitationCodeRepository.instance.call(
      params: params,
    );
  }
}
