import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  Set<Marker>? restaurantsMarkers;

  MapModel({
    this.restaurantsMarkers,
  });
}
