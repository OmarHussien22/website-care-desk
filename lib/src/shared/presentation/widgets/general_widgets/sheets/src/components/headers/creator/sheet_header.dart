import 'package:flutter/material.dart';
import '../../../../sheet_header.dart';
import '../interface/sheet_header_interface.dart';
import '../options/sheet_header_option.dart';
import '../resources/sheet_header_basic.dart';

class SheetHeader {
  SheetHeader._();

  static final instance = SheetHeader._();

  SheetHeaderInterface basic({
    String title = '',
    SheetHeaderOptions? options,
    Widget? action,
    Widget? closeAction,
    Function()? onClose,
  }) {
    return SheetHeaderBasic(
      title: title,
      action: action,
      closeAction: closeAction,
      options: options,
      onClose: onClose,
    );
  }
}
