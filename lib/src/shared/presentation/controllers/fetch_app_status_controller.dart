import '../../../super/controllers/resources/get/get_controller_interface.dart';
import '../../domain/entities/app_status_entity.dart';
import '../../domain/use_cases/fetch_app_status_use_case.dart';

class FetchAppStatusController extends GetControllerInterface<AppStatusEntity> {
  fetchAppStatus() async {
    FetchAppStatusUseCase useCase = FetchAppStatusUseCase();
    state = await useCase()!;
    emit(state);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAppStatus();
  }
}
