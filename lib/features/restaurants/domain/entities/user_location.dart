import 'package:geolocator/geolocator.dart';

class UserLocation {
  const UserLocation({
    required this.position,
  });

  UserLocation.empty()
      : this(
          position: Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            altitudeAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            speed: 0,
            speedAccuracy: 0,
          ),
        );
  final Position position;
}
