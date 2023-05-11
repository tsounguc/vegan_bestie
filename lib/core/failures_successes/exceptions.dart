class FetchProductException implements Exception {
  final String? message;

  const FetchProductException({this.message});
}

class ScanBarcodeException implements Exception {
  final String? message;

  const ScanBarcodeException({this.message});
}

class InvalidBarcodeException implements Exception {
  final String? message;

  const InvalidBarcodeException({this.message});
}

class CreateWithEmailAndPasswordException implements Exception {
  final String? message;

  const CreateWithEmailAndPasswordException({this.message});
}

class SignInWithEmailAndPasswordException implements Exception {
  final String? message;

  const SignInWithEmailAndPasswordException({this.message});
}

class SignInWithGoogleException implements Exception {
  final String? message;

  const SignInWithGoogleException({this.message});
}

class SignInWithFacebookException implements Exception {
  final String? message;

  const SignInWithFacebookException({this.message});
}

class SignOutException implements Exception {
  final String? message;

  const SignOutException({this.message});
}

class CurrentUserException implements Exception {
  final String? message;

  const CurrentUserException({this.message});
}

class FetchRestaurantsNearMeException implements Exception {
  final String? message;

  const FetchRestaurantsNearMeException({this.message});
}

class FetchRestaurantDetailsException implements Exception {
  final String? message;
  const FetchRestaurantDetailsException({this.message});
}

class LocationException implements Exception {
  final String? message;

  const LocationException({this.message});
}

class SearchProductException implements Exception {
  final String? message;

  const SearchProductException({this.message});
}

class MapException implements Exception {
  final String? message;

  const MapException({this.message});
}
