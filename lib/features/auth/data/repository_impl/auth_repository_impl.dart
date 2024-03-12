import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sheveegan/features/auth/data/mappers/user_mapper.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories_contracts/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSourceContract authRemoteDataSourceContract = serviceLocator<AuthRemoteDataSourceContract>();

  @override
  Future<Either<CreateWithEmailAndPasswordFailure, UserEntity>> createUserAccount(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final userModel = await authRemoteDataSourceContract.createUserAccount(
        userName,
        email,
        password,
      );
      debugPrint('Repo Implementation User Model Name: ${userModel.name}');
      final mapper = UserMapper();
      final userEntity = mapper.mapToEntity(userModel);
      debugPrint('Repo Implementation User Entity Name: ${userModel.name}');
      return Right(userEntity);
    } on CreateWithEmailAndPasswordException catch (e) {
      return Left(
        CreateWithEmailAndPasswordFailure(message: e.message, statusCode: 500),
      );
    }
  }

  @override
  Future<Either<SignInWithEmailAndPasswordFailure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userModel = await authRemoteDataSourceContract.signInWithEmailAndPassword(
        email,
        password,
      );
      debugPrint('Repo Implementation User Model Name: ${userModel.name}');
      final mapper = UserMapper();
      final userEntity = mapper.mapToEntity(userModel);
      debugPrint('Repo Implementation User Entity Name: ${userModel.name}');
      return Right(userEntity);
    } on SignInWithEmailAndPasswordException catch (e) {
      return Left(
        SignInWithEmailAndPasswordFailure(message: e.message, statusCode: 500),
      );
    }
  }

  @override
  Future<Either<SignInWithGoogleFailure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await authRemoteDataSourceContract.signInWithGoogle();
      debugPrint('Repo Implementation User Model Name: ${userModel.name}');
      final mapper = UserMapper();
      final userEntity = mapper.mapToEntity(userModel);
      debugPrint('Repo Implementation User Entity Name: ${userModel.name}');
      return Right(userEntity);
    } on SignInWithGoogleException catch (e) {
      return Left(
        SignInWithGoogleFailure(message: e.message, statusCode: 500),
      );
    }
  }

  @override
  Future<Either<SignInWithFacebookFailure, UserEntity>> signInWithFacebook() async {
    try {
      final userModel = await authRemoteDataSourceContract.signInWithFacebook();
      debugPrint('Repo Implementation User Model Name: ${userModel.name}');
      final mapper = UserMapper();
      final userEntity = mapper.mapToEntity(userModel);
      debugPrint('Repo Implementation User Entity Name: ${userModel.name}');
      return Right(userEntity);
    } on SignInWithFacebookException catch (e) {
      return Left(
        SignInWithFacebookFailure(message: e.message, statusCode: 500),
      );
    }
  }

  @override
  Future<Either<CurrentUserFailure, UserEntity>> currentUser() async {
    try {
      final currentUserModel = await authRemoteDataSourceContract.currentUser();
      final mapper = UserMapper();
      final currentUserEntity = mapper.mapToEntity(currentUserModel);
      return Right(currentUserEntity);
    } on CurrentUserException catch (e) {
      return Left(CurrentUserFailure(message: e.message, statusCode: 500));
    }
  }

  @override
  Future<Either<SignOutFailure, void>> signOut() async {
    try {
      final signOutResult = await authRemoteDataSourceContract.signOut();
      return Right(signOutResult);
    } on SignOutException catch (e) {
      return Left(SignOutFailure(message: e.message, statusCode: 500));
    }
  }
}
