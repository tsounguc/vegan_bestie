import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/auth_service.dart';

abstract class AuthRemoteDataSourceContract {
  Future signInWithEmailAndPassword(String email, String password);

  Future createUserAccount(String userName, String email, String password);

  Future currentUser();

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthServiceContract authServiceContract = serviceLocator<AuthServiceContract>();
  @override
  Future<UserModel> createUserAccount(String userName, String email, String password) async {
    try {
      UserCredential userInfo = await authServiceContract.createWithEmailAndPassword(userName, email, password);
      UserModel user = UserModel(
        uid: userInfo.user?.uid,
        email: userInfo.user?.email,
        name: userInfo.user?.displayName,
        photoUrl: userInfo.user?.photoURL,
      );
      debugPrint("Auth Remote Data Source User Model Name: ${user.name}");
      return user;
    } on FirebaseAuthException catch (e) {
      throw CreateWithEmailAndPasswordException(message: e.message);
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userInfo = await authServiceContract.signInWithEmailAndPassword(email, password);
      String? name = await getUserName(userInfo.user?.uid);
      UserModel user = UserModel(
        uid: userInfo.user?.uid,
        email: userInfo.user?.email,
        name: userInfo.user?.displayName,
        photoUrl: userInfo.user?.photoURL,
      );
      debugPrint("User Model Name: ${user.name}");
      return user;
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordException(message: e.message);
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      User? currentUser = await authServiceContract.currentUser();
      String? name = await getUserName(currentUser?.uid);
      UserModel currentUserModel = UserModel(
        uid: currentUser?.uid,
        name: currentUser?.displayName,
        email: currentUser?.email,
        photoUrl: currentUser?.photoURL,
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
      throw SignOutException(message: e.message);
    }
  }

  Future<String?> getUserName(String? uid) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    String name = "";
    if (snapshot.exists) {
      name = snapshot['Name'].toString();
      debugPrint("Name: $name");
    }
    return name;
  }
}
