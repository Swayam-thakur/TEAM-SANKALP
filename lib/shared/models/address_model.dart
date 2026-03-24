import 'model_utils.dart';

class AddressModel {
  const AddressModel({
    required this.id,
    required this.label,
    required this.addressLine1,
    required this.addressLine2,
    required this.latitude,
    required this.longitude,
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String addressLine1;
  final String addressLine2;
  final double latitude;
  final double longitude;
  final bool isDefault;

  String get fullAddress => '$addressLine1, $addressLine2';

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'latitude': latitude,
        'longitude': longitude,
        'isDefault': isDefault,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      addressLine1: json['addressLine1'] as String? ?? '',
      addressLine2: json['addressLine2'] as String? ?? '',
      latitude: parseDouble(json['latitude']),
      longitude: parseDouble(json['longitude']),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }
}

