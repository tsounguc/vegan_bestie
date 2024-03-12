import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late UserModel testModel;
  late DataMap testMap;
  setUpAll(() {
    testModel = const UserModel.empty();
    testMap = jsonDecode(fixture('user.json')) as DataMap;
  });
  test(
    'given [UserModel], '
    'when instantiated '
    'then instance should be a subclass of [UserEntity] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<UserEntity>());
    },
  );

  group('fromMap - ', () {
    test(
        'given [UserModel], '
        'when fromMap is called, '
        'then return [UserModel] with correct data ', () {
      // Arrange
      // Act
      final result = UserModel.fromMap(testMap);
      // Assert
      expect(result, isA<UserModel>());
      expect(result, equals(testModel));
    });
  });

  group('toMap - ', () {
    test(
        'given [UserModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('copyWith - ', () {
    const testEmail = 'tsounguc@mail.gvsu.edu';
    test(
      'given [UserModel], '
      'when copyWith is called, '
      'then return [UserModel] with updated data ',
      () {
        // Arrange
        // Act
        final result = testModel.copyWith(email: testEmail);
        // Assert
        expect(result.email, equals(testEmail));
      },
    );
  });
}
