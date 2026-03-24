import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../core/services/connectivity_service.dart';
import '../../core/services/location_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/payment_gateway.dart';
import '../repositories/auth_repository.dart';
import '../repositories/booking_repository.dart';
import '../repositories/chat_repository.dart';
import '../repositories/notification_repository.dart';
import '../repositories/payment_repository.dart';
import '../repositories/review_repository.dart';
import '../repositories/service_repository.dart';
import '../repositories/support_repository.dart';
import '../repositories/user_repository.dart';
import '../repositories/worker_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final localNotificationsProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final uuidProvider = Provider<Uuid>((ref) => const Uuid());

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService(ref.watch(connectivityProvider));
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(
    ref.watch(firebaseMessagingProvider),
    ref.watch(localNotificationsProvider),
  );
});

final paymentGatewayProvider = Provider<PaymentGateway>((ref) {
  return PlaceholderPaymentGateway();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(ref.watch(firebaseAuthProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return FirestoreUserRepository(ref.watch(firestoreProvider));
});

final workerRepositoryProvider = Provider<WorkerRepository>((ref) {
  return FirestoreWorkerRepository(ref.watch(firestoreProvider));
});

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return FirestoreServiceRepository(ref.watch(firestoreProvider));
});

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return FirestoreBookingRepository(ref.watch(firestoreProvider));
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return FirestoreChatRepository(ref.watch(firestoreProvider));
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return FirestorePaymentRepository(ref.watch(firestoreProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return FirestoreNotificationRepository(ref.watch(firestoreProvider));
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return FirestoreReviewRepository(ref.watch(firestoreProvider));
});

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  return FirestoreSupportRepository(ref.watch(firestoreProvider));
});
