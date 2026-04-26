import 'package:flutter/material.dart';

import 'implementation/age_validator/age_validator.dart';
import 'implementation/default_validator/default_validator.dart';
import 'implementation/email_validator/email_validator.dart';
import 'implementation/identity_validator/identity_and_passport_validator.dart';
import 'implementation/none_validator/none_validator.dart';
import 'implementation/number_validator/max_chrachter_number_validator.dart';
import 'implementation/number_validator/number_of_receivers_validator.dart';
import 'implementation/number_validator/number_validator.dart';
import 'implementation/password_validator/confirm_password_validator.dart';
import 'implementation/password_validator/password_validator.dart';
import 'implementation/phone_validator/phone_validator.dart';
import 'implementation/time_validator/from_time_validator.dart';
import 'implementation/time_validator/to_time_validator.dart';
import 'implementation/url_validator/url_validator.dart';


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
