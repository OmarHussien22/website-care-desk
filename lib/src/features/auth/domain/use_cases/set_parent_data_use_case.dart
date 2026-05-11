import '../../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../super/use_case/user_case.dart';
import '../../core/params/set_parent_data_params.dart';
import '../repos/set_parent_data_repository.dart';

class SetParentDataUseCase extends UseCase<UserEntity, SetParentDataParams> {
  @override
  Future<DataState<UserEntity>>? call({SetParentDataParams? params}) {
    return SetParentDataRepository.instance.call(
      params: params,
    );
  }
}
