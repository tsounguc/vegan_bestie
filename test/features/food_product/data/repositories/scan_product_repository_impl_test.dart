import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/food_product/data/data_sources/food_product_remote_data_source.dart';
import 'package:sheveegan/features/food_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/data/repositories/food_product_repository_impl.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class MockScanProductRemoteDataSource extends Mock implements FoodProductRemoteDataSource {}

void main() {
  late FoodProductRemoteDataSource remoteDataSource;
  late FoodProductRepositoryImpl repositoryImpl;
  late ScanException testScanException;
  late FetchProductException testFetchProductException;
  setUp(() {
    remoteDataSource = MockScanProductRemoteDataSource();
    repositoryImpl = FoodProductRepositoryImpl(remoteDataSource);
    testScanException = const ScanException(message: 'Invalid Barcode');
    testFetchProductException = const FetchProductException(
      message: 'Product Not Found',
      statusCode: 404,
    );
  });
  test(
    'given ScanProductRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [ScanProductRepository]',
    () {
      expect(repositoryImpl, isA<FoodProductRepository>());
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
        expect(result, equals(const Right<Failure, BarcodeModel>(testBarcode)));
        verify(() => remoteDataSource.scanBarcode()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given ScanProductRepositoryImpl, '
      'when [ScanProductRepository.scanBarcode] is called '
      'and remote data source call is unsuccessful '
      'then return [ScanFailure]',
      () async {
        // Arrange
        when(() => remoteDataSource.scanBarcode()).thenThrow(testScanException);
        // Act
        final result = await repositoryImpl.scanBarcode();
        // Assert
        expect(
          result,
          equals(
            Left<Failure, BarcodeModel>(
              ScanFailure.fromException(testScanException),
            ),
          ),
        );
        verify(() => remoteDataSource.scanBarcode()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
  group('fetchProduct -', () {
    final testFoodProduct = FoodProductModel.empty();
    const barcode = 'whatever.barcode';
    test(
      'given ScanProductRepositoryImpl, '
      'when [ScanProductRepositoryImpl.fetchProduct] is called '
      'and remote data source call is successful '
      'then return a [FoodProduct] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.fetchProduct(barcode: any(named: 'barcode')),
        ).thenAnswer((_) async => testFoodProduct);
        // Act
        final result = await repositoryImpl.fetchProduct(barcode: barcode);
        // Assert
        expect(result, equals(Right<Failure, FoodProduct>(testFoodProduct)));
        verify(() => remoteDataSource.fetchProduct(barcode: barcode)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given ScanProductRepositoryImpl, '
      'when [ScanProductRepositoryImpl.fetchProduct] is called '
      'and remote source call unsuccessfully '
      'then return a [FoodProductFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.fetchProduct(barcode: any(named: 'barcode')),
        ).thenThrow(testFetchProductException);
        // Act
        final result = await repositoryImpl.fetchProduct(barcode: barcode);
        // Assert
        expect(
          result,
          equals(
            Left<Failure, FoodProduct>(
              FetchProductFailure.fromException(testFetchProductException),
            ),
          ),
        );
        verify(() => remoteDataSource.fetchProduct(barcode: barcode)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
