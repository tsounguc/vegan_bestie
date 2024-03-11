import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid forgotPassword({required String email});

  ResultFuture<UserEntity> createUserAccount({
    required String userName,
    required String email,
    required String password,
  });

  ResultFuture<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  ResultFuture<UserEntity> signInWithGoogle();

  ResultFuture<UserEntity> signInWithFacebook();

  ResultVoid signOut();

  ResultFuture<UserEntity> currentUser();
}
