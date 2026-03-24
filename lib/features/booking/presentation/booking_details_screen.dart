import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../payments/presentation/payment_screen.dart';
import '../../ratings/presentation/review_screen.dart';
import '../application/booking_controller.dart';

class BookingDetailsScreen extends ConsumerWidget {
  const BookingDetailsScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/booking/:bookingId';

  static String buildPath(String bookingId) => '/booking/$bookingId';

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingByIdProvider(bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Booking details')),
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
                    const SizedBox(height: 16),
                    DetailTile(
                      label: 'Status',
                      value: enumLabel(item.status),
                      icon: Icons.task_alt_rounded,
                    ),
                    DetailTile(
                      label: 'Address',
                      value: item.address.fullAddress,
                      icon: Icons.location_on_outlined,
                    ),
                    DetailTile(
                      label: 'Notes',
                      value: item.notes?.isEmpty ?? true
                          ? 'No extra notes'
                          : item.notes!,
                      icon: Icons.notes_rounded,
                    ),
                    DetailTile(
                      label: 'Estimate',
                      value: 'INR ${item.amountEstimate.toStringAsFixed(0)}',
                      icon: Icons.currency_rupee_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (item.status == BookingStatus.paymentPending ||
                  item.status == BookingStatus.paymentCompleted)
                PrimaryButton(
                  label: 'Open payment',
                  icon: Icons.payments_rounded,
                  onPressed: () => context.push(
                    PaymentScreen.buildPath(item.id),
                  ),
                ),
              if (item.status == BookingStatus.completed)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(
                      ReviewScreen.buildPath(item.id),
                    ),
                    icon: const Icon(Icons.star_outline_rounded),
                    label: const Text('Rate this booking'),
                  ),
                ),
              if (item.status != BookingStatus.completed &&
                  item.status != BookingStatus.cancelled)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextButton(
                    onPressed: () async {
                      await ref
                          .read(bookingControllerProvider.notifier)
                          .cancelBooking(item.id);
                    },
                    child: const Text('Cancel booking'),
                  ),
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
