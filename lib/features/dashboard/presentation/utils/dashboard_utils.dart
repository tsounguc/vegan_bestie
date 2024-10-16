import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<UserModel> get userDataStream => serviceLocator<FirebaseFirestore>()
      .collection('users')
      .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map(
        (event) => UserModel.fromMap(event.data()!),
      );

  static Stream<List<UserModel>> getUser(String userId) {
    return serviceLocator<FirebaseFirestore>().collection('users').where('uid', isEqualTo: userId).snapshots().map(
          (event) => event.docs
              .map(
                (e) => UserModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }
}
