import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories_contracts/auth_repository_contract.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../mappers/user_mapper.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  AuthRemoteDataSourceContract authRemoteDataSourceContract = serviceLocator<AuthRemoteDataSourceContract>();

  @override
  Future<Either<CreateWithEmailAndPasswordFailure, UserEntity>> createUserAccount(
      String userName, String email, String password) async {
    try {
      UserModel userModel = await authRemoteDataSourceContract.createUserAccount(userName, email, password);
      debugPrint("Repo Implementation User Model Name: ${userModel.name}");
      UserMapper mapper = UserMapper();
      UserEntity userEntity = mapper.mapToEntity(userModel);
      debugPrint("Repo Implementation User Entity Name: ${userModel.name}");
      return Right(userEntity);
    } on CreateWithEmailAndPasswordException catch (e) {
      return Left(CreateWithEmailAndPasswordFailure(message: e.message));
    }
  }

  @override
  Future<Either<SignInWithEmailAndPasswordFailure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserModel userModel = await authRemoteDataSourceContract.signInWithEmailAndPassword(email, password);
      debugPrint("Repo Implementation User Model Name: ${userModel.name}");
      UserMapper mapper = UserMapper();
      UserEntity userEntity = mapper.mapToEntity(userModel);
      debugPrint("Repo Implementation User Entity Name: ${userModel.name}");
      return Right(userEntity);
    } on SignInWithEmailAndPasswordException catch (e) {
      return Left(SignInWithEmailAndPasswordFailure(message: e.message));
    }
  }

  @override
  Future<Either<SignInWithGoogleFailure, UserEntity>> signInWithGoogle() async {
    try {
      UserModel userModel = await authRemoteDataSourceContract.signInWithGoogle();
      debugPrint("Repo Implementation User Model Name: ${userModel.name}");
      UserMapper mapper = UserMapper();
      UserEntity userEntity = mapper.mapToEntity(userModel);
      debugPrint("Repo Implementation User Entity Name: ${userModel.name}");
      return Right(userEntity);
    } on SignInWithGoogleException catch (e) {
      return Left(SignInWithGoogleFailure(message: e.message));
    }
  }

  @override
  Future<Either<SignInWithFacebookFailure, UserEntity>> signInWithFacebook() async {
    try {
      UserModel userModel = await authRemoteDataSourceContract.signInWithFacebook();
      debugPrint("Repo Implementation User Model Name: ${userModel.name}");
      UserMapper mapper = UserMapper();
      UserEntity userEntity = mapper.mapToEntity(userModel);
      debugPrint("Repo Implementation User Entity Name: ${userModel.name}");
      return Right(userEntity);
    } on SignInWithFacebookException catch (e) {
      return Left(SignInWithFacebookFailure(message: e.message));
    }
  }

  @override
  Future<Either<CurrentUserFailure, UserEntity>> currentUser() async {
    try {
      UserModel currentUserModel = await authRemoteDataSourceContract.currentUser();
      UserMapper mapper = UserMapper();
      UserEntity currentUserEntity = mapper.mapToEntity(currentUserModel);
      return Right(currentUserEntity);
    } on CurrentUserException catch (e) {
      return Left(CurrentUserFailure(message: e.message));
    }
  }

  @override
  Future<Either<SignOutFailure, void>> signOut() async {
    try {
      void signOutResult = await authRemoteDataSourceContract.signOut();
      return Right(signOutResult);
    } on SignOutException catch (e) {
      return Left(SignOutFailure(message: e.message));
    }
  }
}
