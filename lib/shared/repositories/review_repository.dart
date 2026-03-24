import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/review_model.dart';

abstract class ReviewRepository {
  Future<void> submitReview(ReviewModel review);

  Stream<List<ReviewModel>> watchReviewsForWorker(String workerId);
}

class FirestoreReviewRepository implements ReviewRepository {
  FirestoreReviewRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> submitReview(ReviewModel review) {
    return _firestore.collection('reviews').doc(review.id).set(review.toJson());
  }

  @override
  Stream<List<ReviewModel>> watchReviewsForWorker(String workerId) {
    return _firestore
        .collection('reviews')
        .where('revieweeId', isEqualTo: workerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ReviewModel.fromJson(doc.data()))
              .toList(),
        );
  }
}

