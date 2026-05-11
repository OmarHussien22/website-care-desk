import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/reset_password_params.dart';
import '../repos/reset_password_repository.dart';

class ResetPasswordUseCase extends UseCase<UserEntity, ResetPasswordParams> {
  @override
  Future<DataState<UserEntity>>? call({ResetPasswordParams? params}) {
    return ResetPasswordRepository.instance.call(params: params);
  }
}
