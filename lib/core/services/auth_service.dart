import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

abstract class AuthServiceContract<T, U> {
  Future<U> signInWithEmailAndPassword(String email, String password);

  Future<U> signInWithGoogle();
  Future<U> signInWithFacebook();

  Future<U> createWithEmailAndPassword(String userName, String email, String password);

  Future<T> currentUser();

  Future<void> signOut();
}

class FireBaseAuthServiceImpl implements AuthServiceContract<User?, UserCredential> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DateTime timeStamp = DateTime.now();

  @override
  Future<UserCredential> createWithEmailAndPassword(String userName, String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(userName);
    if (userCredential.user != null) {
      await storeUserInfo(userCredential);
    }
    await _auth.signOut();
    userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    //Create the user in firestore with the user data
    debugPrint("Auth Service User Name: ${userCredential.user?.displayName}");

    return userCredential;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await _auth.signInWithCredential(authCredential);
    storeUserInfo(userCredential);
    return userCredential;
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult facebookLoginResult = await facebookAuth.login(permissions: ['email', 'public_profile']);
    // debugPrint("Facebook token userID: ${facebookLoginResult.accessToken?.grantedPermissions}");
    //
    // final graphResponse = await http.get(Uri.parse(
    //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${facebookLoginResult.accessToken?.token}'));
    // final profile = jsonDecode(graphResponse.body);
    // debugPrint("Profile is equal to $profile");

    if (facebookLoginResult.accessToken != null) {
      final AuthCredential authCredential =
          FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      UserCredential userCredential = await _auth.signInWithCredential(authCredential);

      debugPrint("facebook profile picture: ${userCredential.user?.photoURL}");
      Map<String, dynamic> userdata = await facebookAuth.getUserData(fields: "picture.with(200).height(200)");
      debugPrint("facebook profile picture: ${userdata["picture"]["data"]['url']}");

      if (userCredential.user == null && userCredential.user?.photoURL == null ||
          userCredential.user!.photoURL!.contains('https://graph.facebook.com/')) {
        userCredential.user
            ?.updatePhotoURL(userdata["picture"]["data"]['url'])
            .then((value) => storeUserInfo(userCredential));
        _auth.signOut();
        _auth.signInWithCredential(authCredential);
      }

      storeUserInfo(userCredential);
      return userCredential;
    } else {
      throw Exception("Failed to login");
    }
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
  Future<void> signOut() async {
    if (_googleSignIn.currentUser != null) {
      debugPrint("Google Current user is not null");
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }
    await facebookAuth.logOut();
    await _auth.signOut();
  }

  //This method is used to create the user in firestore
  Future<void> storeUserInfo(UserCredential userCredential) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await db.collection("users").doc(userCredential.user?.uid).get();

    //Creates the user doc named whatever the user uid is in te collection "users"
    //and adds the user data
    if (!userDoc.exists) {
      await db.collection("users").doc(userCredential.user?.uid).set({
        'Name': userCredential.user?.displayName,
        'Email': userCredential.user?.email,
        'photoUrl': userCredential.user?.photoURL,
        'bio': '',
        // 'timeStamp': timeStamp,
      });
    }
  }
}
