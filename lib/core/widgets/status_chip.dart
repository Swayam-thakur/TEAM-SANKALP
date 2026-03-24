import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.label,
    super.key,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: color ?? Theme.of(context).colorScheme.secondaryContainer,
      side: BorderSide.none,
    );
  }
}
