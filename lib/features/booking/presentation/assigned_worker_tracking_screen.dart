import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/detail_tile.dart';
import '../../../core/widgets/section_card.dart';
import '../../chat/presentation/chat_screen.dart';
import '../../worker_dashboard/application/worker_dashboard_controller.dart';
import '../application/booking_controller.dart';
import 'booking_details_screen.dart';

class AssignedWorkerTrackingScreen extends ConsumerWidget {
  const AssignedWorkerTrackingScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/booking/tracking/:bookingId';

  static String buildPath(String bookingId) => '/booking/tracking/$bookingId';

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingByIdProvider(bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Track worker')),
      body: booking.when(
        data: (item) {
          if (item == null || item.workerId == null) {
            return const Center(child: Text('Worker not assigned yet.'));
          }

          final workerLocation =
              ref.watch(workerLocationProvider(item.workerId!)).valueOrNull;
          final worker = ref.watch(workerProfileByIdProvider(item.workerId!));
          final markers = <Marker>{
            Marker(
              markerId: const MarkerId('customer'),
              position: LatLng(
                item.address.latitude,
                item.address.longitude,
              ),
              infoWindow: const InfoWindow(title: 'Customer'),
            ),
          };

          if (workerLocation != null) {
            markers.add(
              Marker(
                markerId: const MarkerId('worker'),
                position: LatLng(
                  workerLocation.latitude,
                  workerLocation.longitude,
                ),
                infoWindow: const InfoWindow(title: 'Worker'),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 260,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        workerLocation?.latitude ?? item.address.latitude,
                        workerLocation?.longitude ?? item.address.longitude,
                      ),
                      zoom: 14,
                    ),
                    markers: markers,
                    myLocationEnabled: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                child: Column(
                  children: [
                    DetailTile(
                      label: 'Booking status',
                      value: enumLabel(item.status),
                      icon: Icons.track_changes_rounded,
                    ),
                    worker.when(
                      data: (profile) => DetailTile(
                        label: 'Assigned worker',
                        value: profile?.name ?? 'Awaiting profile sync',
                        icon: Icons.engineering_rounded,
                      ),
                      loading: () => const DetailTile(
                        label: 'Assigned worker',
                        value: 'Loading profile',
                        icon: Icons.engineering_rounded,
                      ),
                      error: (error, _) => DetailTile(
                        label: 'Assigned worker',
                        value: error.toString(),
                        icon: Icons.error_outline_rounded,
                      ),
                    ),
                    DetailTile(
                      label: 'Service address',
                      value: item.address.fullAddress,
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => context.push(
                        ChatScreen.buildPath(item.chatRoomId ?? 'chat_${item.id}'),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                      label: const Text('Chat'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final phone = worker.valueOrNull?.phoneNumber;
                        if (phone == null || phone.isEmpty) {
                          return;
                        }
                        await launchUrl(Uri(scheme: 'tel', path: phone));
                      },
                      icon: const Icon(Icons.call_outlined),
                      label: const Text('Call'),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => context.push(
                  BookingDetailsScreen.buildPath(item.id),
                ),
                child: const Text('Open full booking timeline'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
