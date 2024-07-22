import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServiceContract<T, U> {
  Future<U> signInWithEmailAndPassword(String email, String password);

  Future<U> signInWithGoogle();

  // Future<U> signInWithFacebook();

  Future<U> createWithEmailAndPassword(
    String userName,
    String email,
    String password,
  );

  Future<T> currentUser();

  Future<void> signOut();
}

class FireBaseAuthServiceImpl
    implements AuthServiceContract<User?, UserCredential> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DateTime timeStamp = DateTime.now();

  @override
  Future<UserCredential> createWithEmailAndPassword(
    String userName,
    String email,
    String password,
  ) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.updateDisplayName(userName);
    if (userCredential.user != null) {
      await storeUserInfo(userCredential);
    }
    await _auth.signOut();
    userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    //Create the user in firestore with the user data
    debugPrint('Auth Service User Name: ${userCredential.user?.displayName}');

    return userCredential;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await _auth.signInWithCredential(authCredential);
    await storeUserInfo(userCredential);
    return userCredential;
  }

  @override
  // Future<UserCredential> signInWithFacebook() async {
  //   final facebookLoginResult = await facebookAuth.login(
  //     permissions: ['email', 'public_profile'],
  //   );
  //   // debugPrint('Facebook token userID: '
  //   //     '${facebookLoginResult.accessToken?.grantedPermissions} ');
  //   //
  //   // final graphResponse = await http.get(Uri.parse(
  //   //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${facebookLoginResult.accessToken?.token}'));
  //   // final profile = jsonDecode(graphResponse.body);
  //   // debugPrint("Profile is equal to $profile");
  //
  //   if (facebookLoginResult.accessToken != null) {
  //     final AuthCredential authCredential = FacebookAuthProvider.credential(
  //       facebookLoginResult.accessToken!.token,
  //     );
  //     final userCredential = await _auth.signInWithCredential(authCredential);
  //
  //     debugPrint('facebook profile picture: ${userCredential.user?.photoURL}');
  //     final userdata = await facebookAuth.getUserData(
  //       fields: 'picture.with(200).height(200)',
  //     );
  //     debugPrint(
  //       "facebook profile picture: ${userdata['picture']['data']['url']}",
  //     );
  //
  //     if (userCredential.user == null && userCredential.user?.photoURL == null ||
  //         userCredential.user!.photoURL!.contains('https://graph.facebook.com/')) {
  //       await userCredential.user
  //           ?.updatePhotoURL(userdata['picture']['data']['url'] as String)
  //           .then((value) => storeUserInfo(userCredential));
  //       await _auth.signOut();
  //       await _auth.signInWithCredential(authCredential);
  //     }
  //
  //     await storeUserInfo(userCredential);
  //     return userCredential;
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }

  @override
  Future<User?> currentUser() async {
    final currentUser = _auth.currentUser;
    await currentUser?.reload();
    if (currentUser != null) {
      return currentUser;
    } else {
      throw Exception('User not signed In');
    }
  }

  @override
  Future<void> signOut() async {
    if (_googleSignIn.currentUser != null) {
      debugPrint('Google Current user is not null');
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }
    // await facebookAuth.logOut();
    await _auth.signOut();
  }

  //This method is used to create the user in firestore
  Future<void> storeUserInfo(UserCredential userCredential) async {
    final userDoc = await db
        .collection('users')
        .doc(
          userCredential.user?.uid,
        )
        .get();

    //Create the user doc with user uid as doc name
    // and add the user data in the doc
    if (!userDoc.exists) {
      await db.collection('users').doc(userCredential.user?.uid).set({
        'Name': userCredential.user?.displayName,
        'Email': userCredential.user?.email,
        'photoUrl': userCredential.user?.photoURL,
        'bio': '',
        // 'timeStamp': timeStamp,
      });
    }
  }
}
