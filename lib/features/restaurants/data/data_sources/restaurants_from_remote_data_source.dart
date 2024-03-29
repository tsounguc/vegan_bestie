import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/services/restaurants_services/restaurants_service.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../models/google_restaurant_model.dart';
import '../models/yelp_restaurants_model.dart';

abstract class RestaurantsFromRemoteDataSourceContract {
  Future getRestaurantsNearMe(Position position);
}

class RestaurantsFromRemoteDataSourceYelpImpl implements RestaurantsFromRemoteDataSourceContract {
  final RestaurantsApiServiceContract restaurantsApiServiceContract =
      serviceLocator<RestaurantsApiServiceContract>();

  @override
  Future<List<YelpRestaurantModel>> getRestaurantsNearMe(Position position) async {
    try {
      //Receive results from api contract
      Map<String, dynamic> data = await restaurantsApiServiceContract.getRestaurantsNearMe(position);
      //Retrieve restaurants list from api received results
      List restaurantsData = data['businesses'];

      // Initialize a list of restaurant json/map Objects
      List<Map<String, dynamic>> restaurantJsonObjectsList = [];

      // Populate list of restaurant json/map objects with retrieved list from api received results
      for (int index = 0; index < restaurantsData.length; index++) {
        Map<String, dynamic> restaurantJsonObject = restaurantsData[index] as Map<String, dynamic>;
        restaurantJsonObjectsList.add(restaurantJsonObject);
      }

      debugPrint('${restaurantJsonObjectsList[3]}');
      // Initialize a list of restaurant models
      List<YelpRestaurantModel> restaurantModelsList = [];

      // Populate list of restaurant models
      for (int index = 0; index < restaurantJsonObjectsList.length; index++) {
        YelpRestaurantModel restaurantModel = YelpRestaurantModel.fromJson(restaurantJsonObjectsList[index]);
        restaurantModelsList.add(restaurantModel);
      }

      return restaurantModelsList;
    } catch (e) {
      throw const FetchRestaurantsNearMeException(message: "Failed to get list of restaurants");
    }
  }
}

class RestaurantsFromRemoteDataSourceGoogleImpl implements RestaurantsFromRemoteDataSourceContract {
  final RestaurantsApiServiceContract restaurantsApiServiceContract =
      serviceLocator<RestaurantsApiServiceContract>();

  @override
  Future<List<GoogleRestaurantModel>> getRestaurantsNearMe(Position position) async {
    try {
      //Receive results from api contract
      Map<String, dynamic> data = await restaurantsApiServiceContract.getRestaurantsNearMe(position);
      //Retrieve restaurants list from api received results
      List restaurantsData = data['results'];

      // Initialize a list of restaurant json/map Objects
      List<Map<String, dynamic>> restaurantJsonObjectsList = [];

      // Populate list of restaurant json/map objects with retrieved list from api received results
      for (int index = 0; index < restaurantsData.length; index++) {
        Map<String, dynamic> restaurantJsonObject = restaurantsData[index] as Map<String, dynamic>;
        restaurantJsonObjectsList.add(restaurantJsonObject);
      }

      // debugPrint('${restaurantJsonObjectsList[3]}');
      // Initialize a list of restaurant models
      List<GoogleRestaurantModel> restaurantModelsList = [];

      // Populate list of restaurant models
      for (int index = 0; index < restaurantJsonObjectsList.length; index++) {
        GoogleRestaurantModel restaurantModel = GoogleRestaurantModel.fromJson(restaurantJsonObjectsList[index]);
        restaurantModelsList.add(restaurantModel);
      }

      return restaurantModelsList;
    } catch (e) {
      print(e.toString());
      throw const FetchRestaurantsNearMeException(message: "Failed to get list of restaurants");
    }
  }
}
