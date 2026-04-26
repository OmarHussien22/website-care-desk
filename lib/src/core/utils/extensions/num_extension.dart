extension DoubleExtension on num {
  /// Returns the integer value if the number is a whole number, otherwise returns the number with 2 decimal places.
  /// Ex: 2.0 => 2, 2.5 => 2.5
  num orAbout([int digits = 2]) {
    if ((this * 10) % 10 == 0) {
      return toInt();
    }
    return double.parse(toStringAsFixed(digits));
  }
}
