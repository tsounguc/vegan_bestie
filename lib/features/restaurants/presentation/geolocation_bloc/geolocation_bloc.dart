import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/domain/entities/location_entity.dart';

import '../../domain/usecases/get_user_location.dart';

part 'geolocation_event.dart';

part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GetUserLocation _currentLocationUseCase = serviceLocator<GetUserLocation>();
  final GetLastLocationUseCase _lastLocationUseCase = serviceLocator<GetLastLocationUseCase>();
  StreamSubscription? _geolocationSubscription;
  Position? currentLocation;

  GeolocationBloc() : super(GeolocationInitialState()) {
    on<LoadGeolocationEvent>((event, emit) async {
      emit(GeolocationLoadingState());

      final Either<LocationFailure, LocationEntity> currentLocationResult =
          await _currentLocationUseCase.getCurrentLocation();
      currentLocationResult.fold(
        (locationFailure) => emit(GeolocationErrorState(error: locationFailure.message)),
        (currentLocationEntity) => emit(GeolocationLoadedState(position: currentLocationEntity.position!)),
      );
    });

    on<UpdateGeolocationEvent>((event, emit) async {
      emit(GeolocationLoadingState());
      _geolocationSubscription?.cancel();
      final Either<LocationFailure, LocationEntity> locationResult =
          await _currentLocationUseCase.getCurrentLocation();
      locationResult.fold(
        (locationFailure) => emit(GeolocationErrorState(error: locationFailure.message)),
        (locationEntity) => emit(GeolocationLoadedState(position: locationEntity.position!)),
      );
    });
    on<TappedRestaurantTabEvent>((event, emit) async {
      emit(GeolocationInitialState());
      final Either<LocationFailure, LocationEntity> locationResult =
          await _currentLocationUseCase.getCurrentLocation();
      locationResult.fold(
        (locationFailure) => emit(GeolocationErrorState(error: locationFailure.message)),
        (locationEntity) {
          // _currentLocation = locationEntity.position;
          emit(GeolocationLoadedState(position: locationEntity.position!));
        },
      );
      debugPrint("TappedRestaurantTabEvent");
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
