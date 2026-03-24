import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/support_ticket.dart';
import '../../../shared/providers/app_providers.dart';

final supportTicketsProvider =
    StreamProvider.family<List<SupportTicket>, String>((ref, userId) {
  return ref.watch(supportRepositoryProvider).watchTickets(userId);
});

final supportControllerProvider =
    AsyncNotifierProvider<SupportController, void>(SupportController.new);

class SupportController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> createTicket({
    required String userId,
    required String subject,
    required String description,
  }) async {
    final ticket = SupportTicket(
      id: ref.read(uuidProvider).v4(),
      userId: userId,
      subject: subject,
      description: description,
      createdAt: DateTime.now(),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(supportRepositoryProvider).createTicket(ticket);
    });
  }
}
