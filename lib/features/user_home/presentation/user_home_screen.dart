import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/service_icon_mapper.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/section_card.dart';
import '../../booking/presentation/booking_history_screen.dart';
import '../../notifications/presentation/notifications_screen.dart';
import '../../profile/presentation/user_profile_screen.dart';
import '../application/service_catalog_controller.dart';
import '../../services/presentation/service_details_screen.dart';

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  static const routePath = '/user-home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesProvider);
    final filteredServices = ref.watch(filteredServicesProvider);

    return AppShell(
      title: 'QuickSeva',
      actions: [
        IconButton(
          onPressed: () => context.push(BookingHistoryScreen.routePath),
          icon: const Icon(Icons.history_rounded),
        ),
        IconButton(
          onPressed: () => context.push(NotificationsScreen.routePath),
          icon: const Icon(Icons.notifications_outlined),
        ),
        IconButton(
          onPressed: () => context.push(UserProfileScreen.routePath),
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book nearby services with live worker tracking',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search services',
            ),
            onChanged: (value) {
              ref.read(serviceSearchQueryProvider.notifier).state = value;
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AsyncValueWidget(
              value: services,
              loadingMessage: 'Loading service categories',
              data: (_) {
                if (filteredServices.isEmpty) {
                  return const Center(
                    child: Text('No service categories match your search.'),
                  );
                }

                return ListView.separated(
                  itemCount: filteredServices.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final service = filteredServices[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => context.push(
                        ServiceDetailsScreen.buildPath(service.id),
                      ),
                      child: SectionCard(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              child: Icon(serviceIconFor(service.iconKey)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(service.description),
                                ],
                              ),
                            ),
                            Text(
                              'INR ${service.basePrice.toStringAsFixed(0)}+',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
