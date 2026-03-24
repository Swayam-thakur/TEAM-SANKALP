import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService(
    this._messaging,
    this._localNotifications,
  );

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  static const _foregroundChannel = AndroidNotificationChannel(
    'quickseva_foreground',
    'Foreground Alerts',
    description: 'Alerts for incoming requests and booking updates.',
    importance: Importance.max,
    playSound: true,
  );

  Future<void> initialize() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(settings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_foregroundChannel);

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) {
        return;
      }

      await showLocalAlert(
        id: notification.hashCode,
        title: notification.title ?? 'QuickSeva',
        body: notification.body ?? 'You have a new update.',
      );
    });
  }

  Future<void> showLocalAlert({
    required int id,
    required String title,
    required String body,
  }) async {
    await _localNotifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'quickseva_foreground',
          'Foreground Alerts',
          channelDescription: 'Alerts for incoming requests and booking updates.',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          category: AndroidNotificationCategory.alarm,
        ),
      ),
    );
  }

  Future<String?> getDeviceToken() => _messaging.getToken();
}

