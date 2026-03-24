DateTime parseDate(dynamic raw) {
  if (raw is DateTime) {
    return raw;
  }
  if (raw is String) {
    return DateTime.tryParse(raw)?.toLocal() ?? DateTime.now();
  }
  if (raw != null && raw.runtimeType.toString() == 'Timestamp') {
    return raw.toDate() as DateTime;
  }
  return DateTime.now();
}

String serializeDate(DateTime value) => value.toUtc().toIso8601String();

double parseDouble(dynamic raw) {
  if (raw is double) {
    return raw;
  }
  if (raw is int) {
    return raw.toDouble();
  }
  if (raw is String) {
    return double.tryParse(raw) ?? 0;
  }
  return 0;
}

