import 'package:flutter/material.dart';

import '../../../../src/core/network_structure/resources/data_state/data_state.dart';
import '../../interface/master_controller.dart';

abstract class RiverControllerInterface<T> extends ChangeNotifier
    with MasterController<T> {
  @override
  void emit(DataState<T> value) {
    state = value;
    notifyListeners();
  }
}
