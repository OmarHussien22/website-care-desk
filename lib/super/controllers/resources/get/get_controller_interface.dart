import '../../../../packages_index.dart';
import '../../../../src/core/network_structure/resources/data_state/data_state.dart';
import '../../interface/master_controller.dart';

abstract class GetControllerInterface<T> extends GetxController
    with MasterController<T> , WidgetsBindingObserver {
  @override
  void emit(DataState<T> value) {
    state = value;
    update();
  }
}
