import 'package:dartz/dartz.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepositoryContract {
  ResultFuture<UserEntity> createUserAccount({
    String userName,
    String email,
    String password,
  });

  Future<Either<SignInWithEmailAndPasswordFailure, UserEntity>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<SignInWithGoogleFailure, UserEntity>> signInWithGoogle();

  Future<Either<SignInWithFacebookFailure, UserEntity>> signInWithFacebook();

  Future<Either<SignOutFailure, void>> signOut();

  Future<Either<CurrentUserFailure, UserEntity>> currentUser();
}
