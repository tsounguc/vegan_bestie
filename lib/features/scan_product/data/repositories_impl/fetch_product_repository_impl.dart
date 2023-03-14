import 'package:dartz/dartz.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/fetch_product_from_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/data/mapper/fetch_product_mapper.dart';
import 'package:sheveegan/features/scan_product/domain/repositories_contracts/fetch_product_repository_contract.dart';

import '../models/product_info_model.dart';
import '../../domain/entities/product_info_entity.dart';

class FetchProductRepositoryImpl implements FetchProductRepositoryContract {
  FetchProductFromRemoteDataSourceContract fetchProductFromRemoteDataSourceContract =
      serviceLocator<FetchProductFromRemoteDataSourceContract>();
  @override
  Future<Either<FetchProductFailure, ProductInfoEntity>> fetchProduct(String barcode) async {
    try {
      ProductInfoModel productInfoModel = await fetchProductFromRemoteDataSourceContract.fetchProduct(barcode);
      ProductMapper mapper = ProductMapper();
      ProductInfoEntity productInfoEntity = mapper.mapToEntity(productInfoModel);
      return Right(productInfoEntity);
    } on FetchProductException catch (e) {
      return Left(FetchProductFailure(message: e.message));
    }
  }
}
