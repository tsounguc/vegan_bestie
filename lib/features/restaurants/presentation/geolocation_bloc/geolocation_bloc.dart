import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/features/restaurants/domain/entities/location_entity.dart';

import '../../../../data/repositoryLayer/repository.dart';
import '../../domain/usecases/get_current_location_usecase.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  // final Repository repository;
  final GetCurrentLocationUseCase _geolocationUseCase = serviceLocator<GetCurrentLocationUseCase>();
  Position? _position;
  StreamSubscription? _geolocationSubscription;

  GeolocationBloc() : super(GeolocationLoadingState()) {
    on<LoadGeolocationEvent>((event, emit) async {
      emit(GeolocationLoadingState());
      final Either<LocationFailure, LocationEntity> locationResult =
          await _geolocationUseCase.getCurrentLocation();
      locationResult.fold(
        (locationFailure) => emit(GeolocationErrorState(error: locationFailure.message)),
        (locationEntity) => emit(GeolocationLoadedState(position: locationEntity.position!)),
      );
    });

    on<UpdateGeolocationEvent>((event, emit) async {
      emit(GeolocationLoadingState());
      _geolocationSubscription?.cancel();
      final Either<LocationFailure, LocationEntity> locationResult =
          await _geolocationUseCase.getCurrentLocation();
      locationResult.fold(
        (locationFailure) => emit(GeolocationErrorState(error: locationFailure.message)),
        (locationEntity) => emit(GeolocationLoadedState(position: locationEntity.position!)),
      );
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
