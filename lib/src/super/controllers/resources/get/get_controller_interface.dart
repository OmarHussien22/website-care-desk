import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/super/controllers/interface/master_controller.dart';
import 'package:get/get.dart';

abstract class GetControllerInterface<T> extends GetxController
    with MasterController<T> {
  @override
  void emit(DataState<T> value) {
    state = value;
    update();
  }

  @override
  void onClose() {
    super.dispose();
  }
}
