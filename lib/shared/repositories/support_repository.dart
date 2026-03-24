import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/support_ticket.dart';

abstract class SupportRepository {
  Future<void> createTicket(SupportTicket ticket);

  Stream<List<SupportTicket>> watchTickets(String userId);
}

class FirestoreSupportRepository implements SupportRepository {
  FirestoreSupportRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> createTicket(SupportTicket ticket) {
    return _firestore
        .collection('support_tickets')
        .doc(ticket.id)
        .set(ticket.toJson());
  }

  @override
  Stream<List<SupportTicket>> watchTickets(String userId) {
    return _firestore
        .collection('support_tickets')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SupportTicket.fromJson(doc.data()))
              .toList(),
        );
  }
}

