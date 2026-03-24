import '../../shared/models/payment_record.dart';

abstract class PaymentGateway {
  Future<PaymentRecord> createPayment({
    required String bookingId,
    required double amount,
    required String method,
  });
}

class PlaceholderPaymentGateway implements PaymentGateway {
  @override
  Future<PaymentRecord> createPayment({
    required String bookingId,
    required double amount,
    required String method,
  }) async {
    return PaymentRecord.pending(
      bookingId: bookingId,
      amount: amount,
      method: method,
    );
  }
}

