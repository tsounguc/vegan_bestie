import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode_entity.dart';

class ScanBarcodeMapper {
  BarcodeEntity mapToEntity(BarcodeModel barcodeModel) {
    return BarcodeEntity(barcode: barcodeModel.barcode);
  }
}
