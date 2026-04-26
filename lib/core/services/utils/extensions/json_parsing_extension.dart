import 'dart:developer';
import 'package:stack_trace/stack_trace.dart';
extension JsonParsingExtensions on Map<String, dynamic>? {
  String parseString(String key, {String defaultValue = ''}) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! String) {
      if (value is int || value is double || value is bool) {
        return value.toString();
      }
      log(
        "key: $key is not a string, It's ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      return value;
    }
  }
  int parseInt(String key, {int defaultValue = 0}) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! int) {
      if (value is double) {  
        return value.toInt();
      } else if (value is String) {
        return int.tryParse(value) ?? defaultValue;
      }
      log(
        "key: $key is not an int, It's ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      return value;
    }
  }
  double? parseDouble(String key, {double? defaultValue}) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! double) {
      if (value is int) {
        return value.toDouble();
      } else if (value is String) {
        return double.tryParse(value) ?? defaultValue;
      }
      log(
        "key: $key is not a double, It's ${value.runtimeType}",
        name: "",
      );
      return defaultValue;
    } else {
      return value;
    }
  }
  bool parseBool(String key, {bool defaultValue = false}) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! bool) {
      if (value is int || value is double) {
        return value == 1 || value == 1.0;
      }
      log(
        "key: $key is not a bool, It's ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      return value;
    }
  }
  T? parseObj<T>(String key, T Function(Map<String, dynamic> e) onParse,
      {T? defaultValue}) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("The key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! Map<String, dynamic>) {
      log(
        "The key: $key is not a map, It's ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      return onParse(value);
    }
  }
  List<T>? parseListOfObj<T>(
    String key,
    T Function(Map<String, dynamic> e) onParse, {
    List<T>? defaultValue,
  }) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log(
        "key: $key is null",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else if (value is! List) {
      log(
        "key: $key is not a list, It's a list of ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else if (value.isNotEmpty && value.first is! Map<String, dynamic>) {
      log(
        "key: $key is not a list of maps, It's a list of ${value.first.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      log(
        "key: $key is a list of maps}",
        name: "JPE - ${frame.member}",
      );
      return value.map((e) => onParse(e)).toList();
    }
  }
  List<T>? parseList<T>(
    String key, {
    List<T>? defaultValue,
  }) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! List) {
      log(
        "key: $key is not a list, It's a list of ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      return _parsing<T>(value);
    }
  }
  Map<String, dynamic>? parseMap(
    String key, {
    Map<String, dynamic>? defaultValue,
  }) {
    final frame = Trace.current(1).frames[1];
    final value = this?[key];
    if (value == null) {
      log("key: $key is null", name: "JPE - ${frame.member}");
      return defaultValue;
    } else if (value is! Map<String, dynamic>) {
      log(
        "key: $key is not a map, It's ${value.runtimeType}",
        name: "JPE - ${frame.member}",
      );
      return defaultValue;
    } else {
      return value;
    }
  }
  List<T>? _parsing<T>(List value) {
    switch (T) {
      case const (String):
        return value.map((e) => e.toString() as T).toList();
      case const (int):
        return value.map((e) {
          if (e is int) {
            return e as T;
          } else if (e is double) {
            return e.toInt() as T;
          } else if (e is String) {
            return (int.tryParse(e) ?? 0) as T;
          } else if (e is bool) {
            return (e ? 1 : 0) as T;
          } else {
            return 0 as T;
          }
        }).toList();
      case const (double):
        return value.map((e) {
          if (e is double) {
            return e as T;
          } else if (e is int) {
            return e.toDouble() as T;
          } else if (e is String) {
            return (double.tryParse(e) ?? 0.0) as T;
          } else if (e is bool) {
            return (e ? 1.0 : 0.0) as T;
          } else {
            return 0.0 as T;
          }
        }).toList();
      case const (bool):
        return value.map((e) {
          if (e is bool) {
            return e as T;
          } else if (e is int || e is double) {
            return (e == 1 || e == 1.0) as T;
          } else {
            return false as T;
          }
        }).toList();
      default:
        log(
          "Type ${T.runtimeType} is not supported in parseList",
          name: "JPE - _parsing",
        );
        return null;
    }
  }
}