import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late String testJson;
  late DataMap testMap;
  late FoodProductModel testModel;
  setUpAll(() {
    testJson = fixture('food_product.json');
    testModel = FoodProductModel.fromJson(testJson);
    testMap = testModel.toMap();
  });
  test(
    'given [FoodProductModel], '
    'when instantiated '
    'then instance should be a subclass of [FoodProduct] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<FoodProduct>());
    },
  );

  group('fromMap - ', () {
    test(
        'given [FoodProductModel], '
        'when fromMap is called, '
        'then return [FoodProductModel] with correct data ', () {
      // Arrange
      // Act
      final result = FoodProductModel.fromMap(testMap);
      // Assert
      expect(result, equals(testModel));
    });
  });

  group('fromJson - ', () {
    test(
        'given [FoodProductModel], '
        'when fromJson is called, '
        'then return [FoodProductModel] with correct data ', () {
      // Arrange
      // Act
      final result = FoodProductModel.fromJson(testJson);
      // Assert
      expect(result, equals(testModel));
    });
  });

  group('toMap - ', () {
    test(
        'given [FoodProductModel], '
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
        'given [FoodProductModel], '
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
  group('copyWith - ', () {
    test(
        'given [FoodProductModel], '
        'when copyWith is called, '
        'then return [FoodProductModel] with updated data ', () {
      // Arrange
      // Act
      final result = testModel.copyWith(code: '12345678');
      // Assert
      expect(result.code, equals('12345678'));
    });
  });
}
