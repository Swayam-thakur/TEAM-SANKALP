import 'address_model.dart';
import 'app_enums.dart';
import 'model_utils.dart';

class BookingModel {
  const BookingModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.serviceName,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.amountEstimate,
    this.notes,
    this.workerId,
    this.scheduledAt,
    this.paymentMethod,
    this.paymentStatus = PaymentStatus.pending,
    this.chatRoomId,
    this.requestedWorkerIds = const [],
  });

  final String id;
  final String userId;
  final String? workerId;
  final String serviceId;
  final String serviceName;
  final AddressModel address;
  final String? notes;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime? scheduledAt;
  final double amountEstimate;
  final String? paymentMethod;
  final PaymentStatus paymentStatus;
  final String? chatRoomId;
  final List<String> requestedWorkerIds;

  BookingModel copyWith({
    String? id,
    String? userId,
    String? workerId,
    String? serviceId,
    String? serviceName,
    AddressModel? address,
    String? notes,
    BookingStatus? status,
    DateTime? createdAt,
    DateTime? scheduledAt,
    double? amountEstimate,
    String? paymentMethod,
    PaymentStatus? paymentStatus,
    String? chatRoomId,
    List<String>? requestedWorkerIds,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workerId: workerId ?? this.workerId,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      amountEstimate: amountEstimate ?? this.amountEstimate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      requestedWorkerIds: requestedWorkerIds ?? this.requestedWorkerIds,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'workerId': workerId,
        'serviceId': serviceId,
        'serviceName': serviceName,
        'address': address.toJson(),
        'notes': notes,
        'status': status.name,
        'createdAt': serializeDate(createdAt),
        'scheduledAt': scheduledAt == null ? null : serializeDate(scheduledAt!),
        'amountEstimate': amountEstimate,
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentStatus.name,
        'chatRoomId': chatRoomId,
        'requestedWorkerIds': requestedWorkerIds,
      };

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      workerId: json['workerId'] as String?,
      serviceId: json['serviceId'] as String? ?? '',
      serviceName: json['serviceName'] as String? ?? '',
      address: AddressModel.fromJson(
        Map<String, dynamic>.from(json['address'] as Map? ?? const {}),
      ),
      notes: json['notes'] as String?,
      status: BookingStatus.values.firstWhere(
        (item) => item.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: parseDate(json['createdAt']),
      scheduledAt:
          json['scheduledAt'] == null ? null : parseDate(json['scheduledAt']),
      amountEstimate: parseDouble(json['amountEstimate']),
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: PaymentStatus.values.firstWhere(
        (item) => item.name == json['paymentStatus'],
        orElse: () => PaymentStatus.pending,
      ),
      chatRoomId: json['chatRoomId'] as String?,
      requestedWorkerIds:
          List<String>.from(json['requestedWorkerIds'] as List? ?? const []),
    );
  }
}

