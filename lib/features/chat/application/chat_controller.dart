import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/chat_message.dart';
import '../../../shared/models/chat_room.dart';
import '../../../shared/providers/app_providers.dart';

final chatRoomsProvider =
    StreamProvider.family<List<ChatRoom>, String>((ref, userId) {
  return ref.watch(chatRepositoryProvider).watchChatRooms(userId);
});

final chatMessagesProvider =
    StreamProvider.family<List<ChatMessage>, String>((ref, roomId) {
  return ref.watch(chatRepositoryProvider).watchMessages(roomId);
});

final chatControllerProvider =
    AsyncNotifierProvider<ChatController, void>(ChatController.new);

class ChatController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    final payload = ChatMessage(
      id: ref.read(uuidProvider).v4(),
      roomId: roomId,
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      sentAt: DateTime.now(),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(chatRepositoryProvider).sendMessage(payload);
    });
  }
}

