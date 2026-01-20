extension StringExtension on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  DateTime? fromDDMMYYYY() {
    final parts = split('/');
    if (parts.length == 3) {
      try {
        return DateTime(
          int.parse(parts[2]), // ano
          int.parse(parts[1]), // mês
          int.parse(parts[0]), // dia
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
