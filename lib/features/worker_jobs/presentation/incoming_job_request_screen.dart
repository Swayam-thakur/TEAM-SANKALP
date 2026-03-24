import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../booking/application/booking_controller.dart';
import 'active_job_details_screen.dart';

class IncomingJobRequestScreen extends ConsumerWidget {
  const IncomingJobRequestScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/worker/request/:bookingId';

  static String buildPath(String bookingId) => '/worker/request/$bookingId';

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingByIdProvider(bookingId));
    final workerId = ref.watch(currentUserIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Incoming request')),
      body: booking.when(
        data: (item) {
          if (item == null || workerId == null) {
            return const Center(child: Text('Request not available.'));
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
                      label: 'Address',
                      value: item.address.fullAddress,
                      icon: Icons.location_on_outlined,
                    ),
                    DetailTile(
                      label: 'Notes',
                      value: item.notes?.isEmpty ?? true
                          ? 'No customer note'
                          : item.notes!,
                      icon: Icons.notes_rounded,
                    ),
                    DetailTile(
                      label: 'Estimated amount',
                      value: 'INR ${item.amountEstimate.toStringAsFixed(0)}',
                      icon: Icons.currency_rupee_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Accept job',
                icon: Icons.check_circle_outline_rounded,
                onPressed: () async {
                  await ref.read(bookingControllerProvider.notifier).acceptBooking(
                        bookingId: item.id,
                        workerId: workerId,
                      );
                  if (!context.mounted) {
                    return;
                  }
                  context.push(ActiveJobDetailsScreen.buildPath(item.id));
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  await ref
                      .read(bookingControllerProvider.notifier)
                      .rejectBookingRequest(
                        bookingId: item.id,
                        workerId: workerId,
                      );
                  if (!context.mounted) {
                    return;
                  }
                  context.pop();
                },
                icon: const Icon(Icons.close_rounded),
                label: const Text('Reject request'),
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
