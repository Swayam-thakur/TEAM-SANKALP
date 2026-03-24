import 'model_utils.dart';

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentAt,
  });

  final String id;
  final String roomId;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime sentAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'roomId': roomId,
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'sentAt': serializeDate(sentAt),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String? ?? '',
      roomId: json['roomId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      receiverId: json['receiverId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      sentAt: parseDate(json['sentAt']),
    );
  }
}

