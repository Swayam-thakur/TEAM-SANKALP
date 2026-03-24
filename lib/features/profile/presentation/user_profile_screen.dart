import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../profile/presentation/settings_screen.dart';
import '../../support/presentation/support_screen.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  static const routePath = '/profile/user';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider).valueOrNull;

    return AppShell(
      title: 'Profile',
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
                const CircleAvatar(radius: 36, child: Icon(Icons.person_rounded)),
                const SizedBox(height: 12),
                Text(
                  user?.name ?? 'Guest user',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                DetailTile(
                  label: 'Phone',
                  value: user?.phoneNumber ?? '-',
                  icon: Icons.phone_outlined,
                ),
                DetailTile(
                  label: 'Email',
                  value: user?.email ?? 'Not provided',
                  icon: Icons.email_outlined,
                ),
                DetailTile(
                  label: 'Rating',
                  value: user?.rating.toStringAsFixed(1) ?? '0.0',
                  icon: Icons.star_outline_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => context.push(SupportScreen.routePath),
            icon: const Icon(Icons.support_agent_rounded),
            label: const Text('Help and support'),
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

