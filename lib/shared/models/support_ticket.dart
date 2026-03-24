import 'app_enums.dart';
import 'model_utils.dart';

class SupportTicket {
  const SupportTicket({
    required this.id,
    required this.userId,
    required this.subject,
    required this.description,
    required this.createdAt,
    this.status = SupportTicketStatus.open,
  });

  final String id;
  final String userId;
  final String subject;
  final String description;
  final DateTime createdAt;
  final SupportTicketStatus status;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'subject': subject,
        'description': description,
        'status': status.name,
        'createdAt': serializeDate(createdAt),
      };

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: SupportTicketStatus.values.firstWhere(
        (item) => item.name == json['status'],
        orElse: () => SupportTicketStatus.open,
      ),
      createdAt: parseDate(json['createdAt']),
    );
  }
}
