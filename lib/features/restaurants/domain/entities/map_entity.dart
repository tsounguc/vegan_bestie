import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEntity {
  const MapEntity({
    required this.markers,
    required this.userLocation,
  });

  MapEntity.empty()
      : this(
          markers: {},
          userLocation: Position(
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

  final Set<Marker> markers;
  final Position userLocation;
}
