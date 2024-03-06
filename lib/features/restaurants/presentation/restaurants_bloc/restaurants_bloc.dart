import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';

part 'restaurants_event.dart';

part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({
    required GetRestaurantsNearMe getRestaurantsNearMe,
    required GetRestaurantDetails getRestaurantDetails,
  })  : _getRestaurantsNearMe = getRestaurantsNearMe,
        _getRestaurantDetails = getRestaurantDetails,
        super(const RestaurantsInitial()) {
    on<GetRestaurantsEvent>(_getRestaurantsHandler);
    on<GetRestaurantDetailsEvent>(_getRestaurantDetailsHandler);
  }
  final GetRestaurantsNearMe _getRestaurantsNearMe;
  final GetRestaurantDetails _getRestaurantDetails;

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
}
