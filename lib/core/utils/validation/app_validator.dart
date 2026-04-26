import 'package:flutter/material.dart';

import 'implementation/ageValidator/age_validator.dart';
import 'implementation/defaultValidator/default_validator.dart';
import 'implementation/emailValidator/email_validator.dart';
import 'implementation/identityValidator/identity_and_passport_validator.dart';
import 'implementation/noneValidator/none_validator.dart';
import 'implementation/numberValidator/max_chrachter_number_validator.dart';
import 'implementation/numberValidator/number_of_receivers_validator.dart';
import 'implementation/numberValidator/number_validator.dart';
import 'implementation/passwordValidator/confirm_password_validator.dart';
import 'implementation/passwordValidator/password_validator.dart';
import 'implementation/phoneValidator/phone_validator.dart';
import 'implementation/timeValidator/from_time_validator.dart';
import 'implementation/timeValidator/to_time_validator.dart';
import 'implementation/urlValidator/url_validator.dart';

void formValidator({
  required GlobalKey<FormState> globalKey,
  required VoidCallback onSuccessValidate,
  VoidCallback? onFailedValidate,
}) {
  if (globalKey.currentState?.validate() ?? false) {
    globalKey.currentState?.save();
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

  static AgeValidator get ageValidator => AgeValidator.instance;

  static PasswordValidator get passwordValidator => PasswordValidator.instance;
  static ConfirmPasswordValidator get confirmPasswordValidator =>
      ConfirmPasswordValidator.instance;

  static UrlValidator get urlValidator => UrlValidator.instance;

  static DefaultValidator get defaultValidator => DefaultValidator.instance;
  static EmailValidator get emailValidator => EmailValidator.instance;

  static FromTimeValidator get fromTimeValidator => FromTimeValidator.instance;
  static ToTimeValidator get toTimeValidator => ToTimeValidator.instance;
  static NumberValidator get numberValidator => NumberValidator.instance;
  static NoOfReceiversValidator get numberOfReceiversValidator =>
      NoOfReceiversValidator.instance;
  static IdentityAndPassportValidator get identityAndPassportValidator =>
      IdentityAndPassportValidator.instance;

  static MaxCharacterNumberValidator get maxCharacterNumberValidator =>
      MaxCharacterNumberValidator.instance;
}
