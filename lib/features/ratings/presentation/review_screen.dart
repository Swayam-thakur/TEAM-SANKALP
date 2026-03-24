import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../shared/models/app_enums.dart';
import '../../auth/application/auth_controller.dart';
import '../../booking/application/booking_controller.dart';
import '../application/review_controller.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/review/:bookingId';

  static String buildPath(String bookingId) => '/review/$bookingId';

  final String bookingId;

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  double _rating = 5;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(currentUserIdProvider);
    final booking = ref.watch(bookingByIdProvider(widget.bookingId)).valueOrNull;
    final state = ref.watch(reviewControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rate your experience')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How was the service?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: _rating.toStringAsFixed(0),
              onChanged: (value) => setState(() => _rating = value),
            ),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Share more details',
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'Submit review',
              isLoading: state.isLoading,
              icon: Icons.star_rounded,
              onPressed: currentUserId == null || booking?.workerId == null
                  ? null
                  : () async {
                      await ref.read(reviewControllerProvider.notifier).submitReview(
                            bookingId: widget.bookingId,
                            reviewerId: currentUserId,
                            revieweeId: booking!.workerId!,
                            rating: _rating,
                            reviewerRole: UserRole.user,
                            comment: _commentController.text.trim(),
                          );
                      if (!mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Review submitted.')),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}

