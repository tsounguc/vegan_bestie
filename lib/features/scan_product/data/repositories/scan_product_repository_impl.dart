import 'package:dartz/dartz.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';

class ScanProductRepositoryImpl implements ScanProductRepository {
  const ScanProductRepositoryImpl(this._remoteDataSource);

  final ScanProductRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<FoodProduct> fetchProduct({required String barcode}) async {
    try {
      final result = await _remoteDataSource.fetchProduct(barcode: barcode);
      return Right(result);
    } on FetchProductException catch (e) {
      return Left(FetchProductFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Barcode> scanBarcode() async {
    try {
      final result = await _remoteDataSource.scanBarcode();
      return Right(result);
    } on ScanException catch (e) {
      return Left(ScanFailure.fromException(e));
    }
  }

  @override
  ResultVoid removeFoodProduct({required String barcode}) async {
    try {
      final result = await _remoteDataSource.removeFoodProduct(
        barcode: barcode,
      );
      return Right(result);
    } on SaveFoodProductException catch (e) {
      return Left(SaveFoodProductFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveFoodProduct({required String barcode}) async {
    try {
      final result = await _remoteDataSource.saveFoodProduct(
        barcode: barcode,
      );
      return Right(result);
    } on SaveFoodProductException catch (e) {
      return Left(SaveFoodProductFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<FoodProduct>> fetchSavedProductsList({required List<String> productsList}) async {
    try {
      final result = await _remoteDataSource.fetchSavedProductsList(barcodesList: productsList);
      return Right(result);
    } on FetchProductException catch (e) {
      return Left(FetchProductFailure.fromException(e));
    }
  }
}
