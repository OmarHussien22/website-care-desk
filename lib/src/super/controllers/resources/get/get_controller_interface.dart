import '../../../../../app_imports.dart';
import '../../../../core/networkStructure/resources/dataState/data_state.dart';
import '../../interface/master_controller.dart';
import 'package:get/get.dart';

abstract class GetControllerInterface<T> extends GetxController
    with MasterController<T> , WidgetsBindingObserver {
  @override
  void emit(DataState<T> value) {
    state = value;
    update();
  }
}
