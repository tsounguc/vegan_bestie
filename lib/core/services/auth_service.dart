// import 'package:openfoodfacts/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../failures_successes/exceptions.dart';
import '../../features/auth/data/models/user_model.dart';

abstract class AuthServiceContract<T, U> {
  Future<U> signInWithEmailAndPassword(String email, String password);

  Future<U> createWithEmailAndPassword(String userName, String email, String password);

  Future<T> currentUser();

  Future<void> signOut();
}

class FireBaseAuthServiceImpl implements AuthServiceContract<User?, UserCredential> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Future<UserCredential> createWithEmailAndPassword(String userName, String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(userName);
    await _auth.signOut();
    userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    //Create the user in firestore with the user data
    debugPrint("Auth Service User Name: ${userCredential.user?.displayName}");
    await storeUserInfo(userCredential.user?.uid, userName, email);

    return userCredential;
  }

  @override
  Future<User?> currentUser() async {
    User? currentUser = _auth.currentUser;
    await currentUser?.reload();
    if (currentUser != null) {
      return currentUser;
    } else {
      throw Exception("User not signed In");
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //This method is used to create the user in firestore
  Future<void> storeUserInfo(String? uid, String username, String email) async {
    //Creates the user doc named whatever the user uid is in te collection "users"
    //and adds the user data
    await db.collection("users").doc(uid).set({
      'Name': username,
      'Email': email,
    });
  }
}
