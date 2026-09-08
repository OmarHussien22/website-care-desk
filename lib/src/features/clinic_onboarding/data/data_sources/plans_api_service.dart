import 'package:coursaty/src/core/network_structure/data_source/service_interface.dart';
import 'package:coursaty/src/core/network_structure/params/params.dart';
import 'package:dio/dio.dart';

class PlansApiService extends ServicesInterface {
  PlansApiService._();
  static final instance = PlansApiService._();

  @override
  Future<Response> applyService({Params? params}) =>
      super.call(uRLPublicPlans, type: CrudType.get, params: params);
}
