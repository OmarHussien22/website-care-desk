import 'package:coursaty/src/core/constants/app_constants.dart';

import '../../../../services/lang/translate_extention.dart';
import '../../abstract/validator_imp.dart';

class NumberValidator extends ValidatorImp {
  NumberValidator._();

  static NumberValidator get instance => NumberValidator._();

  @override
  String? validate(String? value, [Map<String, dynamic>? argument]) {
    final valueAsNum = int.tryParse(
      value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '',
    );
    if (value == null || value.isEmpty) {
      return 'number_not_empty'.toTr();
    }
    if (valueAsNum == null) {
      return 'number_not_correct'.toTr();
    }
    final regex = RegExp(r'^\d+$');
    if (!regex.hasMatch(value)) {
      return 'number_not_correct'.toTr();
    }
    if (valueAsNum < 1) {
      return 'number_not_minus'.toTr();
    }
    return null;
  }
}
