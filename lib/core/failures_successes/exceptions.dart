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
