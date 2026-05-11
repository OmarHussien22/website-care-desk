import 'package:dio/src/response.dart';
import '../../../../core/network_structure/data_source/service_interface.dart';
import '../../../../core/network_structure/params/params.dart';

class CheckInvitationCodeApiService extends ServicesInterface {
  CheckInvitationCodeApiService._();

  static final instance = CheckInvitationCodeApiService._();

  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      uRLCheckInvitationCode,
      type: CrudType.post,
      params: params,
      showLoadingDialog: true,
    );
  }
}
