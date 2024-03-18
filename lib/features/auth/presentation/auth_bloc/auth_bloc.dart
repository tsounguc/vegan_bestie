import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/usecases/create_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/forgot_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInWithEmailAndPassword signInWithEmailAndPassword,
    required CreateUserAccount createUserAccount,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
  })  : _signInWithEmailAndPassword = signInWithEmailAndPassword,
        _createUserAccount = createUserAccount,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<SignInWithEmailAndPasswordEvent>(_signInWithEmailAndPasswordHandler);
    on<CreateUserAccountEvent>(_createUserAccountHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  final SignInWithEmailAndPassword _signInWithEmailAndPassword;
  final CreateUserAccount _createUserAccount;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;

  Future<void> _signInWithEmailAndPasswordHandler(
    SignInWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signInWithEmailAndPassword(
      SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _createUserAccountHandler(
    CreateUserAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _createUserAccount(
      CreateUserAccountParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
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
      (failure) => emit(AuthError(message: failure.errorMessage)),
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
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (success) => emit(const UserUpdated()),
    );
  }
}
