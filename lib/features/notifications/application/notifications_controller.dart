import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/notification_item.dart';
import '../../../shared/providers/app_providers.dart';

final notificationsProvider =
    StreamProvider.family<List<NotificationItem>, String>((ref, userId) {
  return ref.watch(notificationRepositoryProvider).watchNotifications(userId);
});

final notificationsControllerProvider =
    AsyncNotifierProvider<NotificationsController, void>(
  NotificationsController.new,
);

class NotificationsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> markAsRead(String notificationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(notificationRepositoryProvider).markAsRead(notificationId);
    });
  }
}
