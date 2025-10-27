class DateFormatter {
  String _toShow(int number) {
    if (number < 10) {
      return '0$number';
    }
    return '$number';
  }

  String toBrazilFormat(DateTime? date) {
    if (date == null) {
      return '---';
    }
    final handledDate =
        '${_toShow(date.day)}/${_toShow(date.month)}/${date.year}';
    return handledDate;
  }
}
