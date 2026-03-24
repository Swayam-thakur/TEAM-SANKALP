import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notification_item.dart';

abstract class NotificationRepository {
  Stream<List<NotificationItem>> watchNotifications(String userId);

  Future<void> markAsRead(String notificationId);

  Future<void> saveNotification(NotificationItem notification);
}

class FirestoreNotificationRepository implements NotificationRepository {
  FirestoreNotificationRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<NotificationItem>> watchNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NotificationItem.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> markAsRead(String notificationId) {
    return _firestore.collection('notifications').doc(notificationId).set(
      {'read': true},
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> saveNotification(NotificationItem notification) {
    return _firestore
        .collection('notifications')
        .doc(notification.id)
        .set(notification.toJson());
  }
}
