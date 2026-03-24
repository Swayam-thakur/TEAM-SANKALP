import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    required this.label,
    required this.value,
    super.key,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon == null ? null : Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

