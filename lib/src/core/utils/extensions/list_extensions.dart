extension ListExtensions<T> on List<T>? {
  T? firstWhereOrNull(bool Function(T) test) {
    if (this == null) return null;
    for (T element in this!) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
