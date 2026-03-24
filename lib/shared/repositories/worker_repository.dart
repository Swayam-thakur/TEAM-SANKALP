import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_enums.dart';
import '../models/earning_record.dart';
import '../models/worker_document.dart';
import '../models/worker_location.dart';
import '../models/worker_profile.dart';

abstract class WorkerRepository {
  Stream<WorkerProfile?> watchWorker(String workerId);

  Future<void> upsertWorker(WorkerProfile worker);

  Future<void> setAvailability(
    String workerId, {
    required bool online,
    required WorkerAvailability status,
  });

  Future<void> saveDocument(WorkerDocument document);

  Future<void> updateLocation(WorkerLocation location);

  Stream<List<EarningRecord>> watchEarnings(String workerId);

  Stream<WorkerLocation?> watchLocation(String workerId);

  Future<List<String>> getOnlineWorkerIds();
}

class FirestoreWorkerRepository implements WorkerRepository {
  FirestoreWorkerRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<WorkerProfile?> watchWorker(String workerId) {
    return _firestore.collection('workers').doc(workerId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }
      return WorkerProfile.fromJson(doc.data()!);
    });
  }

  @override
  Future<void> upsertWorker(WorkerProfile worker) {
    return _firestore.collection('workers').doc(worker.id).set(worker.toJson());
  }

  @override
  Future<void> setAvailability(
    String workerId, {
    required bool online,
    required WorkerAvailability status,
  }) {
    return _firestore.collection('workers').doc(workerId).set(
      {
        'online': online,
        'availability': status.name,
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> saveDocument(WorkerDocument document) {
    return _firestore
        .collection('worker_documents')
        .doc(document.id)
        .set(document.toJson());
  }

  @override
  Future<void> updateLocation(WorkerLocation location) {
    return _firestore
        .collection('worker_locations')
        .doc(location.workerId)
        .set(location.toJson(), SetOptions(merge: true));
  }

  @override
  Stream<List<EarningRecord>> watchEarnings(String workerId) {
    return _firestore
        .collection('earnings')
        .where('workerId', isEqualTo: workerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => EarningRecord.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<WorkerLocation?> watchLocation(String workerId) {
    return _firestore
        .collection('worker_locations')
        .doc(workerId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        return null;
      }
      return WorkerLocation.fromJson(doc.data()!);
    });
  }

  @override
  Future<List<String>> getOnlineWorkerIds() async {
    final snapshot = await _firestore
        .collection('workers')
        .where('online', isEqualTo: true)
        .get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
