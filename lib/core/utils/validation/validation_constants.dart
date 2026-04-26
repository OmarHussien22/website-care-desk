import '../../services/lang_service/translate_extention.dart';

class ValidationConstants {
  ValidationConstants._();
  static String _translateLabel(String value) => value.toTr();
  static String validatePhone = _translateLabel("validate_phone");
  static String validatePhoneIsReal = _translateLabel("validate_phone_is_real");
  static String validatePhoneIsShort =
      _translateLabel("validate_phone_is_real"); //"validate_phone_length"
  static String invalidEmail = _translateLabel("validate_invalid_email");
  static String validatePassword = _translateLabel("validate_password");
  static String validatePasswordConfirm =
      _translateLabel("validate_confirm_password");
  static String validatePasswordLength =
      _translateLabel("validate_password_length");
  static String validateAge = _translateLabel("validate_age");
  static String validateAgeLimitation = _translateLabel("validate_age_limit");
  static String validateMaxNumberCharacter =
      _translateLabel("message_number_charachter");
  static String emptyData = _translateLabel("field_required");
  static String validateFromTime = _translateLabel("validate_from_time");
  static String validateFromTimeToNow =
      _translateLabel("validate_from_time_to_now");
  static String validateToTime = _translateLabel("validate_to_time");
  static String validateToTimeToNow =
      _translateLabel("validate_to_time_to_now");
  static String validateToTimeToFromTime =
      _translateLabel("validate_to_time_to_from_time");
  static String invalidIDOrPassportLength =
      _translateLabel("validate_identity_or_passport_length");
}
