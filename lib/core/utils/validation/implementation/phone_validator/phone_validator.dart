import '../../abstract/validator_imp.dart';
import '../../validation_constants.dart';

class PhoneValidator extends ValidatorImp {
  PhoneValidator._();
  static PhoneValidator get instance => PhoneValidator._();

  @override
  String? validate(String? value, [Map<String, dynamic>? argument]) {
    if (value == null || value.trim().isEmpty) {
      return ValidationConstants.validatePhone;
    }

    final cleanedValue = value.replaceAll(RegExp(r'\s+|-'), '');

    if (!RegExp(r'^\+?[0-9]+$').hasMatch(cleanedValue)) {
      return ValidationConstants.validatePhone;
    }

    if (cleanedValue.length < 9) {
      return ValidationConstants.validatePhoneIsShort;
    }

    // لو محتاج تتحقق من دول معينة، ممكن تستخدم argument لإرسال الدولة مثلاً
    // مثال: لو الدولة = "SA" لازم يبدأ بـ "05" أو "+966"
    if (argument?['country'] == 'SA') {
      if (!(cleanedValue.startsWith('5') || cleanedValue.startsWith('+966'))) {
        return ValidationConstants.validatePhone;
      }
    } else if (argument?['country'] == 'EG') {
      if (!(cleanedValue.startsWith('01') || cleanedValue.startsWith('+20'))) {
        return ValidationConstants.validatePhone;
      }
    } else if (argument?['country'] == 'QA') {
      if (!(cleanedValue.startsWith('3') || cleanedValue.startsWith('+974'))) {
        return ValidationConstants.validatePhone;
      }
    } else if (argument?['country'] == 'AE') {
      if (!(cleanedValue.startsWith('5') || cleanedValue.startsWith('+971'))) {
        return ValidationConstants.validatePhone;
      }
    } else if (argument?['country'] == 'KW') {
      if (!(cleanedValue.startsWith('5') || cleanedValue.startsWith('+965'))) {
        return ValidationConstants.validatePhone;
      }
    }

    return null;
  }
}
