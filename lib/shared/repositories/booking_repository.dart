import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_enums.dart';
import '../models/booking_model.dart';

abstract class BookingRepository {
  Stream<BookingModel?> watchBooking(String bookingId);

  Stream<List<BookingModel>> watchUserBookings(String userId);

  Stream<List<BookingModel>> watchWorkerBookings(String workerId);

  Stream<List<BookingModel>> watchIncomingRequests(String workerId);

  Future<void> createBooking(BookingModel booking);

  Future<void> cancelBooking(String bookingId);

  Future<void> updateStatus(
    String bookingId,
    BookingStatus status, {
    String? workerId,
  });

  Future<void> acceptBooking({
    required String bookingId,
    required String workerId,
  });

  Future<void> rejectBookingRequest({
    required String bookingId,
    required String workerId,
  });
}

class FirestoreBookingRepository implements BookingRepository {
  FirestoreBookingRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<BookingModel?> watchBooking(String bookingId) {
    return _firestore.collection('bookings').doc(bookingId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }
      return BookingModel.fromJson(doc.data()!);
    });
  }

  @override
  Stream<List<BookingModel>> watchUserBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<List<BookingModel>> watchWorkerBookings(String workerId) {
    return _firestore
        .collection('bookings')
        .where('workerId', isEqualTo: workerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<List<BookingModel>> watchIncomingRequests(String workerId) {
    return _firestore
        .collection('bookings')
        .where('requestedWorkerIds', arrayContains: workerId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromJson(doc.data()))
              .where(
                (booking) =>
                    booking.status == BookingStatus.workerNotified ||
                    booking.status == BookingStatus.searchingWorker,
              )
              .toList(),
        );
  }

  @override
  Future<void> createBooking(BookingModel booking) {
    return _firestore.collection('bookings').doc(booking.id).set(booking.toJson());
  }

  @override
  Future<void> cancelBooking(String bookingId) {
    return updateStatus(bookingId, BookingStatus.cancelled);
  }

  @override
  Future<void> updateStatus(
    String bookingId,
    BookingStatus status, {
    String? workerId,
  }) {
    return _firestore.collection('bookings').doc(bookingId).set(
      {
        'status': status.name,
        if (workerId != null) 'workerId': workerId,
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> acceptBooking({
    required String bookingId,
    required String workerId,
  }) async {
    await _firestore.runTransaction((transaction) async {
      final ref = _firestore.collection('bookings').doc(bookingId);
      final snapshot = await transaction.get(ref);
      final booking = BookingModel.fromJson(snapshot.data() ?? const {});
      if (booking.workerId != null &&
          booking.workerId!.isNotEmpty &&
          booking.workerId != workerId) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          message: 'Booking already assigned.',
        );
      }

      transaction.set(
        ref,
        {
          'workerId': workerId,
          'status': BookingStatus.workerAssigned.name,
        },
        SetOptions(merge: true),
      );
    });
  }

  @override
  Future<void> rejectBookingRequest({
    required String bookingId,
    required String workerId,
  }) {
    return _firestore.collection('bookings').doc(bookingId).set(
      {
        'requestedWorkerIds': FieldValue.arrayRemove([workerId]),
        'status': BookingStatus.searchingWorker.name,
      },
      SetOptions(merge: true),
    );
  }
}
