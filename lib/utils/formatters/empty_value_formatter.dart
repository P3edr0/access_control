class EmptyValueFormatter {
  String call(String? value) {
    if (value == null) {
      return 'vazio';
    }
    if (value.isEmpty) {
      return 'vazio';
    }
    return value;
  }
}
