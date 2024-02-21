import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../features/restaurants/data/models/map_model.dart';
import '../../../features/restaurants/domain/entities/restaurant_entity.dart';

abstract class MapServiceContract {
  Future getRestaurantsMarkers(List<RestaurantEntity> restaurants);
}

class GoogleMapPluginImpl implements MapServiceContract {
  @override
  Future<MapModel> getRestaurantsMarkers(List<RestaurantEntity> restaurants) async {
    Set<Marker> restaurantsMarkers = {};
    for (int index = 0; index < restaurants.length; index++) {
      restaurantsMarkers.add(
        Marker(
          markerId: MarkerId(restaurants[index].name!),
          infoWindow: InfoWindow(title: restaurants[index].name, snippet: restaurants[index].vicinity),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(restaurants[index].lat!, restaurants[index].lng!),
        ),
      );
    }
    return MapModel(restaurantsMarkers: restaurantsMarkers);
  }
}
