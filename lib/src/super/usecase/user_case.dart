import '../../Core/NetworkStructure/Resources/DataState/data_state.dart';

abstract class UseCase<T, P> {
  Future<DataState<T>>? call({P? params});
}
