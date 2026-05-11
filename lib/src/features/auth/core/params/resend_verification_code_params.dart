import '../../../../core/network_structure/params/params.dart';

class ResendVerificationCodeParams extends Params {
  final String phone;
  final String countryCode;

  ResendVerificationCodeParams({required this.phone, required this.countryCode});
  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryCode,
    };
  }
}

