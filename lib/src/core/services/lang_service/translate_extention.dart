// import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// extension TranslateExtension on String {
//   String toTr({
//     List<String>? args,
//     Map<String, String>? namedArgs,
//     String? gender,
//   }) =>
//       tr(this, args: args, namedArgs: namedArgs, gender: gender);
//
//   /// prevent translation
//
//
// }
extension TranslateExtension on String {
  String toTr() => tr;
}
