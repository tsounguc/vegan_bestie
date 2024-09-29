import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/geocoding_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/core/utils/datasource_utils.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_submit_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';

abstract class RestaurantsRemoteDataSource {
  Future<UserLocationModel> getUserLocation();

  Future<void> addRestaurant({
    required Restaurant restaurant,
  });

  Future<void> submitRestaurant({
    required RestaurantSubmit restaurantSubmit,
  });

  Future<void> deleteRestaurantSubmission({
    required RestaurantSubmit restaurantSubmit,
  });

  Future<void> updateRestaurant({
    required UpdateRestaurantInfoAction action,
    required dynamic restaurantData,
    required Restaurant restaurant,
  });

  Future<void> saveRestaurant({required String restaurantId});

  Future<void> unSaveRestaurant({required String restaurantId});

  Future<void> deleteRestaurant({required String restaurantId});

  Stream<List<RestaurantModel>> getRestaurantsNearMe({
    required Position position,
    required double radius,
    String startAfterId = '',
    int paginationSize = 10,
  });

  Future<void> addRestaurantReview(RestaurantReview restaurantReview);

  Future<List<RestaurantReview>> getRestaurantReviews(String restaurantId);

  Future<void> editRestaurantReview(RestaurantReview restaurantReview);

  Future<void> deleteRestaurantReview(RestaurantReview restaurantReview);

  Future<MapEntity> getRestaurantsMarkers({required List<Restaurant> restaurants});

  Future<List<RestaurantModel>> getSavedRestaurants({
    required List<String> restaurantsIdsList,
  });
}

class RestaurantsRemoteDataSourceImpl implements RestaurantsRemoteDataSource {
  RestaurantsRemoteDataSourceImpl(
    this._firestore,
    this._storage,
    this._auth,
    this._location,
    this._googleMap,
    this._geocoding,
  );

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  final LocationPlugin _location;
  final GeocodingPlugin _geocoding;
  final GoogleMapPlugin _googleMap;

  @override
  Future<void> updateRestaurant({
    required UpdateRestaurantInfoAction action,
    required dynamic restaurantData,
    required Restaurant restaurant,
  }) async {
    try {
      switch (action) {
        case UpdateRestaurantInfoAction.thumbnail:
          final thumbnailRef =
              _storage.ref().child('restaurants/${restaurant.name}${restaurant.id}/thumbnail/${restaurant.id}');

          await thumbnailRef.putFile(restaurantData as File);

          final thumbnailUrl = await thumbnailRef.getDownloadURL();

          final photos = restaurant.photos;
          for (var index = 0; index < photos.length; index++) {
            if (photos[index].contains('_empty.photo') || photos[index].isEmpty) {
              photos.removeAt(index);
            }
          }
          final photosRef = _storage.ref().child(
                'restaurants/${restaurant.name}${restaurant.id}/'
                'photos/${photos.length + 1}_${restaurant.id}',
              );

          await photosRef.putFile(restaurantData);

          final photoUrl = await photosRef.getDownloadURL();

          photos.add(photoUrl);

          await _updateRestaurantData(
            id: restaurant.id,
            data: {
              'thumbnail': thumbnailUrl,
              'photos': photos,
            },
          );

        case UpdateRestaurantInfoAction.name:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'name': restaurantData},
          );
        case UpdateRestaurantInfoAction.streetAddress:
          final fullAddress = '$restaurantData,'
              ' ${restaurant.city}, '
              '${restaurant.state} ${restaurant.zipCode}';

          final geoPoint = await _geocoding.getCoordinateFromAddress(fullAddress);

          await _updateRestaurantData(
            id: restaurant.id,
            data: {
              'streetAddress': restaurantData,
              'geoLocation': {
                'lat': geoPoint.latitude,
                'lng': geoPoint.longitude,
              },
            },
          );
        case UpdateRestaurantInfoAction.city:
          final fullAddress = '${restaurant.streetAddress},'
              ' $restaurantData, '
              '${restaurant.state} ${restaurant.zipCode}';

          final geoPoint = await _geocoding.getCoordinateFromAddress(fullAddress);

          await _updateRestaurantData(
            id: restaurant.id,
            data: {
              'city': restaurantData,
              'geoLocation': {
                'lat': geoPoint.latitude,
                'lng': geoPoint.longitude,
              },
            },
          );
        case UpdateRestaurantInfoAction.state:
          final fullAddress = '${restaurant.streetAddress},'
              ' ${restaurant.city}, '
              '$restaurantData ${restaurant.zipCode}';

          final geoPoint = await _geocoding.getCoordinateFromAddress(fullAddress);

          await _updateRestaurantData(
            id: restaurant.id,
            data: {
              'state': restaurantData,
              'geoLocation': {
                'lat': geoPoint.latitude,
                'lng': geoPoint.longitude,
              },
            },
          );
        case UpdateRestaurantInfoAction.zipcode:
          final fullAddress = '${restaurant.streetAddress},'
              ' ${restaurant.city}, '
              '${restaurant.state} $restaurantData';

          final geoPoint = await _geocoding.getCoordinateFromAddress(fullAddress);

          await _updateRestaurantData(
            id: restaurant.id,
            data: {
              'zipcode': restaurantData,
              'geoLocation': {
                'lat': geoPoint.latitude,
                'lng': geoPoint.longitude,
              },
            },
          );
        case UpdateRestaurantInfoAction.description:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'description': restaurantData},
          );

        case UpdateRestaurantInfoAction.email:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'email': restaurantData},
          );
        case UpdateRestaurantInfoAction.phoneNumber:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'phoneNumber': restaurantData},
          );
        case UpdateRestaurantInfoAction.website:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'websiteUrl': restaurantData},
          );
        case UpdateRestaurantInfoAction.permanentlyClosed:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'permanentlyClosed': restaurantData},
          );
        case UpdateRestaurantInfoAction.openHours:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {
              'openHours': (restaurantData as OpenHoursModel).toMap(),
            },
          );
        case UpdateRestaurantInfoAction.takeout:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'takeout': restaurantData},
          );
        case UpdateRestaurantInfoAction.dineIn:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'dineIn': restaurantData},
          );
        case UpdateRestaurantInfoAction.delivery:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'delivery': restaurantData},
          );
        case UpdateRestaurantInfoAction.veganStatus:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'veganStatus': restaurantData},
          );
        case UpdateRestaurantInfoAction.hasVeganOptions:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'hasVeganOptions': restaurantData},
          );
        case UpdateRestaurantInfoAction.price:
          await _updateRestaurantData(
            id: restaurant.id,
            data: {'price': restaurantData},
          );
      }
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
      var isInData = false;
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
          await imageReference.putFile(File(restaurantModel.thumbnail!)).then((value) async {
            final url = await value.ref.getDownloadURL();
            restaurantModel = restaurantModel.copyWith(thumbnail: url);
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

      var isInSubmittedData = false;

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

        // Copy submittedRestaurant with geoLocation added
        final submittedRestaurantModel = RestaurantModel.copy(
          restaurantSubmit.submittedRestaurant,
        ).copyWith(
          geoLocation: GeoLocationModel(
            lat: geoPoint.latitude,
            lng: geoPoint.longitude,
          ),
        );

        final restaurantSubmitModel = (restaurantSubmit as RestaurantSubmitModel)
            .copyWith(id: submittedRestaurantsReference.id, submittedRestaurant: submittedRestaurantModel);

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
  Stream<List<RestaurantModel>> getRestaurantsNearMe({
    required Position position,
    required double radius,
    String startAfterId = '',
    int paginationSize = 10,
  }) {
    try {
      DataSourceUtils.authorizeUser(_auth);

      final distance = radius * 0.000621371;

      final greaterPoint = DataSourceUtils.getGreaterGeoPoint(position, distance);
      final lesserPoint = DataSourceUtils.getLesserGeoPoint(position, distance);

      var restaurantsQuery = _restaurants
          .where('geoLocation.lat', isGreaterThan: lesserPoint.latitude)
          .where('geoLocation.lng', isGreaterThan: lesserPoint.longitude)
          .where('geoLocation.lat', isLessThan: greaterPoint.latitude)
          .where('geoLocation.lng', isLessThan: greaterPoint.longitude)
          .orderBy('id')
          .limit(paginationSize);

      if (startAfterId.isNotEmpty) {
        restaurantsQuery = restaurantsQuery.startAfter([startAfterId]);
      }

      final restaurantsStream = restaurantsQuery.snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => RestaurantModel.fromMap(doc.data()),
                )
                .toList(),
          );
      return restaurantsStream.handleError((dynamic error) {
        if (error is FirebaseException) {
          debugPrintStack(stackTrace: error.stackTrace);
          if (error.code != 'PERMISSION_DENIED') {
            throw ServerException(
              message: error.message ?? 'Unknown error occurred',
              statusCode: error.code,
            );
          }
        }
        throw ServerException(
          message: error.toString(),
          statusCode: '505',
        );
      });
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: '501',
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
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

  @override
  Future<void> deleteRestaurant({required String restaurantId}) {
    try {
      DataSourceUtils.authorizeUser(_auth);
      return _restaurants.doc(restaurantId).delete();
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
  Future<List<RestaurantReview>> getRestaurantReviews(String restaurantId) {
    try {
      DataSourceUtils.authorizeUser(_auth);

      return _restaurantReviews
          .where(
            'restaurantId',
            isEqualTo: restaurantId,
          )
          .get()
          .then(
            (value) => value.docs
                .map(
                  (doc) => RestaurantReviewModel.fromMap(doc.data()),
                )
                .toList(),
          );
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw GetRestaurantReviewsException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on GetRestaurantReviewsException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw GetRestaurantReviewsException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> addRestaurantReview(RestaurantReview restaurantReview) async {
    try {
      DataSourceUtils.authorizeUser(_auth);
      // Create restaurantReview firestore reference
      final restaurantReviewReference = _restaurantReviews.doc();

      // Create restaurantReview model with restaurantReview id from references
      final restaurantReviewModel = (restaurantReview as RestaurantReviewModel).copyWith(
        id: restaurantReviewReference.id,
      );

      await restaurantReviewReference.set(
        restaurantReviewModel.toMap(),
      );

      // Create restaurant firestore reference
      // Increment reviewsCount
      return await _restaurants.doc(restaurantReviewModel.restaurantId).set(
        {
          'restaurantId': restaurantReview.restaurantId,
          'restaurantReviewsCount': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AddRestaurantReviewException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on AddRestaurantReviewException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AddRestaurantReviewException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> deleteRestaurantReview(RestaurantReview restaurantReview) async {
    try {
      DataSourceUtils.authorizeUser(_auth);
      return _restaurantReviews.doc(restaurantReview.id).delete();
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw DeleteRestaurantReviewException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on DeleteRestaurantReviewException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw DeleteRestaurantReviewException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> editRestaurantReview(RestaurantReview restaurantReview) async {
    try {
      DataSourceUtils.authorizeUser(_auth);

      return _restaurantReviews
          .doc(restaurantReview.id)
          .update((restaurantReview as RestaurantReviewModel).copyWith(updatedAt: DateTime.timestamp()).toMap());
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw EditRestaurantReviewException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on EditRestaurantReviewException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw EditRestaurantReviewException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> saveRestaurant({required String restaurantId}) async {
    try {
      DataSourceUtils.authorizeUser(_auth);

      await _users.doc(_auth.currentUser?.uid).update({
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
  Future<void> unSaveRestaurant({required String restaurantId}) async {
    try {
      DataSourceUtils.authorizeUser(_auth);

      await _users.doc(_auth.currentUser?.uid).update({
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
  Future<List<RestaurantModel>> getSavedRestaurants({
    required List<String> restaurantsIdsList,
  }) async {
    DataSourceUtils.authorizeUser(_auth);

    final restaurantsList = <RestaurantModel>[];
    for (final restaurantId in restaurantsIdsList) {
      final restaurant = await _restaurants.doc(restaurantId).get().then(
            (value) => RestaurantModel.fromMap(
              value.data()!,
            ),
          );
      restaurantsList.add(restaurant);
    }
    return restaurantsList;
  }

  Future<void> _updateRestaurantData({
    required String id,
    required DataMap data,
  }) async {
    await _restaurants.doc(id).update(data);
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

  CollectionReference<Map<String, dynamic>> get _restaurantReviews => _firestore.collection(
        FirebaseConstants.restaurantReviewsCollection,
      );
}
