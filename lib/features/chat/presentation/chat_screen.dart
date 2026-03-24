import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_controller.dart';
import '../../booking/application/booking_controller.dart';
import '../application/chat_controller.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    required this.roomId,
    super.key,
  });

  static const routePath = '/chat/:roomId';

  static String buildPath(String roomId) => '/chat/$roomId';

  final String roomId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider(widget.roomId));
    final currentUserId = ref.watch(currentUserIdProvider);
    final bookingId = widget.roomId.replaceFirst('chat_', '');
    final booking = ref.watch(bookingByIdProvider(bookingId)).valueOrNull;
    final receiverId = booking == null || currentUserId == null
        ? ''
        : currentUserId == booking.userId
            ? booking.workerId ?? ''
            : booking.userId;

    return Scaffold(
      appBar: AppBar(title: const Text('Booking chat')),
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final message = items[index];
                    final mine = message.senderId == currentUserId;
                    return Align(
                      alignment:
                          mine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: mine
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(message.message),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: currentUserId == null || receiverId.isEmpty
                        ? null
                        : () async {
                            await ref.read(chatControllerProvider.notifier).sendMessage(
                                  roomId: widget.roomId,
                                  senderId: currentUserId,
                                  receiverId: receiverId,
                                  message: _messageController.text.trim(),
                                );
                            _messageController.clear();
                          },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
