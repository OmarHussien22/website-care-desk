import '../../../../core/network_structure/params/params.dart';
import '../../../../core/utils/extensions/basic_op_extensions.dart';

class ResetPasswordParams extends Params {
  String phone;
  String countryCode;
  String verificationCode;
  String password;

  ResetPasswordParams({
    required this.phone,
    required this.countryCode,
    required this.verificationCode,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryCode,
      'verification_code': verificationCode,
      'password': password,
    }.removeNullValues;
  }
}

