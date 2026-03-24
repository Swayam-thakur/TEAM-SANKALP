import 'model_utils.dart';

class ChatRoom {
  const ChatRoom({
    required this.id,
    required this.bookingId,
    required this.participantIds,
    required this.lastMessageAt,
    this.lastMessage,
  });

  final String id;
  final String bookingId;
  final List<String> participantIds;
  final String? lastMessage;
  final DateTime lastMessageAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingId': bookingId,
        'participantIds': participantIds,
        'lastMessage': lastMessage,
        'lastMessageAt': serializeDate(lastMessageAt),
      };

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as String? ?? '',
      bookingId: json['bookingId'] as String? ?? '',
      participantIds:
          List<String>.from(json['participantIds'] as List? ?? const []),
      lastMessage: json['lastMessage'] as String?,
      lastMessageAt: parseDate(json['lastMessageAt']),
    );
  }
}

