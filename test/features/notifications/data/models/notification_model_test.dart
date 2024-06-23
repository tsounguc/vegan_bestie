import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sheveegan/core/enums/notification_enum.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/data/models/notification_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  final date = DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds']!).add(
    Duration(microseconds: timestampData['_nanoseconds']!),
  );

  final timestamp = Timestamp.fromDate(date);

  final testModel = NotificationModel.empty();

  final testMap = jsonDecode(fixture('notification.json')) as DataMap;
  testMap['sentAt'] = timestamp;

  test(
    'given [NotificationModel], '
    'when instantiated '
    'then instance should be a subclass of [Notification] entity',
    () {
      // Arrange
      // Act
      final result = NotificationModel.fromMap(testMap);
      // Assert
      expect(result, equals(testModel));
    },
  );

  group('fromMap - ', () {
    test(
        'given [NotificationModel], '
        'when fromMap is called, '
        'then return [NotificationModel] with correct data ', () {
      // Arrange
      // Act
      final result = NotificationModel.fromMap(testMap);
      // Assert
      expect(result, equals(testModel));
    });
  });

  // group('fromJson - ', () {
  //   test(
  //       'given [NotificationModel], '
  //       'when fromJson is called, '
  //       'then return [NotificationModel] with correct data ', () {
  //     // Arrange
  //     // Act
  //     final result = NotificationModel.fromJson(testJson);
  //     // Assert
  //     expect(result, equals(testModel));
  //   });
  // });

  group('toMap - ', () {
    test(
        'given [NotificationModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testModel.toMap()..remove('sentAt');
      // Assert
      expect(result, equals(testMap..remove('sentAt')));

      expect(result, equals(testMap..remove('sentAt')));
    });
  });

  // group('toJson - ', () {
  //   test(
  //       'given [NotificationModel], '
  //       'when toJson is called, '
  //       'then return [JSON] with correct data ', () {
  //     // Arrange
  //     // Act
  //     final result = testModel.toJson();
  //     // Assert
  //     expect(
  //       result,
  //       equals(
  //         jsonEncode(testMap),
  //       ),
  //     );
  //   });
  // });

  group('copyWith - ', () {
    test(
        'given [NotificationModel], '
        'when copyWith is called, '
        'then return [NotificationModel] with updated data ', () {
      // Arrange
      // Act
      final result = testModel.copyWith(category: NotificationCategory.NONE);
      // Assert
      expect(result.category, equals(NotificationCategory.NONE));
    });
  });
}
