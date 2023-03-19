part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();
}

class LoadGeolocationEvent extends GeolocationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateGeolocationEvent extends GeolocationEvent {
  final Position position;
  UpdateGeolocationEvent({required this.position});
  @override
  List<Object?> get props => [position];
}
