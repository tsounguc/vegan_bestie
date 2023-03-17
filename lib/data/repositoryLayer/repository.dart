import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/data/models/google_restaurants_search_model.dart';
import 'package:sheveegan/data/models/search_model.dart';
import 'package:sheveegan/features/restaurants/data/models/yelp_restaurants_model.dart';
import 'package:sheveegan/core/services/restaurants_services/restaurants_service.dart';

import '../../features/scan_product/data/models/product_info_model.dart';
import '../models/restaurants_search_model.dart';
import '../models/scan_model.dart';
import '../../core/services/food_facts_services/food_facts_api_service.dart';

class Repository {
  final OpenFoodFactsApiServiceImpl openFoodFactApiProvider;
  final YelpFusionRestaurantsApiServiceImpl yelpFusionApiProvider;

  const Repository({
    required this.openFoodFactApiProvider,
    required this.yelpFusionApiProvider,
  });

  Future<SearchModel> searchQuery(String query) async {
    final searchResponse = await openFoodFactApiProvider.searchProductInfo(query);
    print(searchResponse.statusCode);
    SearchModel searchModel = searchModelFromJson(searchResponse.body.toString());
    return searchModel;
  }

  // Future<YelpRestaurantsModel> getRestaurantsNearMe(Position position) async {
  //   final response = await yelpFusionApiProvider.getRestaurantsNearMe(position);
  //   YelpRestaurantsModel yelpRestaurantsSearchModel = yelpRestaurantsSearchModelFromJson(response.body);
  //   return yelpRestaurantsSearchModel;
  // }

  // Future<Position> getCurrentLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   return position;
  // }
}
