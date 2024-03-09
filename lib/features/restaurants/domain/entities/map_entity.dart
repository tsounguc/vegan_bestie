import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEntity {
  const MapEntity({required this.markers});

  MapEntity.empty() : this(markers: {});

  final Set<Marker> markers;
}
