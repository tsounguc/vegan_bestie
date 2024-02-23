import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/data/repositories/scan_product_repository_impl.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';

class MockScanProductRemoteDataSource extends Mock implements ScanProductRemoteDataSource {}

void main() {
  late ScanProductRemoteDataSource remoteDataSource;
  late ScanProductRepositoryImpl repositoryImpl;
  setUp(() {
    remoteDataSource = MockScanProductRemoteDataSource();
    repositoryImpl = ScanProductRepositoryImpl(remoteDataSource);
  });
  test(
    'given ScanProductRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [ScanProductRepository]',
    () {
      expect(repositoryImpl, isA<ScanProductRepository>);
    },
  );
  group('scanBarcode - ', () {
    const testBarcode = BarcodeModel.empty();
    test(
      'given ScanProductRepositoryImpl, '
      'when [ScanProductRepository.scanBarcode] is called '
      'then complete call to remote data source successfully '
      'and return [Barcode]',
      () async {
        // Arrange
        when(() => remoteDataSource.scanBarcode()).thenAnswer(
          (_) async => testBarcode,
        );
        // Act
        final result = await repositoryImpl.scanBarcode();
        // Assert
        expect(result, const Right<Failure, BarcodeModel>(testBarcode));
        verify(() => remoteDataSource.scanBarcode()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
