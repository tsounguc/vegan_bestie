import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../entities/barcode_entity.dart';

abstract class ScanBarcodeRepositoryContract {
  Future<Either<ScanningFailure, BarcodeEntity>> scanBarcode();
}
