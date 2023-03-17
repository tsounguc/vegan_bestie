import '../../domain/entities/barcode_entity.dart';
import '../models/barcode_model.dart';

class ScanBarcodeMapper {
  BarcodeEntity mapToEntity(BarcodeModel barcodeModel) {
    return BarcodeEntity(barcode: barcodeModel.barcode);
  }
}
