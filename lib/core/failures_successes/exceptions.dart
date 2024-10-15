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
  const ScanException({
    required this.message,
    this.statusCode = 500,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message];
}

class RestaurantsException extends Equatable implements Exception {
  const RestaurantsException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class RestaurantDetailsException extends Equatable implements Exception {
  const RestaurantDetailsException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UserLocationException extends Equatable implements Exception {
  const UserLocationException({
    required this.message,
    this.statusCode = 500,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message];
}

class MapException extends Equatable implements Exception {
  const MapException({
    required this.message,
    this.statusCode = 500,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ForgotPasswordException extends Equatable implements Exception {
  const ForgotPasswordException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class SignInWithEmailAndPasswordException extends Equatable implements Exception {
  const SignInWithEmailAndPasswordException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CreateWithEmailAndPasswordException extends Equatable implements Exception {
  const CreateWithEmailAndPasswordException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class DeleteAccountException extends Equatable implements Exception {
  const DeleteAccountException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class DeleteProfilePictureException extends Equatable implements Exception {
  const DeleteProfilePictureException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class SendEmailException extends Equatable implements Exception {
  const SendEmailException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UpdateUserDataException extends Equatable implements Exception {
  const UpdateUserDataException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ReportIssueException extends Equatable implements Exception {
  const ReportIssueException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class SaveFoodProductException extends Equatable implements Exception {
  const SaveFoodProductException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class SaveRestaurantException extends Equatable implements Exception {
  const SaveRestaurantException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class AddRestaurantReviewException extends Equatable implements Exception {
  const AddRestaurantReviewException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class DeleteReportException extends Equatable implements Exception {
  const DeleteReportException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class GetRestaurantReviewsException extends Equatable implements Exception {
  const GetRestaurantReviewsException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class DeleteRestaurantReviewException extends Equatable implements Exception {
  const DeleteRestaurantReviewException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class EditRestaurantReviewException extends Equatable implements Exception {
  const EditRestaurantReviewException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ReadIngredientsFromImageException extends Equatable implements Exception {
  const ReadIngredientsFromImageException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class AddFoodProductException extends Equatable implements Exception {
  const AddFoodProductException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UpdateFoodProductException extends Equatable implements Exception {
  const UpdateFoodProductException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class SignInWithGoogleException extends Equatable implements Exception {
  const SignInWithGoogleException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SignInWithFacebookException extends Equatable implements Exception {
  const SignInWithFacebookException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SignOutException extends Equatable implements Exception {
  const SignOutException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class CurrentUserException extends Equatable implements Exception {
  const CurrentUserException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SearchProductException extends Equatable implements Exception {
  const SearchProductException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class UpdateSuggestionException extends Equatable implements Exception {
  const UpdateSuggestionException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
