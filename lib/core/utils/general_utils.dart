import 'dart:developer';
import 'package:flutter/foundation.dart';

void printDM(
  String title, {
  String name = '',
}) {
  if (kDebugMode) {
    log(title, name: name);
  }
  // print("$name : $title");
}

void printModel({required String name, required Function parsing}) {
  printDM("******************** $name *********************");
  parsing();
  printDM("************************************************");
}
