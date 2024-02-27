import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/scan_barcode.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class MockScanProduct extends Mock implements ScanBarcode {}

class MockFetchProduct extends Mock implements FetchProduct {}

void main() {
  late ScanBarcode scanBarcode;
  late FetchProduct fetchProduct;
  late ScanProductCubit cubit;
  setUp(() {
    scanBarcode = MockScanProduct();
    fetchProduct = MockFetchProduct();
    cubit = ScanProductCubit(
      scanBarcode: scanBarcode,
      fetchProduct: fetchProduct,
    );
  });

  tearDown(() => cubit.close());

  test(
      'given ScanProductCubit '
      'when cubit is instantiated '
      'then initial should be [ScanProductInitial]', () async {
    // Arrange
    // Act
    // Assert
    expect(cubit.state, const ScanProductInitial());
  });

  group('scanBarcode - ', () {
    const testBarcode = Barcode(barcode: '123456789012');
    const testScanFailure = ScanFailure(message: 'message', statusCode: 400);
    blocTest<ScanProductCubit, ScanProductState>(
      'given ScanProductCubit '
      'when [ScanProductCubit.scanBarcode] call completed successfully '
      'then emit [ScanningBarcode, BarcodeFound] ',
      build: () {
        when(() => scanBarcode()).thenAnswer(
          (_) async => const Right(testBarcode),
        );
        return cubit;
      },
      act: (cubit) => cubit.scanBarcode(),
      expect: () => [
        const ScanningBarcode(),
        BarcodeFound(barcode: testBarcode.barcode),
      ],
      verify: (cubit) {
        verify(() => scanBarcode()).called(1);
        verifyNoMoreInteractions(scanBarcode);
      },
    );
    blocTest<ScanProductCubit, ScanProductState>(
      'given ScanProductCubit '
      'when [ScanProductCubit.scanBarcode] call unsuccessful '
      'then emit [ScanningBarcode, ScanProductError] ',
      build: () {
        when(() => scanBarcode()).thenAnswer(
          (_) async => const Left(testScanFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.scanBarcode(),
      expect: () => [
        const ScanningBarcode(),
        ScanProductError(message: testScanFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(() => scanBarcode()).called(1);
        verifyNoMoreInteractions(scanBarcode);
      },
    );
  });
}
