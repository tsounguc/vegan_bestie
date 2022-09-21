import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/data/models/google_restaurants_search_model.dart';
import 'package:sheveegan/data/models/search_model.dart';
import 'package:sheveegan/data/models/yelp_restaurants_search_model.dart';
import 'package:sheveegan/data/providers/google_places_api_provider.dart';
import 'package:sheveegan/data/providers/restaurants_api_provider.dart';
import 'package:sheveegan/data/providers/yelp_fusion_api_provider.dart';

import '../models/product_info_model.dart';
import '../models/restaurants_search_model.dart';
import '../models/scan_model.dart';
import '../providers/open_food_facts_api_provider.dart';

class Repository {
  final OpenFoodFactsApiProvider openFoodFactApiProvider;
  final YelpFusionApiProvider yelpFusionApiProvider;

  const Repository({
    required this.openFoodFactApiProvider,
    required this.yelpFusionApiProvider,
  });
  Future<ScanModel?> fetchProduct(String barcode) async {
    final fetchResponse = await openFoodFactApiProvider.fetchProductInfo(barcode);
    ScanModel productInfo = scanModelFromJson(fetchResponse.body.toString());
    return productInfo;
  }

  Future<SearchModel> searchQuery(String query) async {
    final searchResponse = await openFoodFactApiProvider.searchProductInfo(query);
    print(searchResponse.statusCode);
    SearchModel searchModel = searchModelFromJson(searchResponse.body.toString());
    return searchModel;
  }

  Future<YelpRestaurantsSearchModel> getRestaurantsNearMe(Position position) async {
    final response = await yelpFusionApiProvider.getLocalRestaurants(position);
    YelpRestaurantsSearchModel yelpRestaurantsSearchModel = yelpRestaurantsSearchModelFromJson(response.body);
    return yelpRestaurantsSearchModel;
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
