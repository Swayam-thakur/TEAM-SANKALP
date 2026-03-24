import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../shared/models/app_enums.dart';
import '../../user_home/application/service_catalog_controller.dart';
import '../../user_home/presentation/user_home_screen.dart';
import '../../worker_dashboard/presentation/worker_dashboard_screen.dart';
import '../application/auth_controller.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  static const routePath = '/profile-setup';

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _radiusController = TextEditingController(text: '8');
  final Set<String> _selectedServices = {};

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedRole = ref.watch(selectedRoleProvider);
    final authUser = ref.watch(authStateProvider).value;
    final services = ref.watch(servicesProvider).value ?? const [];
    final state = ref.watch(authControllerProvider);

    final role = selectedRole ?? UserRole.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Complete your profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: authUser?.phoneNumber ?? '',
                  enabled: false,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email (optional)',
                  ),
                ),
                if (role == UserRole.worker) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Services you provide',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: services
                        .map(
                          (service) => FilterChip(
                            label: Text(service.name),
                            selected: _selectedServices.contains(service.id),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedServices.add(service.id);
                                } else {
                                  _selectedServices.remove(service.id);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _radiusController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Service radius (km)',
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                PrimaryButton(
                  label: role == UserRole.worker
                      ? 'Create worker profile'
                      : 'Create account',
                  isLoading: state.isLoading,
                  icon: Icons.check_circle_rounded,
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    await ref.read(authControllerProvider.notifier).saveProfile(
                          name: _nameController.text.trim(),
                          phoneNumber: authUser?.phoneNumber ?? '',
                          email: _emailController.text.trim().isEmpty
                              ? null
                              : _emailController.text.trim(),
                          role: role,
                          serviceIds: _selectedServices.toList(),
                          radiusKm:
                              double.tryParse(_radiusController.text.trim()) ?? 8,
                        );
                    if (!mounted) {
                      return;
                    }
                    context.pushReplacement(
                      role == UserRole.worker
                          ? WorkerDashboardScreen.routePath
                          : UserHomeScreen.routePath,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
