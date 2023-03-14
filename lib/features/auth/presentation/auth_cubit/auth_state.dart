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
  final error;
  AuthErrorState({required this.error});
  @override
  List<Object?> get props => [];
}

class LoggedInState extends AuthState {
  final UserEntity currentUser;
  LoggedInState({required this.currentUser});
  @override
  List<Object?> get props => [];
}

class SignedOutState extends AuthState {
  @override
  List<Object?> get props => [];
}
