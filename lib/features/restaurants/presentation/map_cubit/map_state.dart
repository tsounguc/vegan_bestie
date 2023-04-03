part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();
}

class MapInitial extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoadingState extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLocationsFound extends MapState {
  final Position userLocation;
  final Set<Marker> markers;

  MapLocationsFound({required this.userLocation, required this.markers});

  @override
  List<Object?> get props => [];
}

class MapErrorState extends MapState {
  final error;

  MapErrorState({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
