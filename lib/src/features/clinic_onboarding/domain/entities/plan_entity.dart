import 'package:coursaty/src/core/network_structure/entities/entity.dart';

class PlanFeatureEntity {
  const PlanFeatureEntity({
    required this.key,
    required this.name,
    required this.enabled,
  });
  final String key;
  final String name;
  final bool enabled;
}

class PlanEntity extends Entity {
  const PlanEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.type,
    required this.durationDays,
    required this.price,
    required this.currency,
    required this.hasDiscount,
    required this.discountType,
    required this.discountValue,
    required this.finalPrice,
    required this.limits,
    required this.features,
  });

  final int id;
  final String nameAr;
  final String nameEn;
  final String type;
  final int durationDays;
  final double price;
  final String currency;
  final bool hasDiscount;
  final String? discountType;
  final double discountValue;
  final double finalPrice;
  final Map<String, int?> limits;
  final List<PlanFeatureEntity> features;

  String localizedName(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;

  @override
  List<Object?> get props => [
    id,
    nameAr,
    nameEn,
    type,
    durationDays,
    price,
    currency,
    hasDiscount,
    discountType,
    discountValue,
    finalPrice,
    limits,
    features,
  ];

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'type': type,
    'duration_days': durationDays,
    'price': price,
    'currency': currency,
    'has_discount': hasDiscount,
    'discount_type': discountType,
    'discount_value': discountValue,
    'final_price': finalPrice,
    'limits': limits,
  };
}
