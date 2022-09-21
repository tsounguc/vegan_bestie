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
  // final RestaurantsApiProvider restaurantsApiProvider;
  // final GooglePlacesApiProvider googlePlacesApiProvider;
  final YelpFusionApiProvider yelpFusionApiProvider;

  const Repository({
    required this.openFoodFactApiProvider,
    required this.yelpFusionApiProvider,
  });
  Future<ScanModel?> fetchProduct(String barcode) async {
    // print("fetching barcode: $barcode");
    final fetchResponse = await openFoodFactApiProvider.fetchProductInfo(barcode);
    ScanModel productInfo = scanModelFromJson(fetchResponse.body.toString());
    return productInfo;
  }

  Future<SearchModel> searchQuery(String query) async {
    // try {
    final searchResponse = await openFoodFactApiProvider.searchProductInfo(query);
    print(searchResponse.statusCode);
    SearchModel searchModel = searchModelFromJson(searchResponse.body.toString());
    // print("first product ${searchModel.products?[0].productName}");
    return searchModel;
    // }catch(e){
    //   throw Exception(e);
    // }
  }

  Future<YelpRestaurantsSearchModel> getRestaurantsNearMe(Position position) async {
    // final response = await restaurantsApiProvider.searchRestaurants("");
    // final response = await googlePlacesApiProvider.getRestaurantsNearMe();
    final response = await yelpFusionApiProvider.getLocalRestaurants(position);
    // print(response.body);
    // RestaurantsResultsModel restaurantsResultsModel = restaurantsResultsModelFromJson(response.body.toString());
    // GoogleRestaurantsSearchModel googleRestaurantsSearchModel =
    //     googleRestaurantsSearchModelFromJson(response.body.toString());
    YelpRestaurantsSearchModel yelpRestaurantsSearchModel = yelpRestaurantsSearchModelFromJson(response.body);
    // return restaurantsResultsModel;
    // return googleRestaurantsSearchModel;
    return yelpRestaurantsSearchModel;
  }

  Future<Position> getCurrentLocation() async {
    // bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   return Future.error("Location Services are disable.");
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
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
