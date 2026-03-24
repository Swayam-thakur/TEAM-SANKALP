import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../booking/application/booking_controller.dart';
import '../application/payment_controller.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/payment/:bookingId';

  static String buildPath(String bookingId) => '/payment/$bookingId';

  final String bookingId;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  String _method = AppConstants.cashPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingByIdProvider(widget.bookingId));
    final state = ref.watch(paymentControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: booking.when(
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Booking not found.'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.serviceName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Payable amount: INR ${item.amountEstimate.toStringAsFixed(0)}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RadioListTile<String>(
                value: AppConstants.cashPaymentMethod,
                groupValue: _method,
                onChanged: (value) => setState(() => _method = value!),
                title: const Text('Cash on service'),
              ),
              RadioListTile<String>(
                value: AppConstants.onlinePaymentMethod,
                groupValue: _method,
                onChanged: (value) => setState(() => _method = value!),
                title: const Text('Online payment placeholder'),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Record payment',
                isLoading: state.isLoading,
                icon: Icons.payments_rounded,
                onPressed: () async {
                  await ref.read(paymentControllerProvider.notifier).createPayment(
                        bookingId: item.id,
                        amount: item.amountEstimate,
                        method: _method,
                        userId: item.userId,
                        workerId: item.workerId,
                      );
                  await ref
                      .read(bookingControllerProvider.notifier)
                      .updateStatus(item.id, BookingStatus.paymentCompleted);
                  if (!mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment recorded.')),
                  );
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
