import 'model_utils.dart';

class ServiceCategory {
  const ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconKey,
    required this.basePrice,
    required this.isActive,
  });

  final String id;
  final String name;
  final String description;
  final String iconKey;
  final double basePrice;
  final bool isActive;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'iconKey': iconKey,
        'basePrice': basePrice,
        'isActive': isActive,
      };

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iconKey: json['iconKey'] as String? ?? 'home_repair_service',
      basePrice: parseDouble(json['basePrice']),
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}

