import 'package:coursaty/src/core/network_structure/data_source/service_interface.dart';
import 'package:coursaty/src/core/network_structure/params/params.dart';
import 'package:dio/dio.dart';

class ClinicRegistrationApiService extends ServicesInterface {
  ClinicRegistrationApiService._();
  static final instance = ClinicRegistrationApiService._();

  @override
  Future<Response> applyService({Params? params}) => super.call(
    uRLPublicRegistration,
    type: CrudType.post,
    params: params,
    contentType: HeaderContentType.json,
  );
}
