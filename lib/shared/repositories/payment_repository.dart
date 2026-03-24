import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/payment_record.dart';

abstract class PaymentRepository {
  Future<void> savePayment(PaymentRecord payment);

  Stream<List<PaymentRecord>> watchWorkerWallet(String workerId);
}

class FirestorePaymentRepository implements PaymentRepository {
  FirestorePaymentRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> savePayment(PaymentRecord payment) {
    return _firestore.collection('payments').doc(payment.id).set(payment.toJson());
  }

  @override
  Stream<List<PaymentRecord>> watchWorkerWallet(String workerId) {
    return _firestore
        .collection('payments')
        .where('workerId', isEqualTo: workerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PaymentRecord.fromJson(doc.data()))
              .toList(),
        );
  }
}

