import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/utils/datasource_utils.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/features/notifications/data/models/notification_model.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';

abstract class NotificationRemoteDatasource {
  const NotificationRemoteDatasource();

  Future<void> markAsRead(String notificationId);

  Future<void> clearAll();

  Future<void> clear(String notificationId);

  Future<void> sendNotification(Notification notification);

  Stream<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDatasourceImpl implements NotificationRemoteDatasource {
  NotificationRemoteDatasourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> clear(String notificationId) async {
    try {
      DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> clearAll() {
    try {
      DataSourceUtils.authorizeUser(_auth);

      final query = _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notifications');
      return _deleteNotificationsByQuery(query);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Stream<List<NotificationModel>> getNotifications() {
    try {
      DataSourceUtils.authorizeUser(_auth);
      final notificationsStream = _users
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (doc) => NotificationModel.fromMap(
                    doc.data(),
                  ),
                )
                .toList(),
          );
      return notificationsStream.handleError(
        (dynamic error) {
          if (error is FirebaseException) {
            throw ServerException(
              message: error.message ?? 'Unknown error occurred',
              statusCode: error.code,
            );
          }
          throw ServerException(
            message: error.toString(),
            statusCode: '505',
          );
        },
      );
    } on FirebaseException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } on ServerException catch (e) {
      return Stream.error(e);
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return Stream.error(
        const ServerException(
          message: 'Unknown error occurred',
          statusCode: '500',
        ),
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .update({'seen': true});
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> sendNotification(Notification notification) async {
    try {
      DataSourceUtils.authorizeUser(_auth);

      // add notification to every user's notification collection
      final users = await _users.get();

      // We are doing it this way because batch() can only do 500
      if (users.docs.length > 500) {
        for (var startIndex = 0; startIndex < users.docs.length; startIndex += 500) {
          final batch = _firestore.batch();
          final endIndex = startIndex + 500;
          final usersBatch = users.docs.sublist(
            startIndex,
            endIndex > users.docs.length ? users.docs.length : endIndex,
          );
          for (final user in usersBatch) {
            final newNotificationRef = user.reference.collection('notifications').doc();
            batch.set(
              newNotificationRef,
              (notification as NotificationModel)
                  .copyWith(
                    id: newNotificationRef.id,
                  )
                  .toMap(),
            );
          }
          await batch.commit();
        }
      } else {
        final batch = _firestore.batch();
        for (final user in users.docs) {
          final newNotificationRef = user.reference.collection('notifications').doc();
          batch.set(
            newNotificationRef,
            (notification as NotificationModel)
                .copyWith(
                  id: newNotificationRef.id,
                )
                .toMap(),
          );
        }
        await batch.commit();
      }
    } on FirebaseException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw ServerException(message: e.message ?? 'Unknown error occurred', statusCode: e.code);
    } on ServerException {
      rethrow;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw const ServerException(
        message: 'Unknown error occurred',
        statusCode: '500',
      );
    }
  }

  Future<void> _deleteNotificationsByQuery(Query query) async {
    final notifications = await query.get();
    if (notifications.docs.length > 500) {
      for (var i = 0; i < notifications.docs.length; i += 500) {
        final batch = _firestore.batch();
        final end = i + 500;
        final notificationsBatch = notifications.docs.sublist(
          i,
          end > notifications.docs.length ? notifications.docs.length : end,
        );
        for (final notification in notificationsBatch) {
          batch.delete(notification.reference);
        }
        await batch.commit();
      }
    } else {
      final batch = _firestore.batch();
      for (final notification in notifications.docs) {
        batch.delete(notification.reference);
      }
      await batch.commit();
    }
  }

  CollectionReference<Map<String, dynamic>> get _users => _firestore.collection(
        FirebaseConstants.usersCollection,
      );
}
