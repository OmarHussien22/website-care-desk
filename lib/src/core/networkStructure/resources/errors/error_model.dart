
import '../../../services/lang_service/translate_extention.dart';

class ErrorModel {
  String title;
  final ErrorType type;

  ErrorModel({
    required this.title,
    required this.type,
  }) {
    title = title.toTr();
  }
}

enum ErrorType {
  serverSide,
  networkConnection,
  dataEmpty,
  dirtyData,
  unKnown,
  timeOut,
}


// error model