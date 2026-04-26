import '../../abstract/validator_imp.dart';
import '../../validation_constants.dart';

class IdentityAndPassportValidator extends ValidatorImp {
  IdentityAndPassportValidator._();

  static IdentityAndPassportValidator get instance =>
      IdentityAndPassportValidator._();

  @override
  String? validate(String? value, [Map<String, dynamic>? argument]) {
    if (value == null || value.isEmpty) {
      return ValidationConstants.emptyData;
    }

    if (value.length < 8 || value.length > 20) {
      return ValidationConstants.invalidIDOrPassportLength;
    }

    return null;
  }
}
