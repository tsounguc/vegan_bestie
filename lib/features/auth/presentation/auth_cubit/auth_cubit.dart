import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_with_email_and_password_usecases.dart';
import '../../domain/usecases/current_user_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateUserAccountUseCase _createUserAccountUseCase = serviceLocator<CreateUserAccountUseCase>();
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase =
      serviceLocator<SignInWithEmailAndPasswordUseCase>();
  final SignOutUseCase _signOutUseCase = serviceLocator<SignOutUseCase>();
  final CurrentUserUseCase _currentUserUseCase = serviceLocator<CurrentUserUseCase>();
  AuthCubit() : super(AuthInitialState());
  void createUserAccount(String userName, String email, String password) async {
    emit(AuthLoadingState());
    Either<CreateWithEmailAndPasswordFailure, UserEntity> registrationResult =
        await _createUserAccountUseCase.createUserAccount(userName, email, password);
    registrationResult.fold(
      (registrationFailure) => emit(AuthErrorState(error: registrationFailure.message)),
      (userEntity) {
        debugPrint("Name in cubit: ${userEntity.name}");
        emit(LoggedInState(currentUser: userEntity));
      },
    );
  }

  void signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoadingState());
    Either<SignInWithEmailAndPasswordFailure, UserEntity> signInResult =
        await _signInWithEmailAndPasswordUseCase.signInWithEmailAndPassword(email, password);
    signInResult.fold(
      (signInFailure) => emit(AuthErrorState(error: signInFailure.message)),
      (userEntity) {
        debugPrint("Sign In Name in cubit: ${userEntity.name}");
        emit(LoggedInState(currentUser: userEntity));
      },
    );
  }

  void currentUser() async {
    emit(AuthLoadingState());
    Either<CurrentUserFailure, UserEntity> userLoginStatus = await _currentUserUseCase.currentUser();
    userLoginStatus.fold(
      (notSignedIn) => emit(SignedOutState()),
      (currentUser) => emit(LoggedInState(currentUser: currentUser)),
    );
  }

  setStateToInitial() {
    emit(AuthInitialState());
  }

  goToLoginPage() {
    emit(SignedOutState());
  }

  goToRegister() {
    emit(RegisterState());
  }

  void signOut() async {
    emit(AuthLoadingState());
    Either<SignOutFailure, void> signOutResult = await _signOutUseCase.signOut();
    signOutResult.fold(
      (signOutFailure) => emit(AuthErrorState(error: signOutFailure.message)),
      (signOutSuccess) => emit(SignedOutState()),
    );
  }
}
