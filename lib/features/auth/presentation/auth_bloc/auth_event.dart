part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInWithEmailAndPasswordEvent extends AuthEvent {
  const SignInWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class CreateUserAccountEvent extends AuthEvent {
  const CreateUserAccountEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object> get props => [email, password, fullName];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({
    required this.action,
    required this.userData,
  }) : assert(
          userData is String || userData is File,
          '[userData] must be either a String or a File, '
          'but was ${userData.runtimeType}',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
