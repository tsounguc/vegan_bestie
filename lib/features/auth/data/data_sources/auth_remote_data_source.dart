import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/auth_service.dart';

abstract class AuthRemoteDataSourceContract {
  Future signInWithEmailAndPassword(String email, String password);

  Future createUserAccount(String userName, String email, String password);

  currentUser();

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
        name: userInfo.user?.displayName ?? userName,
        photoUrl: userInfo.user?.photoURL,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw CreateWithEmailAndPasswordException(message: e.message);
    }
  }

  @override
  UserModel currentUser() {
    User? currentUser = authServiceContract.currentUser();
    UserModel currentUserModel = UserModel(
      uid: currentUser?.uid,
      name: currentUser?.displayName,
      email: currentUser?.email,
      photoUrl: currentUser?.photoURL,
    );
    return currentUserModel;
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userInfo = await authServiceContract.signInWithEmailAndPassword(email, password);
      final snapshot = await FirebaseFirestore.instance.collection('users').doc(userInfo.user?.uid).get();
      String name = "";
      if (snapshot.exists) {
        name = snapshot['Name'];
      }
      UserModel user = UserModel(
        uid: userInfo.user?.uid,
        email: userInfo.user?.email,
        name: userInfo.user?.displayName ?? name,
        photoUrl: userInfo.user?.photoURL,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordException(message: e.message);
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
}
