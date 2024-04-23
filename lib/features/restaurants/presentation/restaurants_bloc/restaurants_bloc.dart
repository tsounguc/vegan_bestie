import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_restaurant.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/get_saved_restaurants_list.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({
    required GetUserLocation getUserLocation,
    required GetRestaurantsNearMe getRestaurantsNearMe,
    required GetRestaurantDetails getRestaurantDetails,
    required GetRestaurantsMarkers getRestaurantsMarkers,
    required GetSavedRestaurantsList getSavedRestaurantsList,
    required SaveRestaurant saveRestaurant,
    required RemoveRestaurant removeRestaurant,
  })  : _getUserLocation = getUserLocation,
        _getRestaurantsNearMe = getRestaurantsNearMe,
        _getRestaurantDetails = getRestaurantDetails,
        _getRestaurantsMarkers = getRestaurantsMarkers,
        _getSavedRestaurantsList = getSavedRestaurantsList,
        _saveRestaurant = saveRestaurant,
        _removeRestaurant = removeRestaurant,
        super(const RestaurantsInitial()) {
    on<LoadGeolocationEvent>(_geoLocationHandler);
    on<GetRestaurantsEvent>(_getRestaurantsHandler);
    on<GetRestaurantDetailsEvent>(_getRestaurantDetailsHandler);
    on<GetRestaurantsMarkersEvent>(_getRestaurantsMarkersHandler);
    on<FetchSavedRestaurantsListEvent>(_fetchRestaurantsListHandler);
    on<SaveRestaurantEvent>(_saveRestaurantHandler);
    on<RemoveRestaurantEvent>(_removeRestaurantHandler);
  }

  GoogleMapController? controller;
  Position? currentLocation;
  List<Restaurant>? restaurants;
  Set<Marker>? markers;

  final GetRestaurantsNearMe _getRestaurantsNearMe;
  final GetRestaurantDetails _getRestaurantDetails;
  final GetUserLocation _getUserLocation;
  final GetRestaurantsMarkers _getRestaurantsMarkers;
  final GetSavedRestaurantsList _getSavedRestaurantsList;
  final SaveRestaurant _saveRestaurant;
  final RemoveRestaurant _removeRestaurant;

  Future<void> _getRestaurantsHandler(
    GetRestaurantsEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const LoadingRestaurants());
    final result = await _getRestaurantsNearMe(
      GetRestaurantsNearMeParams(position: event.position),
    );

    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (restaurants) => emit(RestaurantsLoaded(restaurants: restaurants)),
    );
  }

  Future<void> _getRestaurantDetailsHandler(
    GetRestaurantDetailsEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const LoadingRestaurantDetails());
    final result = await _getRestaurantDetails(
      GetRestaurantDetailsParams(id: event.id),
    );
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (details) => emit(RestaurantDetailsLoaded(restaurantDetails: details)),
    );
  }

  Future<void> _geoLocationHandler(
    LoadGeolocationEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const LoadingUserGeoLocation());
    final result = await _getUserLocation();
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (userLocation) => emit(
        UserLocationLoaded(position: userLocation.position),
      ),
    );
  }

  Future<void> _getRestaurantsMarkersHandler(
    GetRestaurantsMarkersEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const LoadingMarkers());
    final result = await _getRestaurantsMarkers(
      GetRestaurantsMarkersParams(restaurants: event.restaurants),
    );
    result.fold(
      (failure) => emit(RestaurantsError(message: failure.errorMessage)),
      (mapEntity) => emit(MarkersLoaded(markers: mapEntity.markers)),
    );
  }

  Future<void> _fetchRestaurantsListHandler(
    FetchSavedRestaurantsListEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const FetchingSavedRestaurantsList());
    final result = await _getSavedRestaurantsList(
      event.savedRestaurantsIdsList,
    );

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

  Future<void> _saveRestaurantHandler(
    SaveRestaurantEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const SavingRestaurant());
    final result = await _saveRestaurant(event.restaurant.placeId);
    result.fold(
      (failure) => RestaurantsError(message: failure.message),
      (success) => emit(
        RestaurantDetailsLoaded(
          restaurantDetails: event.restaurant,
        ),
      ),
    );
  }

  Future<void> _removeRestaurantHandler(
    RemoveRestaurantEvent event,
    Emitter<RestaurantsState> emit,
  ) async {
    emit(const RemovingRestaurant());
    final result = await _removeRestaurant(event.restaurant.placeId);
    result.fold(
      (failure) => RestaurantsError(message: failure.message),
      (success) => emit(
        RestaurantDetailsLoaded(
          restaurantDetails: event.restaurant,
        ),
      ),
    );
  }
}
