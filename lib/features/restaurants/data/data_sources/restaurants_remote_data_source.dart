import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/services/restaurants_services/restaurants_service.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

abstract class RestaurantsRemoteDataSource {
  Future<List<Restaurant>> getRestaurantsNearMe({required Position position});

  Future<RestaurantDetails> getRestaurantDetails({required String id});
}

class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
  @override
  Future<RestaurantDetails> getRestaurantDetails({required String id}) {
    // TODO: implement getRestaurantDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurant>> getRestaurantsNearMe({required Position position}) {
    // TODO: implement getRestaurantsNearMe
    throw UnimplementedError();
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
