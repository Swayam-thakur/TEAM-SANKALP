import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../booking/application/booking_controller.dart';
import '../../chat/presentation/chat_screen.dart';
import '../../payments/presentation/payment_screen.dart';
import 'worker_map_screen.dart';

class ActiveJobDetailsScreen extends ConsumerWidget {
  const ActiveJobDetailsScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/worker/job/:bookingId';

  static String buildPath(String bookingId) => '/worker/job/$bookingId';

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingByIdProvider(bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Active job')),
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
                      icon: Icons.timeline_rounded,
                    ),
                    DetailTile(
                      label: 'Service address',
                      value: item.address.fullAddress,
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _StatusAction(
                    label: 'On the way',
                    onTap: () => ref
                        .read(bookingControllerProvider.notifier)
                        .updateStatus(item.id, BookingStatus.workerOnTheWay),
                  ),
                  _StatusAction(
                    label: 'Arrived',
                    onTap: () => ref
                        .read(bookingControllerProvider.notifier)
                        .updateStatus(item.id, BookingStatus.arrived),
                  ),
                  _StatusAction(
                    label: 'Start work',
                    onTap: () => ref
                        .read(bookingControllerProvider.notifier)
                        .updateStatus(item.id, BookingStatus.workStarted),
                  ),
                  _StatusAction(
                    label: 'Complete',
                    onTap: () => ref
                        .read(bookingControllerProvider.notifier)
                        .updateStatus(item.id, BookingStatus.paymentPending),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.push(
                        WorkerMapScreen.buildPath(item.id),
                      ),
                      icon: const Icon(Icons.map_outlined),
                      label: const Text('Navigation'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.push(
                        ChatScreen.buildPath(item.chatRoomId ?? 'chat_${item.id}'),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                      label: const Text('Chat'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (item.status == BookingStatus.paymentPending)
                FilledButton.icon(
                  onPressed: () => context.push(
                    PaymentScreen.buildPath(item.id),
                  ),
                  icon: const Icon(Icons.payments_outlined),
                  label: const Text('Open payment collection'),
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

class _StatusAction extends StatelessWidget {
  const _StatusAction({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onTap,
      child: Text(label),
    );
  }
}
