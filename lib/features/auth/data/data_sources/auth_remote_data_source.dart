import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgotPassword({required String email});

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> createUserAccount({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

// Future<UserModel> signInWithGoogle();
//
// Future<UserModel> signInWithFacebook();
//
//
//
// Future<UserModel> currentUser();
//
// Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ForgotPasswordException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ForgotPasswordException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<UserModel> createUserAccount({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullName);
      await userCredential.user?.updatePhotoURL(kDefaultAvatar);

      //
      await _setUserData(
        _authClient.currentUser!,
        email,
      );
      final user = UserModel(
        uid: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
        name: userCredential.user?.displayName ?? '',
        photoUrl: userCredential.user!.photoURL,
        bio: '',
      );

      debugPrint('Auth Remote Data Source User Model Name: ${user.name}');
      return user;
    } on FirebaseAuthException catch (e) {
      throw CreateWithEmailAndPasswordException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on CreateWithEmailAndPasswordException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CreateWithEmailAndPasswordException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // sign in and store result
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;
      if (user == null) {
        throw const SignInWithEmailAndPasswordException(
          message: 'Please try again later',
          statusCode: 'Unknown Error',
        );
      }

      // get user data from firestore with user uid
      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return UserModel.fromMap(userData.data()!);
      }

      // if user doesn't have data in firestore
      // upload data to firestore
      await _setUserData(user, email);
      // get user data from firestore with user uid
      userData = await _getUserData(user.uid);

      return UserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on SignInWithEmailAndPasswordException {
      rethrow;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw SignInWithEmailAndPasswordException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          await _authClient.currentUser?.verifyBeforeUpdateEmail(
            userData as String,
          );
          await _updateUserData({'email': userData});
        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(
            userData as String,
          );
          await _updateUserData({'fullName': userData});
        case UpdateUserAction.photoUrl:
          // Save new picture in firebase storage
          final ref = _dbClient.ref().child('profile_pics/${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);

          // Save get url from firebase storage
          final url = await ref.getDownloadURL();

          // Update it in firebase auth
          await _authClient.currentUser?.updatePhotoURL(url);

          // Update document url in firestore
          await _updateUserData({'photoUrl': url});
        case UpdateUserAction.password:
          // this case is when is already logged in
          // and is trying to change password in user settings
          final newData = jsonDecode(userData as String) as DataMap;
          if (_authClient.currentUser?.email == null) {
            throw const UpdateUserDataException(
              message: 'User does not exist',
              statusCode: 'Insufficient Permission',
            );
          }
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );

          await _authClient.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});
      }
    } on FirebaseException catch (e) {
      throw UpdateUserDataException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UpdateUserDataException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _users.doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _users.doc(user.uid).set(
          UserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            name: user.displayName ?? '',
            photoUrl: user.photoURL ?? '',
            bio: '',
            savedProductsBarcodes: const [],
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _users
        .doc(
          _authClient.currentUser?.uid,
        )
        .update(data);
  }

  CollectionReference<Map<String, dynamic>> get _users => _cloudStoreClient.collection(
        FirebaseConstants.usersCollection,
      );
}
