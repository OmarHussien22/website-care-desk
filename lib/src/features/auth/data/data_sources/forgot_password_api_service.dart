import 'package:dio/src/response.dart';

import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/params/params.dart';

class ForgotPasswordApiService extends ServicesInterface {
  ForgotPasswordApiService._();

  static final instance = ForgotPasswordApiService._();

  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      uRLForgetPassword,
      type: CrudType.post,
      auth: true,
      params: params,
      showLoadingDialog: true,
    );
  }
}
