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
}
// class ScanBarcodeRepositoryImpl implements ScanProductRepository {
//   ScanBarcodeFromPluginContract scanBarcodeFromPluginContract = serviceLocator<ScanBarcodeFromPluginContract>();
//
//   @override
//   Future<Either<ScanningFailure, Barcode>> scanBarcode() async {
//     try {
//       BarcodeModel barcodeModel = await scanBarcodeFromPluginContract.scanBarcode();
//       ScanBarcodeMapper mapper = ScanBarcodeMapper();
//       Barcode barcodeEntity = mapper.mapToEntity(barcodeModel);
//       return Right(barcodeEntity);
//     } on ScanBarcodeException catch (e) {
//       return Left(ScanningFailure(message: e.message));
//     }
//   }
// }

// class FetchProductRepositoryImpl implements FetchProductRepositoryContract {
//   FetchProductFromRemoteDataSourceContract fetchProductFromRemoteDataSourceContract =
//   serviceLocator<FetchProductFromRemoteDataSourceContract>();
//
//   @override
//   Future<Either<FetchProductFailure, ScannedProduct>> fetchProduct(String barcode) async {
//     try {
//       ScanProductModel productInfoModel = await fetchProductFromRemoteDataSourceContract.fetchProduct(barcode);
//       ScanProductMapper mapper = ScanProductMapper();
//       ScannedProduct productInfoEntity = mapper.mapToEntity(productInfoModel);
//       return Right(productInfoEntity);
//     } on FetchProductException catch (e) {
//       return Left(FetchProductFailure(message: e.message));
//     }
//   }
// }
