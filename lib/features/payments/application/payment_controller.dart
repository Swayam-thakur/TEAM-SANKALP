import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/payment_record.dart';
import '../../../shared/providers/app_providers.dart';

final workerWalletProvider =
    StreamProvider.family<List<PaymentRecord>, String>((ref, workerId) {
  return ref.watch(paymentRepositoryProvider).watchWorkerWallet(workerId);
});

final paymentControllerProvider =
    AsyncNotifierProvider<PaymentController, void>(PaymentController.new);

class PaymentController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> createPayment({
    required String bookingId,
    required double amount,
    required String method,
    String? userId,
    String? workerId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final payment = await ref.read(paymentGatewayProvider).createPayment(
            bookingId: bookingId,
            amount: amount,
            method: method,
          );
      await ref.read(paymentRepositoryProvider).savePayment(
            PaymentRecord(
              id: payment.id,
              bookingId: payment.bookingId,
              userId: userId,
              workerId: workerId,
              amount: payment.amount,
              method: payment.method,
              status: payment.status,
              transactionReference: payment.transactionReference,
              createdAt: payment.createdAt,
            ),
          );
    });
  }
}

