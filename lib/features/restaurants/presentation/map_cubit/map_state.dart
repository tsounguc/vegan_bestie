part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class LoadingMarkers extends MapState {
  const LoadingMarkers();
}

class MarkersLoaded extends MapState {
  const MarkersLoaded({required this.markers});

  final Set<Marker> markers;

  @override
  List<Object> get props => [markers];
}

class MapError extends MapState {
  const MapError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
