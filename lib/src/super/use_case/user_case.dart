import '../../core/network_structure/resources/data_state/data_state.dart';

import '../../core/network_structure/params/params.dart';

abstract class UseCase<T, P extends Params> {
  Future<DataState<T>>? call({P? params}) ;


}
