import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.statusCode,
    required this.message,
  });

  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class FetchProductFailure extends Failure {
  const FetchProductFailure({
    required super.message,
    required super.statusCode,
  });

  FetchProductFailure.fromException(FetchProductException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ScanFailure extends Failure {
  const ScanFailure({
    required super.message,
    required super.statusCode,
  });

  ScanFailure.fromException(ScanException exception)
      : this(
          message: exception.message,
          statusCode: null,
        );
}

class RestaurantsFailure extends Failure {
  const RestaurantsFailure({
    required super.message,
    required super.statusCode,
  });

  RestaurantsFailure.fromException(RestaurantsException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class RestaurantDetailsFailure extends Failure {
  const RestaurantDetailsFailure({
    required super.message,
    required super.statusCode,
  });

  RestaurantDetailsFailure.fromException(
    RestaurantDetailsException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class CreateWithEmailAndPasswordFailure extends Failure {
  const CreateWithEmailAndPasswordFailure({
    required super.message,
    required super.statusCode,
  });
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure({
    required super.message,
    required super.statusCode,
  });
}

class SignInWithGoogleFailure extends Failure {
  const SignInWithGoogleFailure({
    required super.message,
    required super.statusCode,
  });
}

class SignInWithFacebookFailure extends Failure {
  const SignInWithFacebookFailure({
    required super.message,
    required super.statusCode,
  });
}

class SignOutFailure extends Failure {
  const SignOutFailure({
    required super.message,
    required super.statusCode,
  });
}

class CurrentUserFailure extends Failure {
  const CurrentUserFailure({
    required super.message,
    required super.statusCode,
  });
}

class LocationFailure extends Failure {
  const LocationFailure({
    required super.message,
    required super.statusCode,
  });
}

class SearchProductFailure extends Failure {
  const SearchProductFailure({
    required super.message,
    required super.statusCode,
  });
}

class MapFailure extends Failure {
  const MapFailure({
    required super.message,
    required super.statusCode,
  });
}
