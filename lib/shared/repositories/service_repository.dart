import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/service_category.dart';

abstract class ServiceRepository {
  Stream<List<ServiceCategory>> watchServices();

  Future<ServiceCategory?> getService(String serviceId);

  Future<void> seedServices(List<ServiceCategory> services);
}

class FirestoreServiceRepository implements ServiceRepository {
  FirestoreServiceRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<ServiceCategory>> watchServices() {
    return _firestore
        .collection('services')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ServiceCategory.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<ServiceCategory?> getService(String serviceId) async {
    final doc = await _firestore.collection('services').doc(serviceId).get();
    if (!doc.exists) {
      return null;
    }
    return ServiceCategory.fromJson(doc.data()!);
  }

  @override
  Future<void> seedServices(List<ServiceCategory> services) async {
    final batch = _firestore.batch();
    for (final service in services) {
      batch.set(
        _firestore.collection('services').doc(service.id),
        service.toJson(),
      );
    }
    await batch.commit();
  }
}
