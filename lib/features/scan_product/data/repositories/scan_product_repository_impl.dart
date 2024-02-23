import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';

class ScanProductRepositoryImpl implements ScanProductRepository {
  const ScanProductRepositoryImpl(this._remoteDataSource);

  final ScanProductRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<FoodProduct> fetchProduct({required String barcode}) {
    // TODO: implement fetchProduct
    throw UnimplementedError();
  }

  @override
  ResultFuture<Barcode> scanBarcode() async {
    // TODO: implement scanBarcode
    throw UnimplementedError();
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
