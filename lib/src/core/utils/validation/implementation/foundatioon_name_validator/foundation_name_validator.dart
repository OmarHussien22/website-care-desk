import '../../../../services/lang/translate_extention.dart';

class FoundationNameValidator {
  FoundationNameValidator._();

  static FoundationNameValidator get instance => FoundationNameValidator._();

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validate_enter_foundation_name'.toTr();
    }

// Regular expression for full name (at least two words, only letters and spaces)
    final RegExp nameRegExp =
        RegExp(r'^[a-zA-Z\u0600-\u06FF]+(?: [a-zA-Z\u0600-\u06FF]+)+$');

    if (!nameRegExp.hasMatch(value.trim())) {
      return 'validate_foundation_name'.toTr();
    }

    return null; // Valid name
  }
}
