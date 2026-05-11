import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/forgot_password_params.dart';
import '../repos/forgot_password_repository.dart';

class ForgotPasswordUseCase extends UseCase<bool, ForgotPasswordParams> {
  @override
  Future<DataState<bool>>? call({ForgotPasswordParams? params}) {
    return ForgotPasswordRepository.instance.call(params: params);
  }
}
