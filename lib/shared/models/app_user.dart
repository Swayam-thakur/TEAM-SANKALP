import 'app_enums.dart';
import 'model_utils.dart';

class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    this.email,
    this.photoUrl,
    this.rating = 0,
    this.notificationToken,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final UserRole role;
  final String? photoUrl;
  final double rating;
  final String? notificationToken;
  final DateTime createdAt;

  AppUser copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    UserRole? role,
    String? photoUrl,
    double? rating,
    String? notificationToken,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      rating: rating ?? this.rating,
      notificationToken: notificationToken ?? this.notificationToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'role': role.name,
        'photoUrl': photoUrl,
        'rating': rating,
        'notificationToken': notificationToken,
        'createdAt': serializeDate(createdAt),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String?,
      role: UserRole.values.firstWhere(
        (item) => item.name == json['role'],
        orElse: () => UserRole.user,
      ),
      photoUrl: json['photoUrl'] as String?,
      rating: parseDouble(json['rating']),
      notificationToken: json['notificationToken'] as String?,
      createdAt: parseDate(json['createdAt']),
    );
  }
}

