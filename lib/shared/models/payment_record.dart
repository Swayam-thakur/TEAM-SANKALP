import 'app_enums.dart';
import 'model_utils.dart';

class PaymentRecord {
  const PaymentRecord({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.method,
    required this.status,
    required this.createdAt,
    this.userId,
    this.workerId,
    this.transactionReference,
  });

  final String id;
  final String bookingId;
  final String? userId;
  final String? workerId;
  final double amount;
  final String method;
  final PaymentStatus status;
  final String? transactionReference;
  final DateTime createdAt;

  factory PaymentRecord.pending({
    required String bookingId,
    required double amount,
    required String method,
  }) {
    return PaymentRecord(
      id: '${bookingId}_payment',
      bookingId: bookingId,
      amount: amount,
      method: method,
      status: PaymentStatus.pending,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingId': bookingId,
        'userId': userId,
        'workerId': workerId,
        'amount': amount,
        'method': method,
        'status': status.name,
        'transactionReference': transactionReference,
        'createdAt': serializeDate(createdAt),
      };

  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      id: json['id'] as String? ?? '',
      bookingId: json['bookingId'] as String? ?? '',
      userId: json['userId'] as String?,
      workerId: json['workerId'] as String?,
      amount: parseDouble(json['amount']),
      method: json['method'] as String? ?? '',
      status: PaymentStatus.values.firstWhere(
        (item) => item.name == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
      transactionReference: json['transactionReference'] as String?,
      createdAt: parseDate(json['createdAt']),
    );
  }
}

