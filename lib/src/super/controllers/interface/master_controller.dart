import '../../../core/networkStructure/resources/dataState/data_state.dart';

mixin MasterController<T> {
  void emit(DataState<T> value);

  DataState<T> state = DataInitial<T>();

  bool get stateReady => state is! DataLoading;

  bool get stateUnReady => state is DataLoading;

  bool get stateSuccess => state is DataSuccess;

  bool get stateError => state is DataFailed;
}
