import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_submission.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/edit_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_saved_restaurants.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/save_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/submit_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/unsave_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/update_restaurant.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit({
    required AddRestaurant addRestaurant,
    required UpdateRestaurant updateRestaurant,
    required SubmitRestaurant submitRestaurant,
    required DeleteRestaurantSubmission deleteRestaurantSubmission,
    required GetUserLocation getUserLocation,
    required GetRestaurantsNearMe getRestaurantsNearMe,
    required GetRestaurantsMarkers getRestaurantsMarkers,
    required AddRestaurantReview addRestaurantReview,
    required DeleteRestaurantReview deleteRestaurantReview,
    required EditRestaurantReview editRestaurantReview,
    required SaveRestaurant saveRestaurant,
    required GetSavedRestaurants getSavedRestaurants,
    required UnSaveRestaurant unSaveRestaurant,
  })  : _addRestaurant = addRestaurant,
        _submitRestaurant = submitRestaurant,
        _updateRestaurant = updateRestaurant,
        _deleteRestaurantSubmission = deleteRestaurantSubmission,
        _getUserLocation = getUserLocation,
        _getRestaurantsNearMe = getRestaurantsNearMe,
        _getRestaurantsMarkers = getRestaurantsMarkers,
        _addRestaurantReview = addRestaurantReview,
        _deleteRestaurantReview = deleteRestaurantReview,
        _editRestaurantReview = editRestaurantReview,
        _saveRestaurant = saveRestaurant,
        _unSaveRestaurant = unSaveRestaurant,
        _getSavedRestaurants = getSavedRestaurants,
        super(const RestaurantsInitial());

  final AddRestaurant _addRestaurant;
  final SubmitRestaurant _submitRestaurant;
  final UpdateRestaurant _updateRestaurant;
  final DeleteRestaurantSubmission _deleteRestaurantSubmission;
  final GetRestaurantsNearMe _getRestaurantsNearMe;
  final GetUserLocation _getUserLocation;
  final GetRestaurantsMarkers _getRestaurantsMarkers;
  final AddRestaurantReview _addRestaurantReview;
  final DeleteRestaurantReview _deleteRestaurantReview;
  final EditRestaurantReview _editRestaurantReview;
  final SaveRestaurant _saveRestaurant;
  final UnSaveRestaurant _unSaveRestaurant;
  final GetSavedRestaurants _getSavedRestaurants;

  Future<void> addRestaurant(Restaurant restaurant) async {
    emit(const AddingRestaurant());
    final result = await _addRestaurant(restaurant);
    result.fold(
      (failure) => emit(
        RestaurantsError(message: failure.errorMessage),
      ),
      (success) => emit(const RestaurantAdded()),
    );
  }

  Future<void> submitRestaurant(RestaurantSubmit restaurantSubmit) async {
    emit(const SubmittingRestaurant());
    final result = await _submitRestaurant(restaurantSubmit);
    result.fold(
      (failure) => emit(
        RestaurantsError(message: failure.errorMessage),
      ),
      (success) => emit(const RestaurantSubmitted()),
    );
  }

  Future<void> updateRestaurant({
    required UpdateRestaurantInfoAction action,
    required Restaurant restaurant,
    dynamic restaurantData,
  }) async {
    emit(const UpdatingRestaurant());
    final result = await _updateRestaurant(
      UpdateRestaurantParams(
        action: action,
        restaurantData: restaurantData,
        restaurant: restaurant,
      ),
    );
    result.fold(
      (failure) => emit(
        RestaurantsError(message: failure.errorMessage),
      ),
      (r) => emit(const RestaurantUpdated()),
    );
  }

  Future<void> deleteRestaurantSubmission(
      RestaurantSubmit restaurantSubmit) async {
    emit(const DeletingRestaurantSubmit());
    final result = await _deleteRestaurantSubmission(restaurantSubmit);

    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (r) => emit(const RestaurantSubmitDeleted()),
    );
  }

  void getRestaurants(Position position, double radius) {
    emit(const LoadingRestaurants());
    StreamSubscription<Either<Failure, List<Restaurant>>>? subscription;

    subscription = _getRestaurantsNearMe(
      GetRestaurantsNearMeParams(position: position, radius: radius),
    ).listen(
      /*onData:*/
      (result) {
        result.fold(
          (failure) {
            debugPrint(failure.errorMessage);
            emit(RestaurantsError(message: failure.errorMessage));
            subscription?.cancel();
          },
          (restaurantsList) =>
              emit(RestaurantsLoaded(restaurants: restaurantsList)),
        );
      },
      onError: (dynamic error) {
        debugPrint(error.toString());
        emit(RestaurantsError(message: error.toString()));
      },
      onDone: () {
        subscription?.cancel();
      },
    );
  }

  Future<void> getRestaurantsMarkers(List<Restaurant> restaurants) async {
    emit(const LoadingMarkers());
    final result = await _getRestaurantsMarkers(
      GetRestaurantsMarkersParams(restaurants: restaurants),
    );
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (mapEntity) => emit(MarkersLoaded(markers: mapEntity.markers)),
    );
  }

  Future<void> loadGeoLocation() async {
    emit(const LoadingUserGeoLocation());
    final result = await _getUserLocation();
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (userLocation) => emit(
        UserLocationLoaded(position: userLocation.position),
      ),
    );
  }

  Future<void> addRestaurantReview(RestaurantReview restaurantReview) async {
    emit(const AddingRestaurantReview());
    final result = await _addRestaurantReview(restaurantReview);
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (r) => emit(const RestaurantReviewAdded()),
    );
  }

  Future<void> deleteReview(RestaurantReview review) async {
    emit(const DeletingRestaurantReview());
    final result = await _deleteRestaurantReview(review);
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (success) => emit(const RestaurantReviewDeleted()),
    );
  }

  Future<void> addReview(RestaurantReview review) async {
    emit(const AddingRestaurantReview());
    final result = await _addRestaurantReview(review);
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (success) => emit(const RestaurantReviewAdded()),
    );
  }

  Future<void> editReview(RestaurantReview review) async {
    emit(const EditingRestaurantReview());
    final result = await _editRestaurantReview(review);
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (success) => emit(const RestaurantReviewEdited()),
    );
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    emit(const SavingRestaurant());
    final result = await _saveRestaurant(restaurant.id);
    result.fold(
      (failure) => RestaurantsError(message: failure.message),
      (success) => emit(
        const RestaurantSaved(),
      ),
    );
  }

  Future<void> unSaveRestaurant({required Restaurant restaurant}) async {
    emit(const UnSavingRestaurant());
    final result = await _unSaveRestaurant(restaurant.id);
    result.fold(
      (failure) => RestaurantsError(message: failure.message),
      (success) => emit(
        const RestaurantUnSaved(),
      ),
    );
  }

  Future<void> getSavedRestaurants(List<String> savedRestaurantsIdsList) async {
    emit(const FetchingSavedRestaurantsList());
    final result = await _getSavedRestaurants(savedRestaurantsIdsList);

    result.fold(
      (failure) => emit(
        RestaurantsError(message: failure.errorMessage),
      ),
      (savedRestaurantsList) => emit(
        SavedRestaurantsListFetched(
          savedRestaurantsList: savedRestaurantsList,
        ),
      ),
    );
  }

  Future<void> editRestaurantReview(
      {required RestaurantReviewModel review}) async {
    emit(const EditingRestaurantReview());
    final result = await _editRestaurantReview(review);
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (success) => emit(const RestaurantReviewEdited()),
    );
  }
}
