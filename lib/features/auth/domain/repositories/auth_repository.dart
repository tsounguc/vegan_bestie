import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid forgotPassword({required String email});

  ResultFuture<UserEntity> createUserAccount({
    required String userName,
    required String veganStatus,
    required String email,
    required String password,
  });

  ResultFuture<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  ResultVoid updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  ResultVoid deleteAccount({required String password});

  ResultVoid deleteProfilePicture({required UserEntity? user});

  ResultVoid sendEmail({required String subject, required String body});

  ResultStream<UserEntity> getCurrentUser({required String userId});

  ResultFuture<UserEntity> currentUser();

// ResultFuture<UserEntity> signInWithGoogle();
//
// ResultFuture<UserEntity> signInWithFacebook();
//
// ResultVoid signOut();
//
// ResultFuture<UserEntity> currentUser();
}
