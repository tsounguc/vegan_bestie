import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.statusCode,
    required this.message,
  }) : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage {
    final showErrorText = statusCode! is! String || int.tryParse(statusCode as String) != null;
    return '$statusCode ${showErrorText ? '' : 'Error'}'
        ': $message';
  }

  @override
  List<Object?> get props => [message, statusCode];
}

class FetchProductFailure extends Failure {
  FetchProductFailure({
    required super.message,
    required super.statusCode,
  });

  FetchProductFailure.fromException(FetchProductException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class AddFoodProductFailure extends Failure {
  AddFoodProductFailure({
    required super.message,
    required super.statusCode,
  });

  AddFoodProductFailure.fromException(AddFoodProductException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class UpdateFoodProductFailure extends Failure {
  UpdateFoodProductFailure({
    required super.message,
    required super.statusCode,
  });

  UpdateFoodProductFailure.fromException(UpdateFoodProductException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ScanFailure extends Failure {
  ScanFailure({
    required super.message,
    required super.statusCode,
  });

  ScanFailure.fromException(ScanException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class RestaurantsFailure extends Failure {
  RestaurantsFailure({
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
  RestaurantDetailsFailure({
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
  UserLocationFailure({
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
  MapFailure({
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
  SignInWithEmailAndPasswordFailure({
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
  ForgotPasswordFailure({
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
  CreateWithEmailAndPasswordFailure({
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

class DeleteAccountFailure extends Failure {
  DeleteAccountFailure({
    required super.message,
    required super.statusCode,
  });

  DeleteAccountFailure.fromException(
    DeleteAccountException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ReportIssueFailure extends Failure {
  ReportIssueFailure({
    required super.message,
    required super.statusCode,
  });

  ReportIssueFailure.fromException(
    ReportIssueException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class DeleteReportFailure extends Failure {
  DeleteReportFailure({
    required super.message,
    required super.statusCode,
  });

  DeleteReportFailure.fromException(
    DeleteReportException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class UpdateUserDataFailure extends Failure {
  UpdateUserDataFailure({
    required super.message,
    required super.statusCode,
  });

  UpdateUserDataFailure.fromException(
    UpdateUserDataException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class SaveFoodProductFailure extends Failure {
  SaveFoodProductFailure({
    required super.message,
    required super.statusCode,
  });

  SaveFoodProductFailure.fromException(
    SaveFoodProductException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class SaveRestaurantFailure extends Failure {
  SaveRestaurantFailure({
    required super.message,
    required super.statusCode,
  });

  SaveRestaurantFailure.fromException(
    SaveRestaurantException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class AddRestaurantReviewFailure extends Failure {
  AddRestaurantReviewFailure({
    required super.message,
    required super.statusCode,
  });

  AddRestaurantReviewFailure.fromException(
    AddRestaurantReviewException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class GetRestaurantReviewsFailure extends Failure {
  GetRestaurantReviewsFailure({
    required super.message,
    required super.statusCode,
  });

  GetRestaurantReviewsFailure.fromException(
    GetRestaurantReviewsException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class SignInWithGoogleFailure extends Failure {
  SignInWithGoogleFailure({
    required super.message,
    required super.statusCode,
  });
}

class SignInWithFacebookFailure extends Failure {
  SignInWithFacebookFailure({
    required super.message,
    required super.statusCode,
  });
}

class SignOutFailure extends Failure {
  SignOutFailure({
    required super.message,
    required super.statusCode,
  });
}

class CurrentUserFailure extends Failure {
  CurrentUserFailure({
    required super.message,
    required super.statusCode,
  });
}

class SearchProductFailure extends Failure {
  SearchProductFailure({
    required super.message,
    required super.statusCode,
  });
}

class DeleteRestaurantReviewFailure extends Failure {
  DeleteRestaurantReviewFailure({
    required super.message,
    required super.statusCode,
  });

  DeleteRestaurantReviewFailure.fromException(
    DeleteRestaurantReviewException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class EditRestaurantReviewFailure extends Failure {
  EditRestaurantReviewFailure({
    required super.message,
    required super.statusCode,
  });

  EditRestaurantReviewFailure.fromException(
    EditRestaurantReviewException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ReadIngredientsFromImageFailure extends Failure {
  ReadIngredientsFromImageFailure({
    required super.message,
    required super.statusCode,
  });

  ReadIngredientsFromImageFailure.fromException(
    ReadIngredientsFromImageException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
