import 'package:coursaty/src/core/utils/validation/implementation/default_validator/default_validator.dart';
import 'package:coursaty/src/core/utils/validation/implementation/none_validator/none_validator.dart';
import 'package:coursaty/src/core/utils/validation/implementation/password_validator/password_validator.dart';
import 'package:coursaty/src/core/utils/validation/implementation/phone_validator/phone_validator.dart';
import 'package:flutter/material.dart';

import 'implementation/age_validator/age_validator.dart';
import 'implementation/email_validator/email_validator.dart';
import 'implementation/foundatioon_name_validator/foundation_name_validator.dart';
import 'implementation/full_name_validator/full_name_validator.dart';
import 'implementation/number_validator/number_validator.dart';

void formValidator({
  required GlobalKey<FormState> globalKey,
  required VoidCallback onSuccessValidate,
  VoidCallback? onFailedValidate,
}) {
  if (globalKey.currentState!.validate()) {
    globalKey.currentState!.save();
    onSuccessValidate();
  } else {
    if (onFailedValidate != null) {
      onFailedValidate();
    }
  }
}

class AppValidator {
  AppValidator._();

  static NoneValidator get noneValidator => NoneValidator.instance;

  static PhoneValidator get phoneValidator => PhoneValidator.instance;

  static NumberValidator get numberValidator => NumberValidator.instance;

  static AgeValidator get ageValidator => AgeValidator.instance;

  static PasswordValidator get passwordValidator => PasswordValidator.instance;

  static DefaultValidator get defaultValidator => DefaultValidator.instance;

  static FullNameValidate get fullNameValidator => FullNameValidate.instance;
  static FoundationNameValidator get foundationNameValidator =>
      FoundationNameValidator.instance;

  static EmailValidator get emailValidator => EmailValidator.instance;
}
