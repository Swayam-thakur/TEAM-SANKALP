import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/app_enums.dart';
import '../../../shared/models/review_model.dart';
import '../../../shared/providers/app_providers.dart';

final workerReviewsProvider =
    StreamProvider.family<List<ReviewModel>, String>((ref, workerId) {
  return ref.watch(reviewRepositoryProvider).watchReviewsForWorker(workerId);
});

final reviewControllerProvider =
    AsyncNotifierProvider<ReviewController, void>(ReviewController.new);

class ReviewController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> submitReview({
    required String bookingId,
    required String reviewerId,
    required String revieweeId,
    required double rating,
    required UserRole reviewerRole,
    String? comment,
  }) async {
    final review = ReviewModel(
      id: ref.read(uuidProvider).v4(),
      bookingId: bookingId,
      reviewerId: reviewerId,
      revieweeId: revieweeId,
      rating: rating,
      comment: comment,
      reviewerRole: reviewerRole,
      createdAt: DateTime.now(),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(reviewRepositoryProvider).submitReview(review);
    });
  }
}

