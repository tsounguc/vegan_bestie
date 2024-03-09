import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class GoogleMapPlugin {
  Future<MapModel> getRestaurantsMarkers(List<Restaurant> restaurants) async {
    final restaurantsMarkers = <Marker>{};
    for (var index = 0; index < restaurants.length; index++) {
      final name = restaurants[index].name;
      final latitude = restaurants[index].geometry.location.lat;
      final longitude = restaurants[index].geometry.location.lng;
      final snippet = restaurants[index].vicinity;
      restaurantsMarkers.add(
        Marker(
          markerId: MarkerId(name),
          infoWindow: InfoWindow(title: name, snippet: snippet),
          position: LatLng(latitude, longitude),
        ),
      );
    }
    return MapModel(markers: restaurantsMarkers);
  }
}
