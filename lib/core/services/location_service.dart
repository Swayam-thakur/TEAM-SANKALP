import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../shared/models/address_model.dart';

class LocationService {
  Future<Position> determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission not granted.');
    }

    return Geolocator.getCurrentPosition();
  }

  Future<AddressModel> reverseGeocode(Position position) async {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final place = placemarks.first;

    return AddressModel(
      id: 'current-location',
      label: 'Current location',
      addressLine1: '${place.street ?? ''}, ${place.subLocality ?? ''}'.trim(),
      addressLine2: '${place.locality ?? ''}, ${place.administrativeArea ?? ''}'
          .trim(),
      latitude: position.latitude,
      longitude: position.longitude,
      isDefault: true,
    );
  }
}

