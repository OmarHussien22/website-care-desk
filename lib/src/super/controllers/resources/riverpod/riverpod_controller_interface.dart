import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/super/controllers/interface/master_controller.dart';
import 'package:flutter/material.dart';

abstract class RiverControllerInterface<T> extends ChangeNotifier
    with MasterController<T> {
  @override
  void emit(DataState<T> value) {
    state = value;
    notifyListeners();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
