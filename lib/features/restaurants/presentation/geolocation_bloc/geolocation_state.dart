part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();
}

class GeolocationInitialState extends GeolocationState {
  @override
  List<Object> get props => [];
}

class GeolocationLoadingState extends GeolocationState {
  @override
  List<Object> get props => [];
}

class GeolocationLoadedState extends GeolocationState {
  final Position position;

  GeolocationLoadedState({required this.position});

  @override
  List<Object> get props => [position];
}

class GeolocationErrorState extends GeolocationState {
  final error;

  GeolocationErrorState({this.error});

  @override
  List<Object> get props => [];
}
