import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../worker_dashboard/presentation/worker_dashboard_screen.dart';
import 'service_selection_screen.dart';

class WorkerOnboardingScreen extends StatelessWidget {
  const WorkerOnboardingScreen({super.key});

  static const routePath = '/worker-onboarding';

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Worker onboarding',
      body: ListView(
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Complete these steps before going live.'),
                SizedBox(height: 12),
                Text('1. Fill your profile'),
                Text('2. Choose service categories'),
                Text('3. Set yourself online from the dashboard'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.push(ServiceSelectionScreen.routePath),
            icon: const Icon(Icons.grid_view_rounded),
            label: const Text('Select services'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.push(WorkerDashboardScreen.routePath),
            icon: const Icon(Icons.dashboard_outlined),
            label: const Text('Open dashboard'),
          ),
        ],
      ),
    );
  }
}
