import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({
    required GetRestaurantsMarkers getRestaurantsMarkers,
  })  : _getRestaurantsMarkers = getRestaurantsMarkers,
        super(MapInitial());

  final GetRestaurantsMarkers _getRestaurantsMarkers;

  Future<void> getRestaurantsMarkers(
    List<Restaurant> restaurants,
  ) async {
    emit(const LoadingMarkers());
    final result = await _getRestaurantsMarkers(
      GetRestaurantsMarkersParams(restaurants: restaurants),
    );
    result.fold(
      (failure) => emit(MapError(message: failure.errorMessage)),
      (mapEntity) => emit(MarkersLoaded(markers: mapEntity.markers)),
    );
  }
}
