import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_details_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:uuid/uuid.dart';

abstract class RestaurantsRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurantsNearMe({
    required Position position,
  });

  Future<RestaurantDetailsModel> getRestaurantDetails({
    required String id,
  });

  Future<UserLocationModel> getUserLocation();

  Future<MapModel> getRestaurantsMarkers({
    required List<Restaurant> restaurants,
  });

  Future<List<RestaurantDetailsModel>> getSavedRestaurantsList({
    required List<String> restaurantsIdsList,
  });

  Future<void> removeRestaurant({
    required String restaurantId,
  });

  Future<void> saveRestaurant({
    required String restaurantId,
  });

  Future<void> addRestaurantReview(RestaurantReview restaurantReview);

  Future<List<RestaurantReviewModel>> getRestaurantReviews(String postId);
}

const kGetRestaurantsEndPoint = 'nearbysearch/';
const kGetRestaurantDetails = 'details/';

class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
  RestaurantsRemoteDataSourceImpl(
    this._client,
    this._location,
    this._googleMap,
    this._cloudStoreClient,
    this._dbClient,
    this._authClient,
  );

  final Client _client;
  final LocationPlugin _location;
  final GoogleMapPlugin _googleMap;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;
  final FirebaseAuth _authClient;

  @override
  Future<RestaurantDetailsModel> getRestaurantDetails({
    required String id,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kGooglePlaceBaseUrl$kGetRestaurantDetails'
          'json?key=$kGoogleApiKey&place_id=$id&fields=all',
        ),
      );

      if (response.statusCode != 200) {
        throw RestaurantDetailsException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final data = jsonDecode(response.body) as DataMap;
      final restaurantDetails = RestaurantDetailsModel.fromMap(
        data['result'] as DataMap,
      );
      return restaurantDetails;
    } on RestaurantDetailsException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw RestaurantDetailsException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantsNearMe({
    required Position position,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kGooglePlaceBaseUrl$kGetRestaurantsEndPoint'
          'json?key=$kGoogleApiKey&keyword=vegan'
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
    } on RestaurantsException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw RestaurantsException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserLocationModel> getUserLocation() async {
    try {
      final result = await _location.getCurrentLocation();
      final userLocation = UserLocationModel(position: result);
      return userLocation;
    } on UserLocationException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw UserLocationException(message: e.toString());
    }
  }

  @override
  Future<MapModel> getRestaurantsMarkers({required List<Restaurant> restaurants}) async {
    try {
      final result = await _googleMap.getRestaurantsMarkers(restaurants);
      return result;
    } on MapException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw MapException(message: e.toString());
    }
  }

  @override
  Future<List<RestaurantDetailsModel>> getSavedRestaurantsList({required List<String> restaurantsIdsList}) async {
    final restaurantsList = <RestaurantDetailsModel>[];
    for (final restaurantId in restaurantsIdsList) {
      final restaurant = await getRestaurantDetails(id: restaurantId);
      restaurantsList.add(restaurant);
    }
    return restaurantsList;
  }

  @override
  Future<void> removeRestaurant({required String restaurantId}) async {
    try {
      await _users.doc(_authClient.currentUser?.uid).update({
        'savedRestaurantsIds': FieldValue.arrayRemove([restaurantId]),
      });
    } on FirebaseException catch (e) {
      throw SaveFoodProductException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw SaveFoodProductException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> saveRestaurant({required String restaurantId}) async {
    try {
      await _users.doc(_authClient.currentUser?.uid).update({
        'savedRestaurantsIds': FieldValue.arrayUnion([restaurantId]),
      });
    } on FirebaseException catch (e) {
      throw SaveFoodProductException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw SaveFoodProductException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> addRestaurantReview(RestaurantReview restaurantReview) async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const AddRestaurantException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      // Create restaurantReview firestore reference
      final restaurantReviewReference = _cloudStoreClient.collection('restaurantReviews').doc();

      // Create restaurantReview model with restaurantReview id from references
      var restaurantReviewModel = (restaurantReview as RestaurantReviewModel).copyWith(
        id: restaurantReviewReference.id,
      );

      // // Create profile image firebase storage reference
      // final profileImageReference = _dbClient.ref().child(
      //       'restaurantReviews/${restaurantReviewModel.id}/profile_image/${restaurantReviewModel.userProfilePic}-pfp',
      //     );
      //
      // // use profile image reference to store image in firebase storage
      // // set the restaurantReviewModel image to the url returned
      // await profileImageReference.putFile(File(restaurantReviewModel.userProfilePic)).then((value) async {
      //   final url = await value.ref.getDownloadURL();
      //   restaurantReviewModel = restaurantReviewModel.copyWith(userProfilePic: url);
      // });

      await restaurantReviewReference.set(restaurantReviewModel.toMap());

      // Create restaurant firestore reference
      // Increment reviewsCount
      return _cloudStoreClient
          .collection('restaurants')
          .doc(restaurantReviewModel.restaurantId)
          .update({'restaurantReviewsCount': FieldValue.increment(1)});
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AddRestaurantException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on AddRestaurantException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AddRestaurantException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<RestaurantReviewModel>> getRestaurantReviews(String postId) async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const AddRestaurantException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      return _cloudStoreClient.collection('restaurantReviews').get().then((value) => value.docs
          .map(
            (doc) => RestaurantReviewModel.fromMap(
              doc.data(),
            ),
          )
          .toList());
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AddRestaurantException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on AddRestaurantException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AddRestaurantException(message: e.toString(), statusCode: '505');
    }
  }

  CollectionReference<Map<String, dynamic>> get _users => _cloudStoreClient.collection(
        FirebaseConstants.usersCollection,
      );
}
