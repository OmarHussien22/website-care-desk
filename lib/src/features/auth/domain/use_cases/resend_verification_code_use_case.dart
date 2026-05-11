import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/resend_verification_code_params.dart';
import '../repos/resend_verification_code_repository.dart';

class ResendVerificationCodeUseCase extends UseCase<bool, ResendVerificationCodeParams> {
  @override
  Future<DataState<bool>>? call({ResendVerificationCodeParams? params}) {
    return ResendVerificationCodeRepository.instance.call(params: params);
  }
}
