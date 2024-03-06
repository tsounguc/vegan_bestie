import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_details_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';

abstract class RestaurantsRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurantsNearMe({required Position position});

  Future<RestaurantDetailsModel> getRestaurantDetails({required String id});
}

const kGetRestaurantsEndPoint = 'nearbysearch/';
const kGetRestaurantDetails = 'details/';

class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
  RestaurantsRemoteDataSourceImpl(this._client);

  final Client _client;
  final apiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];

  @override
  Future<RestaurantDetailsModel> getRestaurantDetails({
    required String id,
  }) async {
    final response = await _client.get(
      Uri.parse(
        '$kGooglePlaceBaseUrl$kGetRestaurantDetails'
        'json?key=$apiKey&place_id=$id&fields=all',
      ),
    );
    final data = jsonDecode(response.body) as DataMap;
    final restaurantDetails = RestaurantDetailsModel.fromMap(
      data['result'] as DataMap,
    );
    return restaurantDetails;
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsNearMe({required Position position}) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kGooglePlaceBaseUrl$kGetRestaurantsEndPoint'
          'json?key=$apiKey&keyword=vegan'
          '&type=restaurant&location=${position.latitude},${position.longitude}'
          '&radius=12500',
        ),
      );
      if (response.statusCode != 200) {
        throw RestaurantsException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final data = jsonDecode(response.body) as DataMap;
      final restaurants = List<RestaurantModel>.from(
        (data['results'] as List).map(
          (e) => RestaurantModel.fromMap(e as DataMap),
        ),
      );

      return restaurants;
    } on RestaurantsException {
      rethrow;
    } catch (e) {
      throw RestaurantsException(message: e.toString(), statusCode: 500);
    }
  }
}

// class RestaurantsFromRemoteDataSourceYelpImpl implements RestaurantsRemoteDataSource {
//   final RestaurantsApiServiceContract restaurantsApiServiceContract =
//       serviceLocator<RestaurantsApiServiceContract>();
//
//   @override
//   Future<List<YelpRestaurantModel>> getRestaurantsNearMe(Position position) async {
//     try {
//       //Receive results from api contract
//       Map<String, dynamic> data = await restaurantsApiServiceContract.getRestaurantsNearMe(position);
//       //Retrieve restaurants list from api received results
//       List restaurantsData = data['businesses'];
//
//       // Initialize a list of restaurant json/map Objects
//       List<Map<String, dynamic>> restaurantJsonObjectsList = [];
//
//       // Populate list of restaurant json/map objects with retrieved list from api received results
//       for (int index = 0; index < restaurantsData.length; index++) {
//         Map<String, dynamic> restaurantJsonObject = restaurantsData[index] as Map<String, dynamic>;
//         restaurantJsonObjectsList.add(restaurantJsonObject);
//       }
//
//       debugPrint('${restaurantJsonObjectsList[3]}');
//       // Initialize a list of restaurant models
//       List<YelpRestaurantModel> restaurantModelsList = [];
//
//       // Populate list of restaurant models
//       for (int index = 0; index < restaurantJsonObjectsList.length; index++) {
//         YelpRestaurantModel restaurantModel = YelpRestaurantModel.fromJson(restaurantJsonObjectsList[index]);
//         restaurantModelsList.add(restaurantModel);
//       }
//
//       return restaurantModelsList;
//     } catch (e) {
//       throw const GetRestaurantsException(message: "Failed to get list of restaurants");
//     }
//   }
// }

// class RestaurantsFromRemoteDataSourceGoogleImpl implements RestaurantsRemoteDataSource {
//   final RestaurantsApiServiceContract restaurantsApiServiceContract =
//       serviceLocator<RestaurantsApiServiceContract>();
//
//   @override
//   Future<List<GoogleRestaurantModel>> getRestaurantsNearMe(Position position) async {
//     try {
//       //Receive results from api contract
//       Map<String, dynamic> data = await restaurantsApiServiceContract.getRestaurantsNearMe(position);
//       //Retrieve restaurants list from api received results
//       List restaurantsData = data['results'];
//
//       // Initialize a list of restaurant json/map Objects
//       List<Map<String, dynamic>> restaurantJsonObjectsList = [];
//
//       // Populate list of restaurant json/map objects with retrieved list from api received results
//       for (int index = 0; index < restaurantsData.length; index++) {
//         Map<String, dynamic> restaurantJsonObject = restaurantsData[index] as Map<String, dynamic>;
//         restaurantJsonObjectsList.add(restaurantJsonObject);
//       }
//
//       // debugPrint('${restaurantJsonObjectsList[3]}');
//       // Initialize a list of restaurant models
//       List<GoogleRestaurantModel> restaurantModelsList = [];
//
//       // Populate list of restaurant models
//       for (int index = 0; index < restaurantJsonObjectsList.length; index++) {
//         GoogleRestaurantModel restaurantModel = GoogleRestaurantModel.fromJson(restaurantJsonObjectsList[index]);
//         restaurantModelsList.add(restaurantModel);
//       }
//
//       return restaurantModelsList;
//     } catch (e) {
//       print(e.toString());
//       throw const GetRestaurantsException(message: "Failed to get list of restaurants");
//     }
//   }
// }
