import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/status_chip.dart';
import '../application/booking_controller.dart';
import 'assigned_worker_tracking_screen.dart';
import 'booking_details_screen.dart';

class SearchingWorkerScreen extends ConsumerWidget {
  const SearchingWorkerScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/booking/searching/:bookingId';

  static String buildPath(String bookingId) => '/booking/searching/$bookingId';

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingByIdProvider(bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Searching nearby workers')),
      body: Center(
        child: booking.when(
          data: (item) {
            if (item == null) {
              return const Text('Booking not found.');
            }
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  Text(
                    'Looking for nearby ${item.serviceName} workers',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  StatusChip(label: enumLabel(item.status)),
                  const SizedBox(height: 24),
                  if (item.workerId != null)
                    FilledButton(
                      onPressed: () => context.push(
                        AssignedWorkerTrackingScreen.buildPath(item.id),
                      ),
                      child: const Text('View live tracking'),
                    ),
                  TextButton(
                    onPressed: () => context.push(
                      BookingDetailsScreen.buildPath(item.id),
                    ),
                    child: const Text('Open booking details'),
                  ),
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
