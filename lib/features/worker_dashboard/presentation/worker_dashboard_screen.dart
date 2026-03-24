import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../../shared/models/booking_model.dart';
import '../../../shared/providers/app_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../booking/application/booking_controller.dart';
import '../../profile/presentation/worker_profile_screen.dart';
import '../../worker_jobs/presentation/active_job_details_screen.dart';
import '../../worker_jobs/presentation/incoming_job_request_screen.dart';
import '../../worker_jobs/presentation/service_selection_screen.dart';
import '../../worker_jobs/presentation/worker_map_screen.dart';
import '../application/worker_dashboard_controller.dart';
import 'earnings_screen.dart';

class WorkerDashboardScreen extends ConsumerStatefulWidget {
  const WorkerDashboardScreen({super.key});

  static const routePath = '/worker-dashboard';

  @override
  ConsumerState<WorkerDashboardScreen> createState() =>
      _WorkerDashboardScreenState();
}

class _WorkerDashboardScreenState extends ConsumerState<WorkerDashboardScreen> {
  final Set<String> _alertedRequestIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final worker = ref.watch(workerProfileProvider).valueOrNull;
    final workerId = ref.watch(currentUserIdProvider);
    final requests = workerId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(incomingRequestsProvider(workerId));
    final jobs = workerId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(workerBookingsProvider(workerId));

    if (workerId != null) {
      ref.listen<AsyncValue<List<BookingModel>>>(
        incomingRequestsProvider(workerId),
        (previous, next) {
          final items = next.valueOrNull ?? const <BookingModel>[];
          final fresh = items.where((item) => !_alertedRequestIds.contains(item.id));
          for (final request in fresh) {
            _alertedRequestIds.add(request.id);
            ref.read(notificationServiceProvider).showLocalAlert(
                  id: request.id.hashCode,
                  title: 'New work request',
                  body: '${request.serviceName} request received.',
                );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) {
                return;
              }
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('New work request'),
                    content: Text(
                      '${request.serviceName} request received. Review it from the dashboard.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: const Text('Dismiss'),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.push(
                            IncomingJobRequestScreen.buildPath(request.id),
                          );
                        },
                        child: const Text('Open'),
                      ),
                    ],
                  );
                },
              );
            });
          }
        },
      );
    }

    return AppShell(
      title: 'Worker dashboard',
      actions: [
        IconButton(
          onPressed: () => context.push(WorkerProfileScreen.routePath),
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ],
      body: ListView(
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker?.name ?? 'Worker',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Verification: ${enumLabel(worker?.verificationStatus).isEmpty ? 'pending' : enumLabel(worker?.verificationStatus)}',
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: worker?.online ?? false,
                  title: const Text('Available for nearby jobs'),
                  onChanged: workerId == null
                      ? null
                      : (value) async {
                          await ref
                              .read(workerDashboardControllerProvider.notifier)
                              .updateAvailability(
                                workerId: workerId,
                                online: value,
                                availability: value
                                    ? WorkerAvailability.online
                                    : WorkerAvailability.offline,
                              );
                          if (value) {
                            final position = await ref
                                .read(locationServiceProvider)
                                .determinePosition();
                            await ref
                                .read(workerDashboardControllerProvider.notifier)
                                .updateLocation(
                                  workerId: workerId,
                                  latitude: position.latitude,
                                  longitude: position.longitude,
                                  serviceIds: worker?.serviceIds ?? const [],
                                );
                          }
                        },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () => context.push(ServiceSelectionScreen.routePath),
                  icon: const Icon(Icons.grid_view_rounded),
                  label: const Text('Services'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.push(EarningsScreen.routePath),
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  label: const Text('Earnings'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: workerId == null
                      ? null
                      : () => context.push(WorkerMapScreen.buildPath('live')),
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Map'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Incoming requests',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          requests.when(
            data: (items) {
              if (items.isEmpty) {
                return const Text('No incoming requests right now.');
              }
              return Column(
                children: items
                    .map(
                      (request) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _IncomingRequestCard(
                          request: request,
                          onOpen: () => context.push(
                            IncomingJobRequestScreen.buildPath(request.id),
                          ),
                          onApprove: workerId == null
                              ? null
                              : () async {
                                  await ref
                                      .read(bookingControllerProvider.notifier)
                                      .acceptBooking(
                                        bookingId: request.id,
                                        workerId: workerId,
                                      );
                                  if (!context.mounted) {
                                    return;
                                  }
                                  context.push(
                                    ActiveJobDetailsScreen.buildPath(request.id),
                                  );
                                },
                          onReject: workerId == null
                              ? null
                              : () async {
                                  await ref
                                      .read(bookingControllerProvider.notifier)
                                      .rejectBookingRequest(
                                        bookingId: request.id,
                                        workerId: workerId,
                                      );
                                },
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString()),
          ),
          const SizedBox(height: 24),
          Text(
            'Active jobs',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          jobs.when(
            data: (items) {
              if (items.isEmpty) {
                return const Text('No active or past jobs yet.');
              }
              return Column(
                children: items
                    .take(3)
                    .map(
                      (job) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SectionCard(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(job.serviceName),
                            subtitle: Text(enumLabel(job.status)),
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

class _IncomingRequestCard extends StatelessWidget {
  const _IncomingRequestCard({
    required this.request,
    required this.onOpen,
    required this.onApprove,
    required this.onReject,
  });

  final BookingModel request;
  final VoidCallback onOpen;
  final Future<void> Function()? onApprove;
  final Future<void> Function()? onReject;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: onOpen,
            title: Text(request.serviceName),
            subtitle: Text(request.address.fullAddress),
            trailing: const Icon(Icons.notifications_active_rounded),
          ),
          const SizedBox(height: 8),
          if (request.notes?.isNotEmpty == true)
            Text('Notes: ${request.notes}'),
          const SizedBox(height: 8),
          Text('Estimated amount: INR ${request.amountEstimate.toStringAsFixed(0)}'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onApprove == null ? null : () => onApprove!.call(),
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Approve'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onReject == null ? null : () => onReject!.call(),
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Reject'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
