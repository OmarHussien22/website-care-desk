import '../../abstract/validator_imp.dart';

class NumberValidator extends ValidatorImp {
  NumberValidator._();

  static NumberValidator get instance => NumberValidator._();

  @override
  String? validate(String? value, [Map<String, dynamic>? argument]) {
    final valueAsNum = int.tryParse(value?.replaceAll(
          RegExp(r'[^0-9]'),
          '',
        ) ??
        '');
    if (value == null || value.isEmpty) {
      return 'Number must not be empty';
    }
    if (valueAsNum == null) {
      return 'Please enter valid number';
    }
    if (valueAsNum < 1) {
      return 'Number can not be less than 1';
    }
    return null;
  }
}
