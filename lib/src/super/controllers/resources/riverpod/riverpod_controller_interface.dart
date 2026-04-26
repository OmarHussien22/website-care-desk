import 'package:flutter/material.dart';

import '../../../../core/networkStructure/resources/dataState/data_state.dart';
import '../../interface/master_controller.dart';

abstract class RiverControllerInterface<T> extends ChangeNotifier
    with MasterController<T> {
  @override
  void emit(DataState<T> value) {
    state = value;
    notifyListeners();
  }
}
