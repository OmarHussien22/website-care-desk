import 'package:coursaty/src/core/utils/general_utils.dart';
import 'package:coursaty/src/core/utils/utils.dart';

extension FromJsonExtension on String {
  String get response {
    final dataA = this.split(",").join(" \n ");
    final dataB = dataA.split("{").join(" ");
    final dataC = dataB.split("}").join(" ");
    printDM("Dio Service correct request: => $dataC");
    return dataC;
  }
}
