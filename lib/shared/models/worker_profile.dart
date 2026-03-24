import 'app_enums.dart';
import 'model_utils.dart';

class WorkerProfile {
  const WorkerProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.serviceIds,
    required this.radiusKm,
    required this.createdAt,
    this.profilePhotoUrl,
    this.email,
    this.availability = WorkerAvailability.offline,
    this.verificationStatus = VerificationStatus.pending,
    this.rating = 0,
    this.completedJobs = 0,
    this.online = false,
    this.currentBookingId,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String? profilePhotoUrl;
  final List<String> serviceIds;
  final double radiusKm;
  final WorkerAvailability availability;
  final VerificationStatus verificationStatus;
  final double rating;
  final int completedJobs;
  final bool online;
  final String? currentBookingId;
  final DateTime createdAt;

  bool get isVerified => verificationStatus == VerificationStatus.approved;

  WorkerProfile copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profilePhotoUrl,
    List<String>? serviceIds,
    double? radiusKm,
    WorkerAvailability? availability,
    VerificationStatus? verificationStatus,
    double? rating,
    int? completedJobs,
    bool? online,
    String? currentBookingId,
    DateTime? createdAt,
  }) {
    return WorkerProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      serviceIds: serviceIds ?? this.serviceIds,
      radiusKm: radiusKm ?? this.radiusKm,
      availability: availability ?? this.availability,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      online: online ?? this.online,
      currentBookingId: currentBookingId ?? this.currentBookingId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'profilePhotoUrl': profilePhotoUrl,
        'serviceIds': serviceIds,
        'radiusKm': radiusKm,
        'availability': availability.name,
        'verificationStatus': verificationStatus.name,
        'rating': rating,
        'completedJobs': completedJobs,
        'online': online,
        'currentBookingId': currentBookingId,
        'createdAt': serializeDate(createdAt),
      };

  factory WorkerProfile.fromJson(Map<String, dynamic> json) {
    return WorkerProfile(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      serviceIds: List<String>.from(json['serviceIds'] as List? ?? const []),
      radiusKm: parseDouble(json['radiusKm']),
      availability: WorkerAvailability.values.firstWhere(
        (item) => item.name == json['availability'],
        orElse: () => WorkerAvailability.offline,
      ),
      verificationStatus: VerificationStatus.values.firstWhere(
        (item) => item.name == json['verificationStatus'],
        orElse: () => VerificationStatus.pending,
      ),
      rating: parseDouble(json['rating']),
      completedJobs: json['completedJobs'] as int? ?? 0,
      online: json['online'] as bool? ?? false,
      currentBookingId: json['currentBookingId'] as String?,
      createdAt: parseDate(json['createdAt']),
    );
  }
}

