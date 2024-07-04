import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/geocoding_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/core/utils/datasource_utils.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_submit_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';

abstract class RestaurantsRemoteDataSource {
  Future<void> addRestaurant({
    required Restaurant restaurant,
  });

  Future<void> submitRestaurant({
    required RestaurantSubmit restaurantSubmit,
  });

  Future<void> deleteRestaurantSubmission({
    required RestaurantSubmit restaurantSubmit,
  });

  Stream<List<RestaurantModel>> getRestaurantsNearMe({
    required Position position,
    required double radius,
  });

  Future<UserLocationModel> getUserLocation();

  Future<MapEntity> getRestaurantsMarkers({required List<Restaurant> restaurants});
}

class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
  RestaurantsRemoteDataSourceImpl(
      this._firestore, this._storage, this._auth, this._location, this._googleMap, this._geocoding);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  final LocationPlugin _location;
  final GeocodingPlugin _geocoding;
  final GoogleMapPlugin _googleMap;

  @override
  Future<void> addRestaurant({required Restaurant restaurant}) async {
    try {
      DataSourceUtils.authorizeUser(_auth);
      // Create restaurant firestore reference
      final restaurantsData = await _restaurants.get().then(
            (value) => value.docs
                .map(
                  (doc) => RestaurantModel.fromMap(doc.data()),
                )
                .toList(),
          );
      bool isInData = false;
      for (final restaurantData in restaurantsData) {
        if (restaurant.streetAddress == restaurantData.streetAddress) {
          isInData = true;
        }
      }

      if (!isInData) {
        final restaurantsReference = _restaurants.doc();
        // Get restaurant coordinates from address
        final fullAddress = '${restaurant.streetAddress},'
            ' ${restaurant.city}, '
            '${restaurant.state} ${restaurant.zipCode}';

        final geoPoint = await _geocoding.getCoordinateFromAddress(fullAddress);

        // Create course model with course id and group id from references
        var restaurantModel = RestaurantModel.copy(restaurant).copyWith(
          id: restaurantsReference.id,
          geoLocation: GeoLocationModel(
            lat: geoPoint.latitude,
            lng: geoPoint.longitude,
          ),
        );

        if (restaurantModel.imageIsFile) {
          // Create image firebase storage reference if image is file
          final imageReference =
              _storage.ref().child('restaurants/${restaurantModel.id}/image/${restaurantModel.name}/');

          // use image reference to store image in firebase storage
          // set the courseModel image to the url returned
          await imageReference.putFile(File(restaurantModel.image!)).then((value) async {
            final url = await value.ref.getDownloadURL();
            restaurantModel = restaurantModel.copyWith(image: url);
          });
        }

        // push restaurant model info to document in firestore
        return await restaurantsReference.set(restaurantModel.toMap());
      } else {
        throw const RestaurantsException(message: 'Restaurant is already listed', statusCode: 600);
      }
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint(e.message);
      throw RestaurantsException(
        message: e.message ?? 'Error occurred',
        statusCode: 500,
      );
    } on RestaurantsException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint(e.toString());
      throw RestaurantsException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> submitRestaurant({required RestaurantSubmit restaurantSubmit}) async {
    try {
      DataSourceUtils.authorizeUser(_auth);
      // Create restaurant firestore reference
      final submittedRestaurantsData = await _submittedRestaurants.get().then(
            (value) => value.docs
                .map(
                  (doc) => RestaurantSubmitModel.fromMap(doc.data()),
                )
                .toList(),
          );

      bool isInSubmittedData = false;

      for (final submittedData in submittedRestaurantsData) {
        if (restaurantSubmit.submittedRestaurant.streetAddress ==
                submittedData.submittedRestaurant.streetAddress &&
            restaurantSubmit.submittedRestaurant.name.toLowerCase() ==
                submittedData.submittedRestaurant.name.toLowerCase()) {
          isInSubmittedData = true;
        }
      }

      if (!isInSubmittedData) {
        final submittedRestaurantsReference = _submittedRestaurants.doc();
        // Get restaurant coordinates from address
        final fullAddress = '${restaurantSubmit.submittedRestaurant.streetAddress},'
            ' ${restaurantSubmit.submittedRestaurant.city}, '
            '${restaurantSubmit.submittedRestaurant.state} ${restaurantSubmit.submittedRestaurant.zipCode}';

        final geoPoint = await _geocoding.getCoordinateFromAddress(fullAddress);

        // Create restaurant model with course id and group id from references
        var restaurantModel = RestaurantModel.copy(restaurantSubmit.submittedRestaurant).copyWith(
          geoLocation: GeoLocationModel(
            lat: geoPoint.latitude,
            lng: geoPoint.longitude,
          ),
        );

        var restaurantSubmitModel = (restaurantSubmit as RestaurantSubmitModel).copyWith(
          id: submittedRestaurantsReference.id,
        );

        // push restaurant model info to document in firestore
        return await submittedRestaurantsReference.set(
          restaurantSubmitModel.toMap(),
        );
      } else {
        throw const RestaurantsException(message: 'Restaurant has already been submitted', statusCode: 601);
      }
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint(e.message);
      throw RestaurantsException(
        message: e.message ?? 'Error occurred',
        statusCode: 500,
      );
    } on RestaurantsException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      debugPrint(e.toString());
      throw RestaurantsException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteRestaurantSubmission({required RestaurantSubmit restaurantSubmit}) async {
    try {
      DataSourceUtils.authorizeUser(_auth);

      return _submittedRestaurants.doc(restaurantSubmit.id).delete();
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw RestaurantsException(
        message: e.message ?? 'Error occurred',
        statusCode: 500,
      );
    } on RestaurantsException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw RestaurantsException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Stream<List<RestaurantModel>> getRestaurantsNearMe({required Position position, required double radius}) {
    try {
      DataSourceUtils.authorizeUser(_auth);

      // final placemark = await _geocoding.getPlaceMarkFromPosition(
      //   latitude: position.latitude,
      //   longitude: position.longitude,
      // );
      // final userCity = placemark.locality?.toLowerCase().capitalizeFirstLetter();

      final distance = radius * 0.000621371;

      final greaterPoint = DataSourceUtils.getGreaterGeoPoint(position, distance);
      final lesserPoint = DataSourceUtils.getLesserGeoPoint(position, distance);

      final restaurantsStream = _restaurants
          .where('geoLocation.lat', isGreaterThan: lesserPoint.latitude)
          .where('geoLocation.lng', isGreaterThan: lesserPoint.longitude)
          .where('geoLocation.lat', isLessThan: greaterPoint.latitude)
          .where('geoLocation.lng', isLessThan: greaterPoint.longitude)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) => RestaurantModel.fromMap(doc.data())).toList(),
          );
      return restaurantsStream.handleError((dynamic error) {
        if (error is FirebaseException) {
          debugPrintStack(stackTrace: error.stackTrace);
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        }
        throw ServerException(
          message: error.toString(),
          statusCode: '505',
        );
      });
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw RestaurantsException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: 501,
      );
    } on RestaurantsException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw RestaurantsException(
        message: e.toString(),
        statusCode: 505,
      );
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
  Future<MapEntity> getRestaurantsMarkers({required List<Restaurant> restaurants}) async {
    try {
      final results = await _googleMap.getRestaurantsMarkers(restaurants: restaurants);
      return results;
    } on MapException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw MapException(message: e.toString());
    }
  }

  CollectionReference<Map<String, dynamic>> get _users => _firestore.collection(
        FirebaseConstants.usersCollection,
      );

  CollectionReference<Map<String, dynamic>> get _businesses => _firestore.collection(
        FirebaseConstants.businessesCollection,
      );

  CollectionReference<Map<String, dynamic>> get _restaurants => _firestore.collection(
        FirebaseConstants.restaurantsCollection,
      );

  CollectionReference<Map<String, dynamic>> get _submittedRestaurants => _firestore.collection(
        FirebaseConstants.submittedRestaurantsCollection,
      );
}

// abstract class RestaurantsRemoteDataSource {
//   Future<List<RestaurantEntityModel>> getRestaurantsNearMe({
//     required Position position,
//     required double radius,
//   });
//
//   Future<RestaurantDetailsModel> getRestaurantDetails({
//     required String id,
//   });
//
//   Future<UserLocationModel> getUserLocation();
//
//   Future<MapModel> getRestaurantsMarkers({
//     required List<RestaurantEntity> restaurants,
//   });
//
//   Future<List<RestaurantDetailsModel>> getSavedRestaurantsList({
//     required List<String> restaurantsIdsList,
//   });
//
//   Future<void> removeRestaurant({
//     required String restaurantId,
//   });
//
//   Future<void> saveRestaurant({
//     required String restaurantId,
//   });
//
//   Future<void> addRestaurantReview(RestaurantReview restaurantReview);
//
//   Future<List<RestaurantReviewModel>> getRestaurantReviews(String postId);
//
//   Future<void> deleteRestaurantReview(RestaurantReview restaurantReview);
//
//   Future<void> editRestaurantReview(RestaurantReview restaurantReview);
// }

// const kGetRestaurantsEndPoint = 'nearbysearch/';
// const kGetRestaurantDetails = 'details/';

// class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
//   RestaurantsRemoteDataSourceImpl(
//     this._client,
//     this._location,
//     this._googleMap,
//     this._cloudStoreClient,
//     this._dbClient,
//     this._authClient,
//   );
//
//   final Client _client;
//   final LocationPlugin _location;
//   final GoogleMapPlugin _googleMap;
//   final FirebaseFirestore _cloudStoreClient;
//   final FirebaseStorage _dbClient;
//   final FirebaseAuth _authClient;
//
//   @override
//   Future<RestaurantDetailsModel> getRestaurantDetails({
//     required String id,
//   }) async {
//     try {
//       final url = '$kGooglePlaceBaseUrl$kGetRestaurantDetails'
//           'json?key=$kGoogleApiKey&place_id=$id&fields=all';
//       final parsedUri = Uri.parse(url);
//
//       final request = Request('GET', parsedUri);
//
//       // final response = await _client.get(
//       //   Uri.parse(
//       //     '$kGooglePlaceBaseUrl$kGetRestaurantDetails'
//       //     'json?key=$kGoogleApiKey&place_id=$id&fields=all',
//       //   ),
//       // );
//
//       // final streamResponse = await request.send();
//       // final response = await Response.fromStream(streamResponse);
//       // if (response.statusCode != 200) {
//       //   throw RestaurantDetailsException(
//       //     message: response.body,
//       //     statusCode: response.statusCode,
//       //   );
//       // }
//
//       // final data = jsonDecode(response.body) as DataMap;
//       // final restaurantDetails = RestaurantDetailsModel.fromMap(
//       //   data['result'] as DataMap,
//       // );
//
//       // return restaurantDetails;
//       return RestaurantDetailsModel.empty();
//     } on RestaurantDetailsException catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       rethrow;
//     } catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       throw RestaurantDetailsException(message: e.toString(), statusCode: 500);
//     }
//   }
//
//   @override
//   Future<List<RestaurantEntityModel>> getRestaurantsNearMe({
//     required Position position,
//     required double radius,
//   }) async {
//     try {
//       final url = '$kGooglePlaceBaseUrl$kGetRestaurantsEndPoint'
//           'json?key=$kGoogleApiKey&keyword=vegan'
//           '&type=restaurant&location=${position.latitude},${position.longitude}'
//           '&radius=$radius'; // 12500
//       final parsedUri = Uri.parse(url);
//       final request = Request('GET', parsedUri);
//
//       // final streamResponse = await request.send();
//       // final response = await Response.fromStream(streamResponse);
//       // if (response.statusCode != 200) {
//       //   throw RestaurantsException(
//       //     message: response.body,
//       //     statusCode: response.statusCode,
//       //   );
//       // }
//       //
//       // final data = jsonDecode(response.body) as DataMap;
//       // debugPrint('Number of restaurants :  ${(data['results'] as List).length}');
//       //
//       // final restaurants = Set<RestaurantModel>.from(
//       //   (data['results'] as List).map(
//       //     (e) => RestaurantModel.fromMap(e as DataMap),
//       //   ),
//       // );
//       // if (data['next_page_token'] != null) {
//       //   final nextPageUrl = '${url}pagetoken=${data['next_page_token'] as String}';
//       //   final parsedUri = Uri.parse(nextPageUrl);
//       //   final request = Request('GET', parsedUri);
//       //
//       //   final streamResponse = await request.send();
//       //   final response = await Response.fromStream(streamResponse);
//       //   if (response.statusCode != 200) {
//       //     throw RestaurantsException(
//       //       message: response.body,
//       //       statusCode: response.statusCode,
//       //     );
//       //   }
//       //
//       //   final nextData = jsonDecode(response.body) as DataMap;
//       //   debugPrint('Number of next restaurants :  ${(nextData['results'] as List).length}');
//       //
//       //   final nextRestaurants = Set<RestaurantModel>.from(
//       //     (nextData['results'] as List).map(
//       //       (e) => RestaurantModel.fromMap(e as DataMap),
//       //     ),
//       //   );
//       //
//       //   restaurants.addAll(nextRestaurants);
//       // }
//       //
//       // return restaurants.toList();
//       return [RestaurantEntityModel.empty().copyWith(icon: '')];
//     } on RestaurantsException catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       rethrow;
//     } catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       throw RestaurantsException(message: e.toString(), statusCode: 500);
//     }
//   }
//
//   @override
//   Future<UserLocationModel> getUserLocation() async {
//     try {
//       final result = await _location.getCurrentLocation();
//       final userLocation = UserLocationModel(position: result);
//       return userLocation;
//     } on UserLocationException catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       rethrow;
//     } catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       throw UserLocationException(message: e.toString());
//     }
//   }
//
//   @override
//   Future<MapModel> getRestaurantsMarkers({required List<RestaurantEntity> restaurants}) async {
//     try {
//       final result = await _googleMap.getRestaurantsMarkers(restaurants);
//       return result;
//     } on MapException catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       rethrow;
//     } catch (e, stackTrace) {
//       debugPrint(stackTrace.toString());
//       throw MapException(message: e.toString());
//     }
//   }
//
//   @override
//   Future<List<RestaurantDetailsModel>> getSavedRestaurantsList({required List<String> restaurantsIdsList}) async {
//     final restaurantsList = <RestaurantDetailsModel>[];
//     for (final restaurantId in restaurantsIdsList) {
//       final restaurant = await getRestaurantDetails(id: restaurantId);
//       restaurantsList.add(restaurant);
//     }
//     return restaurantsList;
//   }
//
//   @override
//   Future<void> removeRestaurant({required String restaurantId}) async {
//     try {
//       await _users.doc(_authClient.currentUser?.uid).update({
//         'savedRestaurantsIds': FieldValue.arrayRemove([restaurantId]),
//       });
//     } on FirebaseException catch (e) {
//       throw SaveFoodProductException(
//         message: e.message ?? 'Error Occurred',
//         statusCode: e.code,
//       );
//     } catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw SaveFoodProductException(
//         message: e.toString(),
//         statusCode: '505',
//       );
//     }
//   }
//
//   @override
//   Future<void> saveRestaurant({required String restaurantId}) async {
//     try {
//       await _users.doc(_authClient.currentUser?.uid).update({
//         'savedRestaurantsIds': FieldValue.arrayUnion([restaurantId]),
//       });
//     } on FirebaseException catch (e) {
//       throw SaveFoodProductException(
//         message: e.message ?? 'Error Occurred',
//         statusCode: e.code,
//       );
//     } catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw SaveFoodProductException(
//         message: e.toString(),
//         statusCode: '505',
//       );
//     }
//   }
//
//   @override
//   Future<void> addRestaurantReview(RestaurantReview restaurantReview) async {
//     try {
//       final user = _authClient.currentUser;
//       if (user == null) {
//         throw const AddRestaurantReviewException(
//           message: 'User is not authenticated',
//           statusCode: '401',
//         );
//       }
//       // Create restaurantReview firestore reference
//       final restaurantReviewReference = _restaurantReviews.doc();
//
//       // Create restaurantReview model with restaurantReview id from references
//       final restaurantReviewModel = (restaurantReview as RestaurantReviewModel).copyWith(
//         id: restaurantReviewReference.id,
//       );
//
//       // // Create profile image firebase storage reference
//       // final profileImageReference = _dbClient.ref().child(
//       //       'restaurantReviews/${restaurantReviewModel.id}/profile_image/${restaurantReviewModel.userProfilePic}-pfp',
//       //     );
//       //
//       // // use profile image reference to store image in firebase storage
//       // // set the restaurantReviewModel image to the url returned
//       // await profileImageReference.putFile(File(restaurantReviewModel.userProfilePic)).then((value) async {
//       //   final url = await value.ref.getDownloadURL();
//       //   restaurantReviewModel = restaurantReviewModel.copyWith(userProfilePic: url);
//       // });
//
//       await restaurantReviewReference.set(
//         restaurantReviewModel.toMap(),
//       );
//
//       // Create restaurant firestore reference
//       // Increment reviewsCount
//       return await _restaurants.doc(restaurantReviewModel.restaurantId).set(
//         {
//           'restaurantId': restaurantReview.restaurantId,
//           'restaurantReviewsCount': FieldValue.increment(1),
//         },
//         SetOptions(merge: true),
//       );
//     } on FirebaseException catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw AddRestaurantReviewException(
//         message: e.message ?? 'Unknown error occurred',
//         statusCode: e.code,
//       );
//     } on AddRestaurantReviewException {
//       rethrow;
//     } catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw AddRestaurantReviewException(message: e.toString(), statusCode: '505');
//     }
//   }
//
//   @override
//   Future<List<RestaurantReviewModel>> getRestaurantReviews(String restaurantId) async {
//     try {
//       final user = _authClient.currentUser;
//       if (user == null) {
//         throw const GetRestaurantReviewsException(
//           message: 'User is not authenticated',
//           statusCode: '401',
//         );
//       }
//
//       return _restaurantReviews
//           .where(
//             'restaurantId',
//             isEqualTo: restaurantId,
//           )
//           .get()
//           .then(
//             (value) => value.docs
//                 .map(
//                   (doc) => RestaurantReviewModel.fromMap(doc.data()),
//                 )
//                 .toList(),
//           );
//     } on FirebaseException catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw GetRestaurantReviewsException(
//         message: e.message ?? 'Unknown error occurred',
//         statusCode: e.code,
//       );
//     } on GetRestaurantReviewsException {
//       rethrow;
//     } catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw GetRestaurantReviewsException(message: e.toString(), statusCode: '505');
//     }
//   }
//
//   @override
//   Future<void> deleteRestaurantReview(RestaurantReview restaurantReview) {
//     try {
//       final user = _authClient.currentUser;
//       if (user == null) {
//         throw const AddRestaurantReviewException(
//           message: 'User is not authenticated',
//           statusCode: '401',
//         );
//       }
//
//       return _restaurantReviews.doc(restaurantReview.id).delete();
//     } on FirebaseException catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw DeleteRestaurantReviewException(
//         message: e.message ?? 'Unknown error occurred',
//         statusCode: e.code,
//       );
//     } on DeleteRestaurantReviewException {
//       rethrow;
//     } catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw DeleteRestaurantReviewException(message: e.toString(), statusCode: '505');
//     }
//   }
//
//   @override
//   Future<void> editRestaurantReview(RestaurantReview restaurantReview) {
//     try {
//       final user = _authClient.currentUser;
//       if (user == null) {
//         throw const AddRestaurantReviewException(
//           message: 'User is not authenticated',
//           statusCode: '401',
//         );
//       }
//
//       return _restaurantReviews
//           .doc(restaurantReview.id)
//           .update((restaurantReview as RestaurantReviewModel).copyWith(updatedAt: DateTime.timestamp()).toMap());
//     } on FirebaseException catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw EditRestaurantReviewException(
//         message: e.message ?? 'Unknown error occurred',
//         statusCode: e.code,
//       );
//     } on EditRestaurantReviewException {
//       rethrow;
//     } catch (e, s) {
//       debugPrintStack(stackTrace: s);
//       throw EditRestaurantReviewException(message: e.toString(), statusCode: '505');
//     }
//   }
//
//   CollectionReference<Map<String, dynamic>> get _users => _cloudStoreClient.collection(
//         FirebaseConstants.usersCollection,
//       );
//
//   CollectionReference<Map<String, dynamic>> get _restaurants => _cloudStoreClient.collection(
//         FirebaseConstants.restaurantsCollection,
//       );
//
//   CollectionReference<Map<String, dynamic>> get _restaurantReviews => _cloudStoreClient.collection(
//         FirebaseConstants.restaurantReviewsCollection,
//       );
// }
