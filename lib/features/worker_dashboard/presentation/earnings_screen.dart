import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../payments/application/payment_controller.dart';
import '../application/worker_dashboard_controller.dart';

class EarningsScreen extends ConsumerWidget {
  const EarningsScreen({super.key});

  static const routePath = '/earnings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workerId = ref.watch(currentUserIdProvider);
    final earnings = workerId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(workerEarningsProvider(workerId));
    final wallet = workerId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(workerWalletProvider(workerId));

    return AppShell(
      title: 'Earnings and wallet',
      body: ListView(
        children: [
          SectionCard(
            child: wallet.when(
              data: (items) {
                final total = items.fold<double>(
                  0,
                  (sum, item) => sum + item.amount,
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wallet balance',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'INR ${total.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(error.toString()),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Payout history',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          earnings.when(
            data: (items) {
              if (items.isEmpty) {
                return const Text('No earnings records yet.');
              }
              return Column(
                children: items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SectionCard(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('Booking ${item.bookingId}'),
                            subtitle: Text(
                              'Net: INR ${item.netAmount.toStringAsFixed(0)} | Commission: INR ${item.commissionAmount.toStringAsFixed(0)}',
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString()),
          ),
        ],
      ),
    );
  }
}

