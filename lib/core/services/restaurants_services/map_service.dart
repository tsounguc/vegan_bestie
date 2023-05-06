import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

import '../../../features/restaurants/data/models/map_model.dart';
import '../../../features/restaurants/domain/entities/restaurant_entity.dart';
import '../../../features/restaurants/presentation/pages/componets/restaurant_card.dart';
import 'package:clippy_flutter/triangle.dart';

abstract class MapServiceContract {
  Future getRestaurantsMarkers(List<RestaurantEntity> restaurants, GoogleMapController? controller);
}

class GoogleMapPluginImpl implements MapServiceContract {
  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();

  @override
  Future<MapModel> getRestaurantsMarkers(
      List<RestaurantEntity> restaurants, GoogleMapController? controller) async {
    customInfoWindowController.googleMapController = controller;
    Set<Marker> restaurantsMarkers = {};
    for (int index = 0; index < restaurants.length; index++) {
      restaurantsMarkers.add(
        Marker(
          markerId: MarkerId(restaurants[index].name!),
          infoWindow: InfoWindow(title: restaurants[index].name, snippet: restaurants[index].vicinity),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(restaurants[index].lat!, restaurants[index].lng!),
          // onTap: () {
          //   customInfoWindowController.addInfoWindow!(
          //     // CustomInfoWindow(controller: customInfoWindowController),
          //     Column(
          //       children: [
          //         // Expanded(
          //         //   child: RestaurantCard(
          //         //     dietRestrictions: "",
          //         //     restaurant: restaurants[index],
          //         //   ),
          //         // ),
          //         Triangle.isosceles(
          //           edge: Edge.BOTTOM,
          //           child: Container(
          //             color: Colors.blue,
          //             width: 20.0,
          //             height: 10.0,
          //           ),
          //         ),
          //       ],
          //     ),
          //     LatLng(restaurants[index].lat!, restaurants[index].lng!),
          //   );
          // },
        ),
      );
    }
    return MapModel(restaurantsMarkers: restaurantsMarkers);
  }
}
