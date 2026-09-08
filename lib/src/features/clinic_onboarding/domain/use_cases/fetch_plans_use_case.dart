import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/core/network_structure/params/params.dart';
import 'package:coursaty/src/super/use_case/user_case.dart';
import '../entities/plan_entity.dart';
import '../repos/plans_repository.dart';

class FetchPlansUseCase extends UseCase<List<PlanEntity>, NOParams> {
  @override
  Future<DataState<List<PlanEntity>>>? call({NOParams? params}) =>
      PlansRepository.instance.call(params: params);
}
