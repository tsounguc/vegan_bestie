import 'package:equatable/equatable.dart';

class FetchProductException extends Equatable implements Exception {
  const FetchProductException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ScanException extends Equatable implements Exception {
  const ScanException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class CreateWithEmailAndPasswordException extends Equatable implements Exception {
  const CreateWithEmailAndPasswordException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class SignInWithEmailAndPasswordException extends Equatable implements Exception {
  const SignInWithEmailAndPasswordException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class SignInWithGoogleException extends Equatable implements Exception {
  const SignInWithGoogleException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class SignInWithFacebookException extends Equatable implements Exception {
  const SignInWithFacebookException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class SignOutException extends Equatable implements Exception {
  const SignOutException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class CurrentUserException extends Equatable implements Exception {
  const CurrentUserException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class FetchRestaurantsNearMeException extends Equatable implements Exception {
  const FetchRestaurantsNearMeException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class FetchRestaurantDetailsException extends Equatable implements Exception {
  const FetchRestaurantDetailsException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class LocationException extends Equatable implements Exception {
  const LocationException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class SearchProductException extends Equatable implements Exception {
  const SearchProductException({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class MapException extends Equatable implements Exception {
  const MapException({this.message});

  final String? message;

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
