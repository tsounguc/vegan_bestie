import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/auth_service.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSourceContract {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithFacebook();

  Future<UserModel> createUserAccount(
    String userName,
    String email,
    String password,
  );

  Future<UserModel> currentUser();

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final authServiceContract = serviceLocator<AuthServiceContract<User?, UserCredential>>();

  @override
  Future<UserModel> createUserAccount(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final userInfo = await authServiceContract.createWithEmailAndPassword(
        userName,
        email,
        password,
      );
      final user = UserModel(
          uid: userInfo.user?.uid as String,
          email: userInfo.user?.email as String,
          name: userInfo.user?.displayName as String,
          photoUrl: userInfo.user?.photoURL as String,
          bio: '');
      debugPrint('Auth Remote Data Source User Model Name: ${user.name}');
      return user;
    } on FirebaseAuthException catch (e) {
      throw CreateWithEmailAndPasswordException(message: e.message!);
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userInfo = await authServiceContract.signInWithEmailAndPassword(
        email,
        password,
      );
      final userBio = await getUserBio(userInfo.user?.uid as String);
      final user = UserModel(
        uid: userInfo.user?.uid as String,
        email: userInfo.user?.email as String,
        name: userInfo.user?.displayName as String,
        photoUrl: userInfo.user?.photoURL as String,
        bio: userBio,
      );
      debugPrint('User Model Name: ${user.name}');
      return user;
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordException(message: e.message!);
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final userInfo = await authServiceContract.signInWithGoogle();
      final userBio = await getUserBio(userInfo.user?.uid as String);
      final user = UserModel(
        uid: userInfo.user?.uid as String,
        email: userInfo.user?.email as String,
        name: userInfo.user?.displayName as String,
        photoUrl: userInfo.user?.photoURL as String,
        bio: userBio,
      );
      debugPrint('User Model Name: ${user.name}');
      return user;
    } on FirebaseAuthException catch (e) {
      throw SignInWithGoogleException(message: e.message!);
    } on PlatformException catch (e) {
      throw SignInWithGoogleException(message: e.message!);
    } catch (e) {
      debugPrint(e.toString());
      if (e.toString().contains(
            'At least one of ID token and access token is required',
          )) {
        throw SignInWithGoogleException(message: e.toString());
      }
      throw const SignInWithGoogleException(
        message: 'Failed to login with google',
      );
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final userInfo = await authServiceContract.signInWithFacebook();

      final userBio = await getUserBio(userInfo.user?.uid as String);

      final user = UserModel(
        uid: userInfo.user?.uid as String,
        email: userInfo.user?.email as String,
        name: userInfo.user?.displayName as String,
        photoUrl: userInfo.user?.photoURL as String,
        bio: userBio,
      );
      debugPrint('User Model Name: ${user.name}');
      return user;
    } on Exception catch (e) {
      throw SignInWithFacebookException(message: e.toString());
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      final currentUser = await authServiceContract.signInWithFacebook();

      final userBio = await getUserBio(currentUser.user?.uid as String);

      final currentUserModel = UserModel(
        uid: currentUser.user?.uid as String,
        email: currentUser.user?.email as String,
        name: currentUser.user?.displayName as String,
        photoUrl: currentUser.user?.photoURL as String,
        bio: userBio,
      );

      return currentUserModel;
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw CurrentUserException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authServiceContract.signOut();
    } on FirebaseException catch (e) {
      throw SignOutException(message: e.message!);
    }
  }

  Future<String?> getUserName(String? uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(
          'users',
        )
        .doc(uid)
        .get();
    var name = '';
    if (snapshot.exists) {
      name = snapshot['Name'].toString();
      debugPrint('Name: $name');
    }
    return name;
  }

  Future<String?> getUserBio(String? uid) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var bio = '';
    if (snapshot.exists) {
      bio = snapshot['bio'] as String;
      debugPrint('bio: $bio');
    }
    return bio;
  }
}
