import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/register_params.dart';
import '../repos/register_repository.dart';

class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  @override
  Future<DataState<UserEntity>>? call({RegisterParams? params}) {
    return RegisterRepository.instance. call(
      params: params,
    );
  }
}
