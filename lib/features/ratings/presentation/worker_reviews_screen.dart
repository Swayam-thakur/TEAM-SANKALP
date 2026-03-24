import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../application/review_controller.dart';

class WorkerReviewsScreen extends ConsumerWidget {
  const WorkerReviewsScreen({super.key});

  static const routePath = '/worker-reviews';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workerId = ref.watch(currentUserIdProvider);
    final reviews = workerId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(workerReviewsProvider(workerId));

    return AppShell(
      title: 'Ratings and reviews',
      body: reviews.when(
        data: (items) {
          final list = items.cast<dynamic>();
          if (list.isEmpty) {
            return const Center(child: Text('No reviews yet.'));
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final review = list[index];
              return SectionCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${review.rating} / 5'),
                  subtitle: Text(review.comment?.toString() ?? 'No comment'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}

