import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/app_enums.dart';
import '../../../shared/models/earning_record.dart';
import '../../../shared/models/worker_document.dart';
import '../../../shared/models/worker_location.dart';
import '../../../shared/models/worker_profile.dart';
import '../../../shared/providers/app_providers.dart';

final workerLocationProvider =
    StreamProvider.family<WorkerLocation?, String>((ref, workerId) {
  return ref.watch(workerRepositoryProvider).watchLocation(workerId);
});

final workerProfileByIdProvider =
    StreamProvider.family<WorkerProfile?, String>((ref, workerId) {
  return ref.watch(workerRepositoryProvider).watchWorker(workerId);
});

final workerEarningsProvider =
    StreamProvider.family<List<EarningRecord>, String>((ref, workerId) {
  return ref.watch(workerRepositoryProvider).watchEarnings(workerId);
});

final workerDashboardControllerProvider =
    AsyncNotifierProvider<WorkerDashboardController, void>(
  WorkerDashboardController.new,
);

class WorkerDashboardController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updateAvailability({
    required String workerId,
    required bool online,
    required WorkerAvailability availability,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workerRepositoryProvider).setAvailability(
            workerId,
            online: online,
            status: availability,
          );
    });
  }

  Future<void> updateLocation({
    required String workerId,
    required double latitude,
    required double longitude,
    List<String> serviceIds = const [],
  }) async {
    final location = WorkerLocation(
      workerId: workerId,
      latitude: latitude,
      longitude: longitude,
      online: true,
      serviceIds: serviceIds,
      updatedAt: DateTime.now(),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workerRepositoryProvider).updateLocation(location);
    });
  }

  Future<void> uploadDocument({
    required String workerId,
    required DocumentType type,
  }) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.single.path == null) {
      return;
    }

    final document = WorkerDocument(
      id: ref.read(uuidProvider).v4(),
      workerId: workerId,
      type: type,
      fileUrl: result.files.single.path!,
      status: VerificationStatus.pending,
      createdAt: DateTime.now(),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(workerRepositoryProvider).saveDocument(document);
    });
  }
}
