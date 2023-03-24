abstract class Failure {
  final String? message;
  const Failure({this.message});
}

class FetchProductFailure extends Failure {
  const FetchProductFailure({String? message}) : super(message: message);
}

class ScanningFailure extends Failure {
  const ScanningFailure({String? message}) : super(message: message);
}

class CreateWithEmailAndPasswordFailure extends Failure {
  const CreateWithEmailAndPasswordFailure({String? message}) : super(message: message);
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure({String? message}) : super(message: message);
}

class SignInWithGoogleFailure extends Failure {
  const SignInWithGoogleFailure({String? message}) : super(message: message);
}

class SignInWithFacebookFailure extends Failure{
  const SignInWithFacebookFailure({String? message}) : super(message: message);
}

class SignOutFailure extends Failure {
  SignOutFailure({String? message}) : super(message: message);
}

class CurrentUserFailure extends Failure {
  const CurrentUserFailure({String? message}) : super(message: message);
}

class FetchRestaurantsNearMeFailure extends Failure {
  const FetchRestaurantsNearMeFailure({String? message}) : super(message: message);
}

class LocationFailure extends Failure {
  const LocationFailure({String? message}) : super(message: message);
}

class SearchProductFailure extends Failure {
  const SearchProductFailure({String? message}) : super(message: message);
}


