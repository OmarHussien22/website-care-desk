extension StringExtension on String? {
  double toDobule() {
    return double.tryParse(this ?? "") ?? 0.0;
  }

  int toInt() {
    return int.tryParse(this ?? "") ?? 0;
  }
}
