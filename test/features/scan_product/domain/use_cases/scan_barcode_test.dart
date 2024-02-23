import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/repositories_contracts/scanning_repository.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/scan_barcode.dart';

import 'scan_product_repository.mock.dart';

void main() {
  late ScanProductRepository repository;
  late ScanBarcode useCase;
  setUp(() {
    repository = MockScanProductRepository();
    useCase = ScanBarcode(repository);
  });
  const testResponse = Barcode.empty();
  test(
    'given ScanBarcode use case '
    'when instantiated '
    'then [ScanProductRepository.scanBarcode] should be called '
    'and [Barcode] returned',
    () async {
      // Arrange
      when(() => repository.scanBarcode()).thenAnswer(
        (_) async => const Right<Failure, Barcode>(testResponse),
      );
      // Act
      final result = await useCase();
      // Assert
      expect(result, const Right<Failure, Barcode>(testResponse));
      verify(() => repository.scanBarcode()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
