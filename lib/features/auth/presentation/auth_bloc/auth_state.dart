part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class SendingEmail extends AuthState {
  const SendingEmail();
}

class SignedIn extends AuthState {
  const SignedIn(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthState {
  const SignedUp(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class EmailSent extends AuthState {
  const EmailSent();
}

class AccountDeleted extends AuthState {
  const AccountDeleted();
}

class ProfilePicDeleted extends AuthState {
  const ProfilePicDeleted();
}

class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class CurrentUserDataLoaded extends AuthState {
  const CurrentUserDataLoaded({required this.currentUser});

  final UserEntity currentUser;

  @override
  List<Object> get props => [currentUser];
}
