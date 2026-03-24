import 'model_utils.dart';

class EarningRecord {
  const EarningRecord({
    required this.id,
    required this.bookingId,
    required this.workerId,
    required this.grossAmount,
    required this.commissionAmount,
    required this.netAmount,
    required this.createdAt,
  });

  final String id;
  final String bookingId;
  final String workerId;
  final double grossAmount;
  final double commissionAmount;
  final double netAmount;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingId': bookingId,
        'workerId': workerId,
        'grossAmount': grossAmount,
        'commissionAmount': commissionAmount,
        'netAmount': netAmount,
        'createdAt': serializeDate(createdAt),
      };

  factory EarningRecord.fromJson(Map<String, dynamic> json) {
    return EarningRecord(
      id: json['id'] as String? ?? '',
      bookingId: json['bookingId'] as String? ?? '',
      workerId: json['workerId'] as String? ?? '',
      grossAmount: parseDouble(json['grossAmount']),
      commissionAmount: parseDouble(json['commissionAmount']),
      netAmount: parseDouble(json['netAmount']),
      createdAt: parseDate(json['createdAt']),
    );
  }
}

