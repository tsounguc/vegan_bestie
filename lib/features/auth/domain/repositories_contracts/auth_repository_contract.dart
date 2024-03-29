import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepositoryContract {
  Future<Either<CreateWithEmailAndPasswordFailure, UserEntity>> createUserAccount(
      String userName, String email, String password);

  Future<Either<SignInWithEmailAndPasswordFailure, UserEntity>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<SignInWithGoogleFailure, UserEntity>> signInWithGoogle();

  Future<Either<SignInWithFacebookFailure, UserEntity>> signInWithFacebook();

  Future<Either<SignOutFailure, void>> signOut();

  Future<Either<CurrentUserFailure, UserEntity>> currentUser();
}
