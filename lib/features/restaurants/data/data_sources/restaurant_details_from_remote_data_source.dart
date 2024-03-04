import 'package:flutter/material.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/restaurants_services/restaurants_service.dart';
import '../models/google_restaurant_details_model.dart';
import '../models/yelp_restaurant_details_model.dart';

abstract class RestaurantDetailsFromRemoteDataSourceContract {
  Future getRestaurantDetails(String? id);
}

class RestaurantDetailsFromRemoteDataSourceYelpImpl implements RestaurantDetailsFromRemoteDataSourceContract {
  final RestaurantsApiServiceContract restaurantsApiServiceContract =
      serviceLocator<RestaurantsApiServiceContract>();

  @override
  Future<YelpRestaurantDetailsModel> getRestaurantDetails(String? id) async {
    try {
      Map<String, dynamic> data = await restaurantsApiServiceContract.getRestaurantDetails(id);
      YelpRestaurantDetailsModel restaurantDetailsModel = YelpRestaurantDetailsModel.fromJson(data);
      return restaurantDetailsModel;
    } catch (e) {
      debugPrint("RestaurantDetails: $e");
      throw const GetRestaurantDetailsException(message: "Failed to get restaurant information");
    }
  }
}

class RestaurantDetailsFromRemoteDataSourceGoogleImpl implements RestaurantDetailsFromRemoteDataSourceContract {
  final RestaurantsApiServiceContract restaurantsApiServiceContract =
      serviceLocator<RestaurantsApiServiceContract>();

  @override
  Future<GoogleRestaurantDetailsModel> getRestaurantDetails(String? id) async {
    try {
      Map<String, dynamic> data = await restaurantsApiServiceContract.getRestaurantDetails(id);
      GoogleRestaurantDetailsModel restaurantDetailsModel = GoogleRestaurantDetailsModel.fromJson(data['result']);
      return restaurantDetailsModel;
    } catch (e) {
      debugPrint("RestaurantDetails: $e");
      throw const GetRestaurantDetailsException(message: "Failed to get restaurant information");
    }
  }
}
