import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../utils/general_utils.dart';

class ShowcaseService {
  ShowcaseService._internal();

  static final ShowcaseService instance = ShowcaseService._internal();

  final List<GlobalKey> _keys = [];

  GlobalKey addKey() {
    final key = GlobalKey();
    _keys.add(key);
    return key;
  }

  void startShowcase(BuildContext context) {
    printDM('_keys length: ${_keys.length}');
    if (_keys.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase(_keys);
      });
    }
  }

  void clear() {
    _keys.clear();
  }
}
