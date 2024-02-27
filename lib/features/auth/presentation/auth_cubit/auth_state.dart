part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  const AuthErrorState({required this.error});
  final String error;

  @override
  List<Object?> get props => [];
}

class CreateUserErrorState extends AuthState {
  const CreateUserErrorState({required this.error});
  final String error;

  @override
  List<Object?> get props => [];
}

class LoggedInState extends AuthState {
  const LoggedInState({required this.currentUser});
  final UserEntity? currentUser;

  @override
  List<Object?> get props => [];
}

class RegisterState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ContinueAsGuestState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SignedOutState extends AuthState {
  @override
  List<Object?> get props => [];
}
