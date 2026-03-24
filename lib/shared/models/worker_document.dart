import 'app_enums.dart';
import 'model_utils.dart';

class WorkerDocument {
  const WorkerDocument({
    required this.id,
    required this.workerId,
    required this.type,
    required this.fileUrl,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String workerId;
  final DocumentType type;
  final String fileUrl;
  final VerificationStatus status;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'workerId': workerId,
        'type': type.name,
        'fileUrl': fileUrl,
        'status': status.name,
        'createdAt': serializeDate(createdAt),
      };

  factory WorkerDocument.fromJson(Map<String, dynamic> json) {
    return WorkerDocument(
      id: json['id'] as String? ?? '',
      workerId: json['workerId'] as String? ?? '',
      type: DocumentType.values.firstWhere(
        (item) => item.name == json['type'],
        orElse: () => DocumentType.idProof,
      ),
      fileUrl: json['fileUrl'] as String? ?? '',
      status: VerificationStatus.values.firstWhere(
        (item) => item.name == json['status'],
        orElse: () => VerificationStatus.pending,
      ),
      createdAt: parseDate(json['createdAt']),
    );
  }
}

