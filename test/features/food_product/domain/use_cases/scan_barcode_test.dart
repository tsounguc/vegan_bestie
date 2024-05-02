import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/food_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/food_product/domain/repositories/scan_product_repository.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/scan_barcode.dart';

import 'scan_product_repository.mock.dart';

void main() {
  late ScanProductRepository repository;
  late ScanBarcode useCase;
  late Failure testFailure;
  late Barcode testResponse;
  setUp(() {
    repository = MockScanProductRepository();
    useCase = ScanBarcode(repository);
    testFailure = ScanFailure(
      message: 'Invalid Barcode',
      statusCode: '',
    );
    testResponse = const Barcode.empty();
  });
  test(
    'given ScanBarcode use case '
    'when instantiated '
    'then [ScanProductRepository.scanBarcode] should be called '
    'and [Barcode] returned',
    () async {
      // Arrange
      when(() => repository.scanBarcode()).thenAnswer(
        (_) async => Right(testResponse),
      );
      // Act
      final result = await useCase();
      // Assert
      expect(result, equals(Right<Failure, Barcode>(testResponse)));
      verify(() => repository.scanBarcode()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
  test(
    'given ScanBarcode use case '
    'when instantiated '
    'and [ScanProductRepository.scanBarcode] call unsuccessful '
    'then return [ScanFailure]',
    () async {
      // Arrange
      when(() => repository.scanBarcode()).thenAnswer(
        (_) async => Left(testFailure),
      );
      // Act
      final result = await useCase();
      // Assert
      expect(result, equals(Left<Failure, Barcode>(testFailure)));
      verify(() => repository.scanBarcode()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
