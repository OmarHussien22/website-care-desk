abstract final class PhoneNumberFormatter {
  static String toInternational({
    required String countryCode,
    required String localNumber,
  }) {
    final code = countryCode.replaceAll(RegExp(r'\D'), '');
    var number = localNumber.replaceAll(RegExp(r'\D'), '');

    if (code.isEmpty) return number;
    if (number.startsWith('0')) number = number.substring(1);

    return '+$code$number';
  }
}
