import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../application/notifications_controller.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static const routePath = '/notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);
    final notifications = userId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(notificationsProvider(userId));

    return AppShell(
      title: 'Notifications',
      body: notifications.when(
        data: (items) {
          final list = items.cast<dynamic>();
          if (list.isEmpty) {
            return const Center(child: Text('No notifications right now.'));
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final notification = list[index];
              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () async {
                  await ref
                      .read(notificationsControllerProvider.notifier)
                      .markAsRead(notification.id.toString());
                },
                child: SectionCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(notification.title.toString()),
                    subtitle: Text(notification.body.toString()),
                    trailing: notification.read == true
                        ? const Icon(Icons.done_all_rounded)
                        : const Icon(Icons.circle, size: 12),
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

