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

class UserLocationFailure extends Failure {
  const UserLocationFailure({
    required super.message,
    required super.statusCode,
  });

  UserLocationFailure.fromException(
    UserLocationException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class MapFailure extends Failure {
  const MapFailure({
    required super.message,
    required super.statusCode,
  });

  MapFailure.fromException(
    MapException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure({
    required super.message,
    required super.statusCode,
  });

  SignInWithEmailAndPasswordFailure.fromException(
    SignInWithEmailAndPasswordException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ForgotPasswordFailure extends Failure {
  const ForgotPasswordFailure({
    required super.message,
    required super.statusCode,
  });

  ForgotPasswordFailure.fromException(
    ForgotPasswordException exception,
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

  CreateWithEmailAndPasswordFailure.fromException(
    CreateWithEmailAndPasswordException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
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

class SearchProductFailure extends Failure {
  const SearchProductFailure({
    required super.message,
    required super.statusCode,
  });
}
