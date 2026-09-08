import 'package:coursaty/src/core/network_structure/data_source/service_interface.dart';
import 'package:coursaty/src/core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/plans_api_service.dart';
import '../../data/models/plan_model.dart';
import '../entities/plan_entity.dart';

class PlansRepository extends RepoInterface<List<PlanEntity>> {
  PlansRepository._();
  static final instance = PlansRepository._();

  @override
  ServicesInterface get serviceInstance => PlansApiService.instance;

  @override
  List<PlanEntity> Function(dynamic data) get onParse => PlanModel.listFromJson;

  @override
  List<PlanEntity> get testData => const [];
}
