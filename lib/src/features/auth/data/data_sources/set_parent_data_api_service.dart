import 'package:dio/src/response.dart';
import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/params/params.dart';

class SetParentDataApiService extends ServicesInterface {
  SetParentDataApiService._();

  static final instance = SetParentDataApiService._();

  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      uRLSetParentData,
      type: CrudType.post,
      params: params,
      showLoadingDialog: true,
    );
  }
}
