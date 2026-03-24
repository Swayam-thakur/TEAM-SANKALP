import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../profile/presentation/settings_screen.dart';
import '../../ratings/presentation/worker_reviews_screen.dart';

class WorkerProfileScreen extends ConsumerWidget {
  const WorkerProfileScreen({super.key});

  static const routePath = '/profile/worker';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final worker = ref.watch(workerProfileProvider).valueOrNull;

    return AppShell(
      title: 'Worker profile',
      actions: [
        IconButton(
          onPressed: () => context.push(SettingsScreen.routePath),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      body: ListView(
        children: [
          SectionCard(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  child: Icon(Icons.engineering_rounded),
                ),
                const SizedBox(height: 12),
                Text(
                  worker?.name ?? 'Worker profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                DetailTile(
                  label: 'Phone',
                  value: worker?.phoneNumber ?? '-',
                  icon: Icons.phone_outlined,
                ),
                DetailTile(
                  label: 'Radius',
                  value: '${worker?.radiusKm.toStringAsFixed(0) ?? '0'} km',
                  icon: Icons.radar_rounded,
                ),
                DetailTile(
                  label: 'Verification',
                  value: enumLabel(worker?.verificationStatus).isEmpty
                      ? 'pending'
                      : enumLabel(worker?.verificationStatus),
                  icon: Icons.verified_user_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => context.push(WorkerReviewsScreen.routePath),
            icon: const Icon(Icons.reviews_outlined),
            label: const Text('View ratings'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
              if (!context.mounted) {
                return;
              }
              context.go(OnboardingScreen.routePath);
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
