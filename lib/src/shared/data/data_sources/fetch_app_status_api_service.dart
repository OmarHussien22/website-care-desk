import 'package:dio/src/response.dart';

import '../../../core/network_structure/data_source/service_interface.dart';
import '../../../core/network_structure/params/params.dart';

class FetchAppStatusApiService extends ServicesInterface {
  FetchAppStatusApiService._();
  static final instance =FetchAppStatusApiService._();
  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      uRLFetchAppStatus,
      type: CrudType.post,
      params: params,
    );
  }
}
