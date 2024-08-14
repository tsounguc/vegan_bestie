import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultVoid forgotPassword({required String email}) async {
    try {
      await _remoteDataSource.forgotPassword(email: email);
      return const Right(null);
    } on ForgotPasswordException catch (e) {
      return Left(ForgotPasswordFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on SignInWithEmailAndPasswordException catch (e) {
      return Left(
        SignInWithEmailAndPasswordFailure(
          message: e.message,
          statusCode: '500',
        ),
      );
    }
  }

  @override
  ResultFuture<UserEntity> createUserAccount({
    required String userName,
    required String veganStatus,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.createUserAccount(
        fullName: userName,
        veganStatus: veganStatus,
        email: email,
        password: password,
      );
      return Right(result);
    } on CreateWithEmailAndPasswordException catch (e) {
      return Left(
        CreateWithEmailAndPasswordFailure(
          message: e.message,
          statusCode: '500',
        ),
      );
    }
  }

  @override
  ResultVoid updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on UpdateUserDataException catch (e) {
      return Left(UpdateUserDataFailure.fromException(e));
    }
  }

  @override
  ResultVoid sendEmail({required String subject, required String body}) async {
    try {
      await _remoteDataSource.sendEmail(subject: subject, body: body);
      return const Right(null);
    } on SendEmailException catch (e) {
      return Left(SendEmailFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteProfilePicture({required UserEntity? user}) async {
    try {
      await _remoteDataSource.deleteProfilePicture(user: user);
      return const Right(null);
    } on DeleteProfilePictureException catch (e) {
      return Left(DeleteProfilePictureFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteAccount({required String password}) async {
    try {
      await _remoteDataSource.deleteAccount(password: password);
      return const Right(null);
    } on DeleteAccountException catch (e) {
      return Left(DeleteAccountFailure.fromException(e));
    }
  }

  @override
  ResultStream<UserEntity> getCurrentUser({required String userId}) {
    return _remoteDataSource.getCurrentUser(userId: userId).transform(
          StreamTransformer<UserModel, Either<Failure, UserEntity>>.fromHandlers(
            handleData: (user, sink) {
              sink.add(Right(user));
            },
            handleError: (error, stackTrace, sink) {
              debugPrintStack(stackTrace: stackTrace);
              if (error is ServerException) {
                sink.add(Left(ServerFailure.fromException(error)));
              } else {
                sink.add(Left(ServerFailure(message: error.toString(), statusCode: 505)));
              }
            },
          ),
        );
  }

// @override
// ResultFuture<UserEntity> signInWithGoogle() async {
//   try {
//     final userModel = await _remoteDataSource.signInWithGoogle();
//     debugPrint('Repo Implementation User Model Name: ${userModel.name}');
//     final mapper = UserMapper();
//     final userEntity = mapper.mapToEntity(userModel);
//     debugPrint('Repo Implementation User Entity Name: ${userModel.name}');
//     return Right(userEntity);
//   } on SignInWithGoogleException catch (e) {
//     return Left(
//       SignInWithGoogleFailure(message: e.message, statusCode: 500),
//     );
//   }
// }
//
// @override
// ResultFuture<UserEntity> signInWithFacebook() async {
//   try {
//     final userModel = await _remoteDataSource.signInWithFacebook();
//     debugPrint('Repo Implementation User Model Name: ${userModel.name}');
//     final mapper = UserMapper();
//     final userEntity = mapper.mapToEntity(userModel);
//     debugPrint('Repo Implementation User Entity Name: ${userModel.name}');
//     return Right(userEntity);
//   } on SignInWithFacebookException catch (e) {
//     return Left(
//       SignInWithFacebookFailure(message: e.message, statusCode: 500),
//     );
//   }
// }
//
// @override
// ResultFuture<UserEntity> currentUser() async {
//   try {
//     final currentUserModel = await _remoteDataSource.currentUser();
//     final mapper = UserMapper();
//     final currentUserEntity = mapper.mapToEntity(currentUserModel);
//     return Right(currentUserEntity);
//   } on CurrentUserException catch (e) {
//     return Left(CurrentUserFailure(message: e.message, statusCode: 500));
//   }
// }
//
// @override
// ResultVoid signOut() async {
//   try {
//     final signOutResult = await _remoteDataSource.signOut();
//     return Right(signOutResult);
//   } on SignOutException catch (e) {
//     return Left(SignOutFailure(message: e.message, statusCode: 500));
//   }
// }
}
