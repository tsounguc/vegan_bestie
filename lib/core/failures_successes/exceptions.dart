class FetchProductException implements Exception {
  final String? message;
  const FetchProductException({this.message});
}

class ScanBarcodeException implements Exception {
  final String? message;
  const ScanBarcodeException({this.message});
}

class CreateWithEmailAndPasswordException implements Exception {
  final String? message;
  const CreateWithEmailAndPasswordException({this.message});
}

class SignInWithEmailAndPasswordException implements Exception {
  final String? message;
  const SignInWithEmailAndPasswordException({this.message});
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

class LocationException implements Exception {
  final String? message;
  const LocationException({this.message});
}

class SearchProductException implements Exception {
  final String? message;
  const SearchProductException({this.message});
}
