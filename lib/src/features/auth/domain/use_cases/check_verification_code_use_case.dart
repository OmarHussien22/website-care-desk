import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/check_verification_code_params.dart';
import '../repos/check_verification_code_repository.dart';

class CheckVerificationCodeUseCase
    extends UseCase<UserEntity, CheckVerificationCodeParams> {
  @override
  Future<DataState<UserEntity>>? call({CheckVerificationCodeParams? params}) {
    return CheckVerificationCodeRepository.instance.call(
      params: params,
    );
  }
}
