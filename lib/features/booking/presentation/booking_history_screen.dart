import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../application/booking_controller.dart';
import 'booking_details_screen.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  static const routePath = '/booking-history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);
    final bookings = userId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(userBookingsProvider(userId));

    return AppShell(
      title: 'Booking history',
      body: bookings.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No bookings yet.'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final booking = items[index];
              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => context.push(
                  BookingDetailsScreen.buildPath(booking.id),
                ),
                child: SectionCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(booking.serviceName),
                    subtitle: Text(
                      '${enumLabel(booking.status)} | INR ${booking.amountEstimate.toStringAsFixed(0)}',
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
