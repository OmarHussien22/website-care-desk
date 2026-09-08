import 'package:coursaty/src/features/clinic_onboarding/core/utils/phone_number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'removes the local trunk prefix when building an international phone',
    () {
      expect(
        PhoneNumberFormatter.toInternational(
          countryCode: '+20',
          localNumber: '01060561548',
        ),
        '+201060561548',
      );
    },
  );

  test('normalizes separators in country code and local phone', () {
    expect(
      PhoneNumberFormatter.toInternational(
        countryCode: '+20',
        localNumber: '010 6056-1548',
      ),
      '+201060561548',
    );
  });
}
