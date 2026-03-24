import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/address_model.dart';
import '../models/app_user.dart';

abstract class UserRepository {
  Stream<AppUser?> watchUser(String userId);

  Future<void> upsertUser(AppUser user);

  Stream<List<AddressModel>> watchSavedAddresses(String userId);

  Future<void> saveAddress(String userId, AddressModel address);
}

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<AppUser?> watchUser(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }
      return AppUser.fromJson(doc.data()!);
    });
  }

  @override
  Future<void> upsertUser(AppUser user) {
    return _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  @override
  Stream<List<AddressModel>> watchSavedAddresses(String userId) {
    return _firestore
        .collection('saved_addresses')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AddressModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> saveAddress(String userId, AddressModel address) {
    return _firestore.collection('saved_addresses').doc(address.id).set({
      ...address.toJson(),
      'userId': userId,
    });
  }
}

