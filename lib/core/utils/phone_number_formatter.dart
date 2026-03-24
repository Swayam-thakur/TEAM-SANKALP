String normalizePhoneNumber(String input) {
  final trimmed = input.trim().replaceAll(RegExp(r'[\s\-()]'), '');
  if (trimmed.isEmpty) {
    return trimmed;
  }

  if (trimmed.startsWith('+')) {
    return trimmed;
  }

  if (trimmed.startsWith('91') && trimmed.length == 12) {
    return '+$trimmed';
  }

  if (trimmed.length == 10) {
    return '+91$trimmed';
  }

  return trimmed;
}

