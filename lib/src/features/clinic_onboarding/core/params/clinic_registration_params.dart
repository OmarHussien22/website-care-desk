import 'package:coursaty/src/core/network_structure/params/params.dart';

/// Payload mirrors the existing Laravel StoreClinicRequest. Subscription and
/// API-key fields are deliberately absent because ClinicService owns them.
class ClinicRegistrationParams extends Params {
  ClinicRegistrationParams({
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerPassword,
    required this.clinicName,
    required this.clinicType,
    required this.email,
    required this.specialtyId,
  });

  final String ownerName;
  final String ownerPhone;
  final String ownerPassword;
  final String clinicName;
  final String clinicType;
  final String email;
  final int specialtyId;

  @override
  Map<String, dynamic> toJson() => {
    'name': clinicName,
    'type': clinicType,
    'phone': ownerPhone,
    'email': email,
    'owner_name': ownerName,
    'owner_phone': ownerPhone,
    'owner_password': ownerPassword,
    'specialty_id': specialtyId,
  };
}
