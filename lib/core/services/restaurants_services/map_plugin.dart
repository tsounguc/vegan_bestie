import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';

class GoogleMapPlugin {
  Future<MapModel> getRestaurantsMarkers({required List<Restaurant> restaurants}) async {
    final restaurantsMarkers = <Marker>{};
    for (var index = 0; index < restaurants.length; index++) {
      final restaurant = restaurants[index];
      final name = restaurant.name;
      final latitude = restaurant.geoLocation.lat;
      final longitude = restaurant.geoLocation.lng;
      final snippet = '${restaurant.streetAddress}, ${restaurant.city}, '
          '${restaurant.state} ${restaurant.zipCode}';
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
