import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:sheveegan/features/notifications/data/models/notification_model.dart';

void main() {
  late NotificationRemoteDatasource remoteDatasource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;

  setUp(() async {
    firestore = FakeFirebaseFirestore();
    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);

    remoteDatasource = NotificationRemoteDatasourceImpl(firestore: firestore, auth: auth);
  });
  Future<DocumentReference> addNotification(NotificationModel notification) async {
    return firestore
        .collection('users')
        .doc(
          auth.currentUser!.uid,
        )
        .collection('notifications')
        .add(notification.toMap());
  }

  Future<QuerySnapshot<DataMap>> getNotifications() async =>
      firestore.collection('users').doc(auth.currentUser!.uid).collection('notifications').get();

  group('sendNotification', () {
    test(
      'given NotificationRemoteDatasourceImpl '
      'when [NotificationRemoteDatasourceImpl.sendNotification] is called '
      'then upload [Notification] to specified user',
      () async {
        // Arrange
        const secondUID = 'second_uid';
        for (var i = 0; i < 2; i++) {
          await firestore.collection('users').doc(i == 0 ? auth.currentUser!.uid : secondUID).set(
                const UserModel.empty()
                    .copyWith(
                      uid: i == 0 ? auth.currentUser!.uid : secondUID,
                      email: i == 0 ? auth.currentUser!.email : 'second email',
                      name: i == 0 ? auth.currentUser!.displayName : 'second name',
                    )
                    .toMap(),
              );
        }

        final notification = NotificationModel.empty().copyWith(
          id: '1',
          title: 'Test unique title, cannot be duplicated',
          body: 'Test',
        );

        // Act
        await remoteDatasource.sendNotification(notification);

        // Assert
        final user1NotificationsRef =
            await firestore.collection('users').doc(auth.currentUser!.uid).collection('notifications').get();

        final user2NotificationsRef =
            await firestore.collection('users').doc(secondUID).collection('notifications').get();

        expect(user1NotificationsRef.docs, hasLength(1));

        expect(user1NotificationsRef.docs.first.data()['title'], equals(notification.title));

        expect(user2NotificationsRef.docs, hasLength(1));
        expect(user2NotificationsRef.docs.first.data()['title'], equals(notification.title));
      },
    );
  });

  group('getNotifications', () {
    test(
      'given NotificationRemoteDatasourceImpl '
      'when [NotificationRemoteDatasourceImpl.getNotifications] is called '
      'then return [Stream<List<Notification>>] when the call is successful',
      () async {
        // Arrange
        final userId = auth.currentUser!.uid;
        await firestore.collection('users').doc(userId).set(
              const UserModel.empty().copyWith(uid: userId).toMap(),
            );
        final expectedNotifications = [
          NotificationModel.empty(),
          NotificationModel.empty().copyWith(
            id: '1',
            sentAt: DateTime.now().add(
              const Duration(seconds: 50),
            ),
          ),
        ];
        for (final notification in expectedNotifications) {
          await addNotification(notification);
        }
        // Act
        final result = remoteDatasource.getNotifications();
        // Assert
        expect(
          result,
          emitsInOrder([equals(expectedNotifications.reversed)]),
        );
      },
    );

    test(
      'given NotificationRemoteDatasourceImpl '
      'when [NotificationRemoteDatasourceImpl.getNotifications] is called and an error occurs '
      'then return a stream of empty list ',
      () async {
        // Arrange
        // Act
        final result = remoteDatasource.getNotifications();

        // Assert
        expect(result, emits(equals(<NotificationModel>[])));
      },
    );
  });

  group('clear', () {
    test(
      'given NotificationRemoteDatasourceImpl '
      'when [NotificationRemoteDatasourceImpl.clear] is called '
      'then delete the specified [Notification] from the database',
      () async {
        // Create notifications sub-collection for current user
        final firstDocRef = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications')
            .add(NotificationModel.empty().toMap());
        // Add a notification to the sub-collection
        final notification = NotificationModel.empty().copyWith(id: '1');
        final docRef = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications')
            .add(notification.toMap());

        final collection =
            await firestore.collection('users').doc(auth.currentUser!.uid).collection('notifications').get();
        // Assert that the notification was added
        expect(
          collection.docs,
          hasLength(2),
        );
        // Act
        await remoteDatasource.clear(docRef.id);
        final secondNotificationDoc = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications')
            .doc(docRef.id)
            .get();
        final firstNotificationDoc = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications')
            .doc(firstDocRef.id)
            .get();

        // Assert that the notification was deleted
        expect(
          secondNotificationDoc.exists,
          isFalse,
        );
        expect(
          firstNotificationDoc.exists,
          isTrue,
        );
      },
    );
  });

  group('clearAll', () {
    test(
      'given NotificationRemoteDatasourceImpl '
      'when [NotificationRemoteDatasourceImpl.clearAll] is called '
      "then delete every notification in the current user's sub-collection",
      () async {
        // Create notifications sub-collection for current user
        for (var i = 0; i < 5; i++) {
          await addNotification(
            NotificationModel.empty().copyWith(id: i.toString()),
          );
        }

        final collection = await getNotifications();
        // Assert that the notifications were added
        expect(
          collection.docs,
          hasLength(5),
        );

        // Act
        await remoteDatasource.clearAll();
        final notificationDocs = await getNotifications();

        // Assert that the notifications were deleted
        expect(
          notificationDocs.docs,
          isEmpty,
        );
      },
    );
  });

  group('markAsRead', () {
    test(
      'should mark the specified notification as read',
      () async {
        var tId = '';
        // Create notifications sub-collection for current user
        for (var i = 0; i < 5; i++) {
          final docRef = await addNotification(
            NotificationModel.empty().copyWith(
              id: i.toString(),
              seen: i.isEven,
            ),
          );
          if (i == 1) {
            tId = docRef.id;
          }
        }

        final collection = await getNotifications();
        // Assert that the notifications were added
        expect(
          collection.docs,
          hasLength(5),
        );

        // Act
        await remoteDatasource.markAsRead(tId);
        final notificationDoc = await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications')
            .doc(tId)
            .get();

        // Assert that the notification was marked as read
        expect(
          notificationDoc.data()!['seen'],
          isTrue,
        );
      },
    );
  });
}
