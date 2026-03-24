import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/presentation/login_screen.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  static const routePath = '/role-selection';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose your QuickSeva role',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Both flows live in the same app. Your role controls the dashboard and booking tools.',
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _RoleCard(
                        title: 'I need a service',
                        subtitle: 'Book electricians, plumbers, cleaners and more.',
                        icon: Icons.home_repair_service_rounded,
                        onTap: () {
                          ref.read(selectedRoleProvider.notifier).state =
                              UserRole.user;
                          context.push(LoginScreen.routePath);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _RoleCard(
                        title: 'I am a worker',
                        subtitle: 'Go online, receive nearby jobs, and manage earnings.',
                        icon: Icons.engineering_rounded,
                        onTap: () {
                          ref.read(selectedRoleProvider.notifier).state =
                              UserRole.worker;
                          context.push(LoginScreen.routePath);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 56),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}
