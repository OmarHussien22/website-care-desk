import '../../domain/entities/plan_entity.dart';

abstract final class PlanModel {
  static List<PlanEntity> listFromJson(dynamic json) {
    if (json is! List) return const [];
    return json.whereType<Map>().map((item) {
      final map = Map<String, dynamic>.from(item);
      final rawLimits = map['limits'];
      final limits = rawLimits is Map
          ? Map<String, dynamic>.from(rawLimits)
          : <String, dynamic>{};
      final rawFeatures = map['features'];
      final features = rawFeatures is List
          ? rawFeatures
                .whereType<Map>()
                .map((feature) {
                  final value = Map<String, dynamic>.from(feature);
                  return PlanFeatureEntity(
                    key: value['key']?.toString() ?? '',
                    name: value['name']?.toString() ?? '',
                    enabled: value['enabled'] == true,
                  );
                })
                .where((feature) => feature.enabled && feature.name.isNotEmpty)
                .toList()
          : <PlanFeatureEntity>[];
      return PlanEntity(
        id: _int(map['id']),
        nameAr: map['name_ar']?.toString() ?? map['name']?.toString() ?? '',
        nameEn: map['name_en']?.toString() ?? map['name']?.toString() ?? '',
        type: map['type']?.toString() ?? '',
        durationDays: _int(map['duration_days']),
        price: _double(map['price']),
        currency: map['currency']?.toString() ?? '',
        hasDiscount: map['has_discount'] == true,
        discountType: map['discount_type']?.toString(),
        discountValue: _double(map['discount_value']),
        finalPrice: _double(map['final_price']),
        limits: {
          'max_doctors': _nullableInt(limits['max_doctors']),
          'max_receptionists': _nullableInt(limits['max_receptionists']),
          'max_patients': _nullableInt(limits['max_patients']),
          'max_branches': _nullableInt(limits['max_branches']),
        },
        features: features,
      );
    }).toList();
  }

  static int _int(dynamic value) => int.tryParse(value?.toString() ?? '') ?? 0;
  static int? _nullableInt(dynamic value) =>
      value == null ? null : int.tryParse(value.toString());
  static double _double(dynamic value) =>
      double.tryParse(value?.toString() ?? '') ?? 0;
}
