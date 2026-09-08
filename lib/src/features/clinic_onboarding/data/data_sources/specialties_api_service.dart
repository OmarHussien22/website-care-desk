import 'package:coursaty/src/core/network_structure/data_source/service_interface.dart';
import 'package:coursaty/src/core/network_structure/params/params.dart';
import 'package:dio/dio.dart';

class SpecialtiesApiService extends ServicesInterface {
  SpecialtiesApiService._();
  static final instance = SpecialtiesApiService._();

  @override
  Future<Response> applyService({Params? params}) =>
      super.call(uRLPublicSpecialties, type: CrudType.get, params: params);
}
