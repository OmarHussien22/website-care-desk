import 'package:coursaty/src/core/network_structure/entities/entity.dart';

class SpecialtyEntity extends Entity {
  const SpecialtyEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.status,
  });
  final int id;
  final String nameAr;
  final String nameEn;
  final String status;

  String localizedName(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;

  @override
  List<Object?> get props => [id, nameAr, nameEn, status];

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'status': status,
  };
}

class ClinicRegistrationEntity extends Entity {
  const ClinicRegistrationEntity({required this.id, required this.name});
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
