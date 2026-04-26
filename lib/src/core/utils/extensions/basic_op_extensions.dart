import '../general_utils.dart';
// extension ObjectOp on Object {
//
// }

extension BoolOp<T extends bool?> on T? {
  bool get noneNull => this ?? false;
  bool get toggle => !(this ?? false);
  int get toInt => this == true ? 1 : 0;
  String get noneNullToString => this?.toString() ?? "false";
}

extension IntOp on int? {
  bool get isEven => (this ?? 0) % 2 == 0;
  bool get toBool => this == 1;
  int get noneNull => this ?? -1;
  String get noneNullToString => this?.toString() ?? "0";
}

extension DoubleOp on double? {
  bool get isEven => (this ?? 0) % 2 == 0;
  bool get toBool => this == 1;
  double get noneNull => this ?? 0;
  String get noneNullToString => this?.toString() ?? "0";
}

extension StringOp on String? {
  String get notNull => this ?? "";
  String get notNullAsDouble => this ?? "0.0";
  String get noneNullToString => this ?? "";
}

// generic list
extension ListOp<T> on List<T>? {
  List<T> get notNull => this ?? [];
}

extension MapOp on Map? {
  Map get noneNull => this ?? {};
}

extension TryCatchExtension<T extends Object> on T? {
  void catcher({
    required Function(T? data) onSuccess,
    Function(Object e)? onFailure,
  }) {
    try {
      onSuccess(this);
    } catch (e) {
      printDM("error caught is => : $e");
      onFailure?.call(e);
    }
  }
}

extension ParamsExtension on Map<String, dynamic> {
  Map<String, dynamic> get removeNullValues {
    removeWhere(
          (key, value) => value == null || value == -1 || value == '',
    );
    return this;
  }
}
