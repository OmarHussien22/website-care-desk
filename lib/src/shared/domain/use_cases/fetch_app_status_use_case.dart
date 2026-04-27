import '../../../core/network_structure/params/params.dart';
import '../../../core/network_structure/resources/data_state/data_state.dart';
import '../../../super/use_case/user_case.dart';
import '../entities/app_status_entity.dart';
import '../repositories/fetch_app_status_repo.dart';

class FetchAppStatusUseCase extends UseCase<AppStatusEntity,NOParams>{
  @override
  Future<DataState<AppStatusEntity>>? call({NOParams? params}) {
return
  FetchAppStatusRepo.instance.call(params: params);
  }
}