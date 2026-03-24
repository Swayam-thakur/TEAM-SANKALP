import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/app_enums.dart';
import '../../../shared/models/app_user.dart';
import '../../../shared/models/worker_profile.dart';
import '../../../shared/providers/app_providers.dart';

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final currentUserIdProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).value?.uid;
});

final appUserProvider = StreamProvider<AppUser?>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) {
    return Stream.value(null);
  }
  return ref.watch(userRepositoryProvider).watchUser(userId);
});

final workerProfileProvider = StreamProvider<WorkerProfile?>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) {
    return Stream.value(null);
  }
  return ref.watch(workerRepositoryProvider).watchWorker(userId);
});

final authControllerProvider =
    AsyncNotifierProvider<AuthController, void>(AuthController.new);

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> requestOtp(String phoneNumber) async {
    state = const AsyncLoading();
    try {
      final verificationId =
          await ref.read(authRepositoryProvider).requestOtp(phoneNumber);
      state = const AsyncData(null);
      return verificationId;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).verifyOtp(
            verificationId: verificationId,
            smsCode: smsCode,
          );
    });
  }

  Future<void> saveProfile({
    required String name,
    required String phoneNumber,
    required UserRole role,
    String? email,
    String? photoUrl,
    List<String> serviceIds = const [],
    double radiusKm = 8,
  }) async {
    final firebaseUser = ref.read(authRepositoryProvider).currentUser;
    if (firebaseUser == null) {
      throw StateError('No authenticated user found.');
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token =
          await ref.read(notificationServiceProvider).getDeviceToken();

      final appUser = AppUser(
        id: firebaseUser.uid,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        role: role,
        photoUrl: photoUrl,
        notificationToken: token,
        createdAt: DateTime.now(),
      );

      await ref.read(userRepositoryProvider).upsertUser(appUser);

      if (role == UserRole.worker) {
        final worker = WorkerProfile(
          id: firebaseUser.uid,
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          profilePhotoUrl: photoUrl,
          serviceIds: serviceIds,
          radiusKm: radiusKm,
          createdAt: DateTime.now(),
        );
        await ref.read(workerRepositoryProvider).upsertWorker(worker);
      }
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signOut();
      ref.read(selectedRoleProvider.notifier).state = null;
    });
  }
}
