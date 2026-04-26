import '../../abstract/validator_imp.dart';
import '../../validation_constants.dart';

class PasswordValidator extends ValidatorImp {
  PasswordValidator._();
  static PasswordValidator get instance => PasswordValidator._();
  @override
  String? validate(String? value, [Map<String, dynamic>? argument]) {
    if (value!.isEmpty) {
      return ValidationConstants.emptyData;
    } else {
      if (value.length < 8) {
        return ValidationConstants.validatePasswordLength;
      } else {
        return null;
      }
    }
  }
}
