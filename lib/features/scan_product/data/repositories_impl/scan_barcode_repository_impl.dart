import 'package:dartz/dartz.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/barcode_entity.dart';
import '../../domain/repositories_contracts/scan_barcode_repository_contract.dart';
import '../data_sources/scan_barcode_from_plugin.dart';
import '../mapper/scan_barcode_mapper.dart';

class ScanBarcodeRepositoryImpl implements ScanBarcodeRepositoryContract {
  ScanBarcodeFromPluginContract scanBarcodeFromPluginContract = serviceLocator<ScanBarcodeFromPluginContract>();
  @override
  Future<Either<ScanningFailure, BarcodeEntity>> scanBarcode() async {
    try {
      BarcodeModel barcodeModel = await scanBarcodeFromPluginContract.scanBarcode();
      ScanBarcodeMapper mapper = ScanBarcodeMapper();
      BarcodeEntity barcodeEntity = mapper.mapToEntity(barcodeModel);
      return Right(barcodeEntity);
    } on ScanBarcodeException catch (e) {
      return Left(ScanningFailure(message: e.message));
    }
  }
}
