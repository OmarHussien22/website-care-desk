extension DoubleExtensions on double {
  String orAbout(int precision) {
    return toStringAsFixed(precision).replaceAll(RegExp(r'\.0+$'), '');
  }
}
