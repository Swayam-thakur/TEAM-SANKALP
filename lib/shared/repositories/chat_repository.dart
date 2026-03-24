import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_message.dart';
import '../models/chat_room.dart';

abstract class ChatRepository {
  Stream<List<ChatRoom>> watchChatRooms(String userId);

  Stream<List<ChatMessage>> watchMessages(String roomId);

  Future<void> sendMessage(ChatMessage message);
}

class FirestoreChatRepository implements ChatRepository {
  FirestoreChatRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<ChatRoom>> watchChatRooms(String userId) {
    return _firestore
        .collection('chat_rooms')
        .where('participantIds', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatRoom.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<List<ChatMessage>> watchMessages(String roomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('sentAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatMessage.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> sendMessage(ChatMessage message) async {
    final roomRef = _firestore.collection('chat_rooms').doc(message.roomId);
    await roomRef.set(
      {
        'id': message.roomId,
        'participantIds': [message.senderId, message.receiverId],
        'lastMessage': message.message,
        'lastMessageAt': message.sentAt.toUtc().toIso8601String(),
      },
      SetOptions(merge: true),
    );

    await roomRef.collection('messages').doc(message.id).set(message.toJson());
  }
}

