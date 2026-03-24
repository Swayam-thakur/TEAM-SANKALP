import 'app_enums.dart';
import 'model_utils.dart';

class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.bookingId,
    this.read = false,
  });

  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final String? bookingId;
  final bool read;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
        'type': type.name,
        'bookingId': bookingId,
        'read': read,
        'createdAt': serializeDate(createdAt),
      };

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      type: NotificationType.values.firstWhere(
        (item) => item.name == json['type'],
        orElse: () => NotificationType.bookingUpdate,
      ),
      bookingId: json['bookingId'] as String?,
      read: json['read'] as bool? ?? false,
      createdAt: parseDate(json['createdAt']),
    );
  }
}

