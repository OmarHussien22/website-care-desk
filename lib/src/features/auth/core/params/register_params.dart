
import '../../../../core/network_structure/params/params.dart';
import '../../../../core/utils/extensions/basic_op_extensions.dart';

class RegisterParams extends Params {
  String name;
  String phone;
  String countryCode;
  String password;
  String? parentPhone;
  String? parentName;
  String? deviceToken;
  String? deviceId;

  RegisterParams({
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.password,
    this.parentPhone,
    this.parentName,
    this.deviceToken,
    this.deviceId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'country_code': countryCode,
      'password': password,
      'parent_phone': parentPhone,
      'parent_name': parentName,
      'device_token': deviceToken,
      'device_id': deviceId,
    }.removeNullValues;
  }
}

