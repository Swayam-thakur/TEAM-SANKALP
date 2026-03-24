import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/address_model.dart';
import '../../../shared/models/app_enums.dart';
import '../../../shared/models/booking_model.dart';
import '../../../shared/models/notification_item.dart';
import '../../../shared/providers/app_providers.dart';

final bookingByIdProvider =
    StreamProvider.family<BookingModel?, String>((ref, bookingId) {
  return ref.watch(bookingRepositoryProvider).watchBooking(bookingId);
});

final userBookingsProvider =
    StreamProvider.family<List<BookingModel>, String>((ref, userId) {
  return ref.watch(bookingRepositoryProvider).watchUserBookings(userId);
});

final workerBookingsProvider =
    StreamProvider.family<List<BookingModel>, String>((ref, workerId) {
  return ref.watch(bookingRepositoryProvider).watchWorkerBookings(workerId);
});

final incomingRequestsProvider =
    StreamProvider.family<List<BookingModel>, String>((ref, workerId) {
  return ref.watch(bookingRepositoryProvider).watchIncomingRequests(workerId);
});

final bookingControllerProvider =
    AsyncNotifierProvider<BookingController, void>(BookingController.new);

final savedAddressesProvider =
    StreamProvider.family<List<AddressModel>, String>((ref, userId) {
  return ref.watch(userRepositoryProvider).watchSavedAddresses(userId);
});

class BookingController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> createBooking({
    required String userId,
    required String serviceId,
    required String serviceName,
    required AddressModel address,
    required String paymentMethod,
    String? notes,
    DateTime? scheduledAt,
    double? amountEstimate,
  }) async {
    final bookingId = ref.read(uuidProvider).v4();
    final workerIds = await ref.read(workerRepositoryProvider).getOnlineWorkerIds();
    final booking = BookingModel(
      id: bookingId,
      userId: userId,
      serviceId: serviceId,
      serviceName: serviceName,
      address: address,
      notes: notes,
      status: workerIds.isEmpty
          ? BookingStatus.searchingWorker
          : BookingStatus.workerNotified,
      createdAt: DateTime.now(),
      scheduledAt: scheduledAt,
      amountEstimate: amountEstimate ?? 299,
      paymentMethod: paymentMethod,
      chatRoomId: 'chat_$bookingId',
      requestedWorkerIds: workerIds,
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(bookingRepositoryProvider).createBooking(booking);
      for (final workerId in workerIds) {
        final notification = NotificationItem(
          id: ref.read(uuidProvider).v4(),
          userId: workerId,
          title: 'New service request',
          body: '$serviceName booking is waiting for acceptance.',
          type: NotificationType.jobRequest,
          bookingId: bookingId,
          createdAt: DateTime.now(),
        );
        await ref
            .read(notificationRepositoryProvider)
            .saveNotification(notification);
      }
    });

    return bookingId;
  }

  Future<void> cancelBooking(String bookingId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(bookingRepositoryProvider).cancelBooking(bookingId);
    });
  }

  Future<void> updateStatus(String bookingId, BookingStatus status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(bookingRepositoryProvider).updateStatus(bookingId, status);
    });
  }

  Future<void> acceptBooking({
    required String bookingId,
    required String workerId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(bookingRepositoryProvider).acceptBooking(
            bookingId: bookingId,
            workerId: workerId,
          );
    });
  }

  Future<void> rejectBookingRequest({
    required String bookingId,
    required String workerId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(bookingRepositoryProvider).rejectBookingRequest(
            bookingId: bookingId,
            workerId: workerId,
          );
    });
  }
}
