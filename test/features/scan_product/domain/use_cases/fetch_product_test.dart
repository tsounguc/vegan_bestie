import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';
import 'scan_product_repository.mock.dart';

void main() {
  late ScanProductRepository repository;
  late FetchProduct useCase;
  setUp(() {
    repository = MockScanProductRepository();
    useCase = FetchProduct(repository);
  });
  final testResponse = FoodProduct.empty();
  const params = FetchProductParams.empty();
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
      expect(result, Right<Failure, FoodProduct>(testResponse));
      verify(() => repository.fetchProduct(barcode: params.barcode)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
