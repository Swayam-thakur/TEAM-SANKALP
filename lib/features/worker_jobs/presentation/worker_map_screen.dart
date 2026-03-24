import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../shared/providers/app_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../booking/application/booking_controller.dart';
import '../../worker_dashboard/application/worker_dashboard_controller.dart';

class WorkerMapScreen extends ConsumerWidget {
  const WorkerMapScreen({
    required this.bookingId,
    super.key,
  });

  static const routePath = '/worker/map/:bookingId';

  static String buildPath(String bookingId) => '/worker/map/$bookingId';

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workerId = ref.watch(currentUserIdProvider);
    final booking = bookingId == 'live'
        ? null
        : ref.watch(bookingByIdProvider(bookingId)).valueOrNull;
    final workerLocation = workerId == null
        ? null
        : ref.watch(workerLocationProvider(workerId)).valueOrNull;

    final target = LatLng(
      workerLocation?.latitude ?? booking?.address.latitude ?? 28.6139,
      workerLocation?.longitude ?? booking?.address.longitude ?? 77.2090,
    );

    final markers = <Marker>{
      if (workerLocation != null)
        Marker(
          markerId: const MarkerId('worker'),
          position: LatLng(workerLocation.latitude, workerLocation.longitude),
          infoWindow: const InfoWindow(title: 'Worker'),
        ),
      if (booking != null)
        Marker(
          markerId: const MarkerId('customer'),
          position: LatLng(booking.address.latitude, booking.address.longitude),
          infoWindow: const InfoWindow(title: 'Customer'),
        ),
    };

    return AppShell(
      title: 'Worker map',
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: target, zoom: 14),
                markers: markers,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
                compassEnabled: true,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: workerId == null
                      ? null
                      : () async {
                          final position = await ref
                              .read(locationServiceProvider)
                              .determinePosition();
                          await ref
                              .read(workerDashboardControllerProvider.notifier)
                              .updateLocation(
                                workerId: workerId,
                                latitude: position.latitude,
                                longitude: position.longitude,
                              );
                        },
                  icon: const Icon(Icons.my_location_rounded),
                  label: const Text('Refresh live location'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: booking == null
                      ? null
                      : () async {
                          final uri = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${booking.address.latitude},${booking.address.longitude}',
                          );
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: const Text('Open in Maps'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
