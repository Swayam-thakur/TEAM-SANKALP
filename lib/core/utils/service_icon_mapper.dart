import 'package:flutter/material.dart';

IconData serviceIconFor(String key) {
  switch (key) {
    case 'cleaning_services':
      return Icons.cleaning_services_rounded;
    case 'plumbing':
      return Icons.plumbing_rounded;
    case 'electrical_services':
      return Icons.electrical_services_rounded;
    case 'carpenter':
      return Icons.handyman_rounded;
    case 'beauty':
      return Icons.face_retouching_natural_rounded;
    case 'appliance_repair':
      return Icons.kitchen_rounded;
    default:
      return Icons.home_repair_service_rounded;
  }
}

