import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/usecases/create_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/delete_account.dart';
import 'package:sheveegan/features/auth/domain/usecases/delete_profile_picture.dart';
import 'package:sheveegan/features/auth/domain/usecases/forgot_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/get_current_user.dart';
import 'package:sheveegan/features/auth/domain/usecases/send_email.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required SignInWithEmailAndPassword signInWithEmailAndPassword,
      required CreateUserAccount createUserAccount,
      required ForgotPassword forgotPassword,
      required UpdateUser updateUser,
      required DeleteProfilePicture deleteProfilePic,
      required SendEmail sendEmail,
      required DeleteAccount deleteAccount,
      required GetCurrentUser getCurrentUser})
      : _signInWithEmailAndPassword = signInWithEmailAndPassword,
        _createUserAccount = createUserAccount,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        _deleteProfilePic = deleteProfilePic,
        _sendEmail = sendEmail,
        _deleteAccount = deleteAccount,
        _getCurrentUser = getCurrentUser,
        super(const AuthInitial()) {
    on<SignInWithEmailAndPasswordEvent>(_signInWithEmailAndPasswordHandler);
    on<CreateUserAccountEvent>(_createUserAccountHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
    on<DeleteAccountEvent>(_deleteAccountHandler);
    on<SendEmailEvent>(_sendEmailHandler);
    on<DeleteProfilePicEvent>(_deleteProfilePicHandler);
    on<GetCurrentUserEvent>(_getCurrentUserHandler);
  }

  final SignInWithEmailAndPassword _signInWithEmailAndPassword;
  final CreateUserAccount _createUserAccount;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;
  final DeleteAccount _deleteAccount;
  final DeleteProfilePicture _deleteProfilePic;
  final SendEmail _sendEmail;
  final GetCurrentUser _getCurrentUser;

  Future<void> _signInWithEmailAndPasswordHandler(
    SignInWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signInWithEmailAndPassword(
      SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _createUserAccountHandler(
    CreateUserAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    debugPrint('AuthBloc vegan status : ${event.veganStatus}');
    final result = await _createUserAccount(
      CreateUserAccountParams(
        email: event.email,
        veganStatus: event.veganStatus,
        password: event.password,
        fullName: event.fullName,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(SignedUp(user)),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _forgotPassword(event.email);

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) => emit(const ForgotPasswordSent()),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _updateUser(
      UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) => emit(const UserUpdated()),
    );
  }

  // void _getCurrentUserHandler(GetCurrentUserEvent event, Emitter<AuthState> emit) {
  //   emit(const AuthLoading());
  //   StreamSubscription<Either<Failure, UserEntity>>? subscription;
  //   subscription = _getCurrentUser(event.userId).listen(
  //     (result) {
  //       result.fold(
  //         (failure) {
  //           debugPrint(failure.errorMessage);
  //           emit(AuthError(message: failure.message));
  //           subscription?.cancel();
  //         },
  //         (user) => emit(CurrentUserDataLoaded(currentUser: user)),
  //       );
  //     },
  //     onError: (dynamic error) {
  //       debugPrint(error.toString());
  //       emit(AuthError(message: error.toString()));
  //     },
  //     onDone: () {
  //       subscription?.cancel();
  //     },
  //   );
  // }

  Future<void> _sendEmailHandler(
    SendEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const SendingEmail());
    final result = await _sendEmail(
      SendEmailParams(
        subject: event.subject,
        body: event.body,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) {
        return emit(const EmailSent());
      },
    );
  }

  Future<void> _deleteProfilePicHandler(
    DeleteProfilePicEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _deleteProfilePic(event.user);

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) {
        return emit(const ProfilePicDeleted());
      },
    );
  }

  Future<void> _deleteAccountHandler(
    DeleteAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _deleteAccount(event.password);

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (success) {
        return emit(const AccountDeleted());
      },
    );
  }

  FutureOr<void> _getCurrentUserHandler(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _getCurrentUser();
    result.fold(
      (failure) => emit(
        AuthError(message: failure.message),
      ),
      (user) => emit(
        CurrentUserDataLoaded(currentUser: user),
      ),
    );
  }
}
