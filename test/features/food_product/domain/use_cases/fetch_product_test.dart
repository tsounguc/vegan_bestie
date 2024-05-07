import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/fetch_product.dart';
import 'scan_product_repository.mock.dart';

void main() {
  late FoodProductRepository repository;
  late FetchProduct useCase;
  setUp(() {
    repository = MockScanProductRepository();
    useCase = FetchProduct(repository);
  });
  final testResponse = FoodProduct.empty();
  const params = FetchProductParams.empty();
  final testFailure = FetchProductFailure(
    message: 'message',
    statusCode: 500,
  );
  test(
    'given FetchProduct use case '
    'when instantiated '
    'then [ScanProductRepository.fetchProduct] should be called '
    'and [FoodProduct] returned',
    () async {
      // Arrange
      when(() => repository.fetchProduct(barcode: params.barcode)).thenAnswer(
        (_) async => Right<Failure, FoodProduct>(testResponse),
      );
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, equals(Right<Failure, FoodProduct>(testResponse)));
      verify(() => repository.fetchProduct(barcode: params.barcode)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
  test(
    'given FetchProduct use case '
    'when instantiated '
    'and [ScanProductRepository.fetchProduct] call unsuccessful '
    'then return [FetchProductFailure] ',
    () async {
      // Arrange
      when(() => repository.fetchProduct(barcode: params.barcode)).thenAnswer(
        (_) async => Left(testFailure),
      );
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, equals(Left<Failure, FoodProduct>(testFailure)));
      verify(() => repository.fetchProduct(barcode: params.barcode)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
