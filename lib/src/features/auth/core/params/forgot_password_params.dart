import '../../../../core/network_structure/params/params.dart';

class ForgotPasswordParams extends Params {
  final String phone;
  final String countryCode;

  ForgotPasswordParams({required this.phone, required this.countryCode});
  @override
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'country_code': countryCode,
    };
  }
}

