import '../../../../core/utils/extensions/basic_op_extensions.dart';

import '../../../../core/network_structure/params/params.dart';

class CheckVerificationCodeParams extends Params {
  String phone;
  String countryCode;
  String verificationCode;

  CheckVerificationCodeParams({
    required this.phone,
    required this.countryCode,
    required this.verificationCode,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryCode,
      'verification_code': verificationCode,
    }.removeNullValues;
  }
}

