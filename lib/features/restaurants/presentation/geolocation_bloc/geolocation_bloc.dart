import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../data/repositoryLayer/repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final Repository repository;
  Position? _position;
  StreamSubscription? _geolocationSubscription;

  GeolocationBloc({required this.repository}) : super(GeolocationLoadingState()) {
    on<LoadGeolocationEvent>((event, emit) async {
      try {
        emit(GeolocationLoadingState());
        _position = await repository.getCurrentLocation();
        // debugPrint("Latitude: ${_position!.latitude} Longitude: ${_position!.longitude}");
        if (_position != null) {
          emit(GeolocationLoadedState(position: _position!));
        }
      } on Error catch (e) {
        print("Geolocation: $e");
        throw Exception(e.stackTrace);
      } catch (e) {}
    });
    on<UpdateGeolocationEvent>((event, emit) async {
      emit(GeolocationLoadingState());
      _geolocationSubscription?.cancel();
      _position = await repository.getCurrentLocation();
      emit(GeolocationLoadedState(position: _position!));
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
