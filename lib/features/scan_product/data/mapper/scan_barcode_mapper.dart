import '../../domain/entities/barcode.dart';
import '../models/barcode_model.dart';

class ScanBarcodeMapper {
  Barcode mapToEntity(BarcodeModel barcodeModel) {
    return Barcode(barcode: barcodeModel.barcode);
  }
}
