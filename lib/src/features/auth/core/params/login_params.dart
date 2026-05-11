import '../../../../core/network_structure/params/params.dart';
import '../../../../core/utils/extensions/basic_op_extensions.dart';

class LoginParams extends Params {
  String phone;
  String countryCode;
  String password;
  String? deviceToken;
  String? deviceId;

  LoginParams({
    required this.phone,
    required this.countryCode,
    required this.password,
    this.deviceToken,
    this.deviceId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      "country_code": countryCode,
      'password': password,
      'device_token': deviceToken,
      'device_id': deviceId,
    }.removeNullValues;
  }
}

