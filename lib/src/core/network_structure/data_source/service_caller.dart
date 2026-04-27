import 'package:dio/dio.dart';
import 'package:coursaty/src/core/network_structure/params/params.dart';

abstract class ServiceCaller {
  Future<Response> applyService({Params? params});
}
