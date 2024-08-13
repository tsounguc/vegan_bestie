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

class SaveFoodProductEvent extends AuthEvent {
  const SaveFoodProductEvent({
    required this.barcode,
  });

  final String barcode;

  @override
  List<Object> get props => [barcode];
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

class GetCurrentUserEvent extends AuthEvent {
  const GetCurrentUserEvent({
    required this.userId,
  });

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class DeleteProfilePicEvent extends AuthEvent {
  const DeleteProfilePicEvent({this.user});

  final UserEntity? user;

  @override
  List<Object?> get props => [user];
}

class DeleteAccountEvent extends AuthEvent {
  const DeleteAccountEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class SendEmailEvent extends AuthEvent {
  const SendEmailEvent({required this.subject, required this.body});

  final String subject;
  final String body;

  @override
  List<Object> get props => [subject, body];
}
