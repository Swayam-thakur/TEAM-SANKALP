import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import 'role_selection_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const routePath = '/onboarding';

  @override
  Widget build(BuildContext context) {
    final pages = [
      (
        icon: Icons.location_searching_rounded,
        title: 'Book home services in minutes',
        body: 'Choose a service, add your address, and get matched with nearby pros.',
      ),
      (
        icon: Icons.notifications_active_rounded,
        title: 'Real-time worker matching',
        body: 'The platform notifies nearby verified workers and locks the first acceptance.',
      ),
      (
        icon: Icons.wallet_rounded,
        title: 'Track, pay, and rate',
        body: 'Live status, in-app chat, payment records, and reviews stay tied to each booking.',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final item = pages[index];
                    return Center(
                      child: SectionCard(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(item.icon, size: 80),
                            const SizedBox(height: 16),
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.body,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              PrimaryButton(
                label: 'Continue',
                icon: Icons.arrow_forward_rounded,
                onPressed: () => context.push(RoleSelectionScreen.routePath),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
