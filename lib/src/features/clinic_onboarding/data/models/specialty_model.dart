import '../../domain/entities/specialty_entity.dart';

abstract final class SpecialtyModel {
  static List<SpecialtyEntity> listFromJson(dynamic json) {
    if (json is! List) return const [];
    return json
        .whereType<Map>()
        .map((item) {
          final map = Map<String, dynamic>.from(item);
          return SpecialtyEntity(
            id: int.tryParse(map['id']?.toString() ?? '') ?? 0,
            nameAr: map['name_ar']?.toString() ?? '',
            nameEn: map['name_en']?.toString() ?? '',
            status: map['status']?.toString() ?? '',
          );
        })
        .where((item) => item.id > 0 && item.status == 'active')
        .toList();
  }

  static ClinicRegistrationEntity registrationFromJson(dynamic json) {
    final map = json is Map
        ? Map<String, dynamic>.from(json)
        : <String, dynamic>{};
    return ClinicRegistrationEntity(
      id: int.tryParse(map['id']?.toString() ?? '') ?? 0,
      name: map['name']?.toString() ?? '',
    );
  }
}
