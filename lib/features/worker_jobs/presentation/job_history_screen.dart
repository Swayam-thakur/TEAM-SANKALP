import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../booking/application/booking_controller.dart';

class JobHistoryScreen extends ConsumerWidget {
  const JobHistoryScreen({super.key});

  static const routePath = '/worker/job-history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workerId = ref.watch(currentUserIdProvider);
    final jobs = workerId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(workerBookingsProvider(workerId));

    return AppShell(
      title: 'Job history',
      body: jobs.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No jobs yet.'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final job = items[index];
              return SectionCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(job.serviceName),
                  subtitle: Text(
                    '${enumLabel(job.status)} | INR ${job.amountEstimate.toStringAsFixed(0)}',
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
