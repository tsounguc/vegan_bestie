import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/map_entity.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/usecases/map_usecase.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapUseCase _mapUseCase = serviceLocator<MapUseCase>();
  GoogleMapController? controller;

  // Position? userCurrentLocation;

  MapCubit() : super(MapInitial());

  void displayRestaurants(List<RestaurantEntity> restaurants, Position userCurrentLocation) async {
    emit(MapLoadingState());
    final Either<MapFailure, MapEntity> mapRestaurantsResult =
        await _mapUseCase.getRestaurantsMarkers(restaurants, controller);
    mapRestaurantsResult.fold((mapFailure) => emit(MapErrorState(error: mapFailure.message)), (mapEntity) {
      emit(MapLocationsFound(
        userLocation: userCurrentLocation,
        markers: mapEntity.restaurantsMarkers!,
      ));
    });
  }
}
