part of 'user_location_cubit.dart';

abstract class UserLocationState extends Equatable {
  const UserLocationState();

  @override
  List<Object> get props => [];
}

class UserLocationInitial extends UserLocationState {}

class LoadingUserGeoLocation extends UserLocationState {
  const LoadingUserGeoLocation();
}

class UserLocationLoaded extends UserLocationState {
  const UserLocationLoaded({required this.position});

  final Position position;

  @override
  List<Object> get props => [position];
}

class UserLocationError extends UserLocationState {
  const UserLocationError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
