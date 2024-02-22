import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/entities/scanned_product.dart';

abstract class ScanProductRepository {
  ResultFuture<Barcode> scanBarcode();

  ResultFuture<ScannedProduct> fetchProduct({String barcode});
}
