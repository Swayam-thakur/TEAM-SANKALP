import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../shared/providers/app_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../user_home/application/service_catalog_controller.dart';

class ServiceSelectionScreen extends ConsumerStatefulWidget {
  const ServiceSelectionScreen({super.key});

  static const routePath = '/worker-services';

  @override
  ConsumerState<ServiceSelectionScreen> createState() =>
      _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends ConsumerState<ServiceSelectionScreen> {
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    final worker = ref.watch(workerProfileProvider).valueOrNull;
    final services = ref.watch(servicesProvider).value ?? const [];

    if (_selected.isEmpty && worker != null) {
      _selected.addAll(worker.serviceIds);
    }

    return AppShell(
      title: 'Service categories',
      body: ListView(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: services
                .map(
                  (service) => FilterChip(
                    label: Text(service.name),
                    selected: _selected.contains(service.id),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selected.add(service.id);
                        } else {
                          _selected.remove(service.id);
                        }
                      });
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Save selections',
            icon: Icons.save_outlined,
            onPressed: worker == null
                ? null
                : () async {
                    await ref.read(workerRepositoryProvider).upsertWorker(
                          worker.copyWith(serviceIds: _selected.toList()),
                        );
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Service categories updated.')),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
