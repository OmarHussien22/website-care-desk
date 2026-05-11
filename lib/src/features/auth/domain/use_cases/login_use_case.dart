import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/login_params.dart';
import '../repos/login_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  @override
  Future<DataState<UserEntity>>? call({LoginParams? params}) {
    return LoginRepository.instance.call(
      params: params,
    );
  }
}
