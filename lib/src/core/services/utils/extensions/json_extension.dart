import '../general_utils.dart';

extension FromJsonExtension on String {
  String get response {
    final dataA = split(",").join(" \n ");
    final dataB = dataA.split("{").join(" ");
    final dataC = dataB.split("}").join(" ");
    printDM("Dio Service correct request: => $dataC");
    return dataC;
  }
}
