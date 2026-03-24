import 'model_utils.dart';

class WorkerLocation {
  const WorkerLocation({
    required this.workerId,
    required this.latitude,
    required this.longitude,
    required this.updatedAt,
    this.geohash,
    this.online = false,
    this.serviceIds = const [],
  });

  final String workerId;
  final double latitude;
  final double longitude;
  final String? geohash;
  final bool online;
  final List<String> serviceIds;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'workerId': workerId,
        'latitude': latitude,
        'longitude': longitude,
        'geohash': geohash,
        'online': online,
        'serviceIds': serviceIds,
        'updatedAt': serializeDate(updatedAt),
      };

  factory WorkerLocation.fromJson(Map<String, dynamic> json) {
    return WorkerLocation(
      workerId: json['workerId'] as String? ?? '',
      latitude: parseDouble(json['latitude']),
      longitude: parseDouble(json['longitude']),
      geohash: json['geohash'] as String?,
      online: json['online'] as bool? ?? false,
      serviceIds: List<String>.from(json['serviceIds'] as List? ?? const []),
      updatedAt: parseDate(json['updatedAt']),
    );
  }
}
