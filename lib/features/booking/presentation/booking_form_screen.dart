import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/models/address_model.dart';
import '../../../shared/providers/app_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../user_home/application/service_catalog_controller.dart';
import '../application/booking_controller.dart';
import 'searching_worker_screen.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({
    required this.serviceId,
    super.key,
  });

  static const routePath = '/booking/new/:serviceId';

  static String buildPath(String serviceId) => '/booking/new/$serviceId';

  final String serviceId;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  final _notesController = TextEditingController();
  bool _scheduleLater = false;
  DateTime? _scheduledAt;
  String _paymentMethod = AppConstants.cashPaymentMethod;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(serviceByIdProvider(widget.serviceId));
    final userId = ref.watch(currentUserIdProvider);
    final bookingState = ref.watch(bookingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book service')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AsyncValueWidget(
          value: service,
          data: (item) {
            if (item == null || userId == null) {
              return const Center(child: Text('Unable to start booking.'));
            }

            return ListView(
              children: [
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Starting from INR ${item.basePrice.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Describe the work',
                    hintText: 'Leak under the sink, AC not cooling, deep cleaning needed...',
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _scheduleLater,
                  title: const Text('Schedule later'),
                  onChanged: (value) async {
                    setState(() => _scheduleLater = value);
                    if (value) {
                      final selected = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: DateTime.now(),
                      );
                      if (selected != null) {
                        _scheduledAt = selected;
                      }
                    }
                  },
                ),
                const SizedBox(height: 8),
                RadioListTile<String>(
                  value: AppConstants.cashPaymentMethod,
                  groupValue: _paymentMethod,
                  onChanged: (value) => setState(() => _paymentMethod = value!),
                  title: const Text('Cash on service'),
                ),
                RadioListTile<String>(
                  value: AppConstants.onlinePaymentMethod,
                  groupValue: _paymentMethod,
                  onChanged: (value) => setState(() => _paymentMethod = value!),
                  title: const Text('Online payment'),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Confirm booking',
                  isLoading: bookingState.isLoading,
                  icon: Icons.check_circle_rounded,
                  onPressed: () async {
                    final address = AddressModel(
                      id: 'booking-address',
                      label: 'Service address',
                      addressLine1: 'Selected service location',
                      addressLine2: 'QuickSeva default address',
                      latitude: 28.6139,
                      longitude: 77.2090,
                      isDefault: true,
                    );
                    final bookingId =
                        await ref.read(bookingControllerProvider.notifier).createBooking(
                              userId: userId,
                              serviceId: item.id,
                              serviceName: item.name,
                              address: address,
                              paymentMethod: _paymentMethod,
                              notes: _notesController.text.trim(),
                              scheduledAt: _scheduleLater ? _scheduledAt : null,
                              amountEstimate: item.basePrice + 99,
                            );
                    if (!mounted) {
                      return;
                    }
                    context.push(SearchingWorkerScreen.buildPath(bookingId));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
