part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();
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
  @override
  List<Object> get props => [];
}
