import 'package:coursaty/src/features/clinic_onboarding/data/models/plan_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses backend pricing, discount, quotas, and enabled features', () {
    final plans = PlanModel.listFromJson([
      {
        'id': 4,
        'name_ar': 'بريميوم',
        'name_en': 'Premium',
        'type': 'monthly',
        'duration_days': 120,
        'price': 1250,
        'currency': 'EGP',
        'has_discount': true,
        'discount_type': 'percentage',
        'discount_value': 10,
        'final_price': 1125,
        'limits': {
          'max_doctors': 20,
          'max_receptionists': 3,
          'max_patients': null,
          'max_branches': null,
        },
        'features': [
          {'key': 'appointments', 'name': 'Appointments', 'enabled': true},
          {'key': 'billing', 'name': 'Billing', 'enabled': false},
        ],
      },
    ]);

    expect(plans, hasLength(1));
    expect(plans.single.finalPrice, 1125);
    expect(plans.single.discountType, 'percentage');
    expect(plans.single.limits['max_doctors'], 20);
    expect(plans.single.limits['max_patients'], isNull);
    expect(plans.single.features, hasLength(1));
    expect(plans.single.features.single.key, 'appointments');
  });
}
