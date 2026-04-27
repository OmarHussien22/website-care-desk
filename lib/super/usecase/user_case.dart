import '../../src/core/network_structure/resources/data_state/data_state.dart';

abstract class UseCase<T, P> {
  Future<DataState<T>>? call({P? params});
}
