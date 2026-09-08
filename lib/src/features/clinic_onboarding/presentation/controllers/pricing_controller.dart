import 'package:coursaty/src/core/app/meddesk_config.dart';
import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:get/get.dart';
import '../../domain/entities/plan_entity.dart';
import '../../domain/use_cases/fetch_plans_use_case.dart';

class PricingController extends GetxController {
  DataState<List<PlanEntity>> state = DataInitial<List<PlanEntity>>();
  bool get endpointAvailable => MedDeskConfig.publicPlansPath.isNotEmpty;
  bool get isLoading => state is DataLoading<List<PlanEntity>>;

  @override
  void onInit() {
    super.onInit();
    if (endpointAvailable) fetchPlans();
  }

  Future<void> fetchPlans() async {
    if (!endpointAvailable) return;
    state = const DataLoading<List<PlanEntity>>();
    update();
    state = await FetchPlansUseCase()() ?? DataInitial<List<PlanEntity>>();
    update();
  }
}
