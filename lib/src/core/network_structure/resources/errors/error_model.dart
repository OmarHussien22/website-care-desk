
import '../../../services/lang/translate_extention.dart';

class ErrorModel {
  String title;
  bool? status;
  final ErrorType type;

  ErrorModel({required this.title, required this.type, this.status}) {
    title = title.toTr();
    status = status;
  }
}

enum ErrorType {
  serverSide,
  networkConnection,
  dataEmpty,
  dirtyData,
  statusFalse,
  unKnown,
}

// error model
