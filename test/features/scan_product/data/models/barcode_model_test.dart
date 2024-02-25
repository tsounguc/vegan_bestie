import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late String testJson;
  late DataMap testMap;
  late BarcodeModel testModel;

  setUpAll(() {
    testJson = fixture('food_product.json');
    testMap = jsonDecode(testJson) as DataMap;
    testModel = const BarcodeModel.empty();
  });

  test(
    'given [BarcodeModel], '
    'when instantiated '
    'then instance should be a subclass of [Barcode] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<Barcode>());
    },
  );

  group('copyWith - ', () {
    const testBarcode = '123456789012';
    test(
        'given [BarcodeModel], '
        'when copyWith is called, '
        'then return [BarcodeModel] with updated data ', () {
      // Arrange
      // Act
      final result = testModel.copyWith(barcode: testBarcode);
      // Assert
      expect(result.barcode, equals(testBarcode));
    });
  });
}
