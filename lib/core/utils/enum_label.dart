String enumLabel(Object? value) {
  if (value == null) {
    return '';
  }

  final text = value.toString();
  final dotIndex = text.lastIndexOf('.');
  if (dotIndex == -1 || dotIndex == text.length - 1) {
    return text;
  }
  return text.substring(dotIndex + 1);
}

