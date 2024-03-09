import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';

class LocationPlugin {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const UserLocationException(message: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw const UserLocationException(
        message: 'Location permissions are permanently denied, '
            'we cannot request permissions.',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  Future<Position?> getLastLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const UserLocationException(
          message: 'Location permissions are denied',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw const UserLocationException(
        message: 'Location permissions are permanently denied, '
            'we cannot request permissions.',
      );
    }
    final lastPosition = await Geolocator.getLastKnownPosition();
    return lastPosition;
  }
}
