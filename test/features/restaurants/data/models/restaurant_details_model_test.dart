import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_details_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late String testJson;
  late DataMap testMap;
  late RestaurantDetailsModel testModel;
  setUpAll(() {
    testJson = fixture('restaurant_details.json');
    testModel = RestaurantDetailsModel.fromJson(testJson);
    testMap = testModel.toMap();
  });

  test(
    'given [RestaurantDetailsModel], '
    'when instantiated '
    'then instance should be a subclass of [RestaurantDetails] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<RestaurantDetails>());
    },
  );

  // group('fromMap - ', () {
  //   test(
  //       'given [RestaurantDetailsModel], '
  //       'when fromMap is called, '
  //       'then return [RestaurantDetailsModel] with correct data ', () {
  //     // Arrange
  //     // Act
  //     final result = RestaurantDetailsModel.fromMap(testMap);
  //     // Assert
  //     expect(result, equals(testModel));
  //   });
  // });

  group('fromJson - ', () {
    test(
        'given [RestaurantDetailsModel], '
        'when fromJson is called, '
        'then return [RestaurantDetailsModel] with correct data ', () {
      // Arrange
      // Act
      final result = RestaurantDetailsModel.fromJson(testJson);
      // Assert
      expect(result, equals(testModel));
    });
  });

  group('toMap - ', () {
    test(
        'given [RestaurantDetailsModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });
  group('toJson - ', () {
    test(
        'given [RestaurantDetailsModel], '
        'when toJson is called, '
        'then return [JSON] with correct data ', () {
      // Arrange
      // Act
      final result = testModel.toJson();
      // Assert
      expect(
        result,
        equals(
          jsonEncode(testMap),
        ),
      );
    });
  });
}
