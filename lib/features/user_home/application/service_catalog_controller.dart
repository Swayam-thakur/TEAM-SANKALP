import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/mock_seed_data.dart';
import '../../../shared/models/service_category.dart';
import '../../../shared/providers/app_providers.dart';

final serviceSearchQueryProvider = StateProvider<String>((ref) => '');

final servicesProvider = StreamProvider<List<ServiceCategory>>((ref) {
  return ref.watch(serviceRepositoryProvider).watchServices();
});

final filteredServicesProvider = Provider<List<ServiceCategory>>((ref) {
  final query = ref.watch(serviceSearchQueryProvider).trim().toLowerCase();
  final services = ref.watch(servicesProvider).value;
  final source = services == null || services.isEmpty
      ? mockServiceCategories
      : services;

  if (query.isEmpty) {
    return source;
  }

  return source
      .where(
        (service) =>
            service.name.toLowerCase().contains(query) ||
            service.description.toLowerCase().contains(query),
      )
      .toList();
});

final serviceByIdProvider =
    FutureProvider.family<ServiceCategory?, String>((ref, serviceId) {
  return ref.watch(serviceRepositoryProvider).getService(serviceId).then((value) {
    if (value != null) {
      return value;
    }
    try {
      return mockServiceCategories.firstWhere((item) => item.id == serviceId);
    } catch (_) {
      return null;
    }
  });
});
