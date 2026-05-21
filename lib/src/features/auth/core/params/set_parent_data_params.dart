import '../../../../core/network_structure/params/params.dart';

class SetParentDataParams extends Params {
  final String countryCode;
  final String parentName;
  final String parentPhone;

  SetParentDataParams({
    required this.countryCode,
    required this.parentName,
    required this.parentPhone,
  });

  @override
  toJson() => {
    "country_code": countryCode,
    "parent_name": parentName,
    "parent_phone": parentPhone,
  };
}
