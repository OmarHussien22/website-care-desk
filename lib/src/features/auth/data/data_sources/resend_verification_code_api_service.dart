import 'package:dio/src/response.dart';

import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/params/params.dart';

class ResendVerificationCodeApiService extends ServicesInterface {
  ResendVerificationCodeApiService._();

  static final instance = ResendVerificationCodeApiService._();

  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      uRLResetPassword,
      type: CrudType.post,
      auth: true,
      params: params,
      showLoadingDialog: true,
    );
  }
}
