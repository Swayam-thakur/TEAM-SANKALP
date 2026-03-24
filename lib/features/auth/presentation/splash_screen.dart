import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../../shared/providers/app_providers.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../user_home/presentation/user_home_screen.dart';
import '../../worker_dashboard/presentation/worker_dashboard_screen.dart';
import '../application/auth_controller.dart';
import 'profile_setup_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routePath = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(notificationServiceProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final appUser = ref.watch(appUserProvider);
    final worker = ref.watch(workerProfileProvider);

    void navigate(String path) {
      if (_navigated || !mounted) {
        return;
      }
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go(path);
        }
      });
    }

    if (authState.isLoading) {
      return Scaffold(
        body: Center(
          child: SectionCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.miscellaneous_services_rounded, size: 72),
                const SizedBox(height: 16),
                Text(
                  'QuickSeva',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nearby trusted services, matched in real time.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    }

    authState.whenData((user) {
      if (user == null) {
        navigate(OnboardingScreen.routePath);
        return;
      }

      if (appUser.isLoading) {
        return;
      }

      final profile = appUser.valueOrNull;
      if (profile == null) {
        navigate(ProfileSetupScreen.routePath);
        return;
      }

      if (profile.role == UserRole.worker || worker.valueOrNull != null) {
        navigate(WorkerDashboardScreen.routePath);
      } else {
        navigate(UserHomeScreen.routePath);
      }
    });

    return Scaffold(
      body: Center(
        child: SectionCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.miscellaneous_services_rounded, size: 72),
              const SizedBox(height: 16),
              Text(
                'QuickSeva',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Nearby trusted services, matched in real time.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
