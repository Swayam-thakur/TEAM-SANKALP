import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/service_icon_mapper.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../booking/presentation/booking_form_screen.dart';
import '../../user_home/application/service_catalog_controller.dart';

class ServiceDetailsScreen extends ConsumerWidget {
  const ServiceDetailsScreen({
    required this.serviceId,
    super.key,
  });

  static const routePath = '/services/:serviceId';

  static String buildPath(String serviceId) => '/services/$serviceId';

  final String serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(serviceByIdProvider(serviceId));

    return Scaffold(
      appBar: AppBar(title: const Text('Service details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AsyncValueWidget(
          value: service,
          data: (item) {
            if (item == null) {
              return const Center(child: Text('Service not found.'));
            }

            return ListView(
              children: [
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        child: Icon(serviceIconFor(item.iconKey), size: 36),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(item.description),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  child: Column(
                    children: [
                      DetailTile(
                        label: 'Estimated starting price',
                        value: 'INR ${item.basePrice.toStringAsFixed(0)}',
                        icon: Icons.currency_rupee_rounded,
                      ),
                      const DetailTile(
                        label: 'Matching mode',
                        value: 'Nearby verified workers, first acceptance wins',
                        icon: Icons.route_rounded,
                      ),
                      const DetailTile(
                        label: 'Payment options',
                        value: 'Cash or online placeholder gateway',
                        icon: Icons.payments_rounded,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Book now',
                  icon: Icons.calendar_month_rounded,
                  onPressed: () => context.push(
                    BookingFormScreen.buildPath(item.id),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
