import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/providers/app_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../application/booking_controller.dart';

class AddressSelectionScreen extends ConsumerWidget {
  const AddressSelectionScreen({super.key});

  static const routePath = '/addresses';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);
    final addresses = userId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(savedAddressesProvider(userId));
    final locationService = ref.watch(locationServiceProvider);

    return AppShell(
      title: 'Saved addresses',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.icon(
            onPressed: () async {
              final current = await locationService.determinePosition();
              final address = await locationService.reverseGeocode(current);
              if (!context.mounted || userId == null) {
                return;
              }
              await ref.read(userRepositoryProvider).saveAddress(userId, address);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Current location saved.')),
              );
            },
            icon: const Icon(Icons.my_location_rounded),
            label: const Text('Save current location'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: addresses.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('No saved addresses yet.'));
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final address = items[index];
                    return SectionCard(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(address.label),
                        subtitle: Text(address.fullAddress),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}

