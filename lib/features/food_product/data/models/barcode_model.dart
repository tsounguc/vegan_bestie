import 'package:sheveegan/features/food_product/domain/entities/barcode.dart';

class BarcodeModel extends Barcode {
  const BarcodeModel({required super.barcode});

  const BarcodeModel.empty() : this(barcode: '_empty.barcode');

  BarcodeModel copyWith({String? barcode}) {
    return BarcodeModel(barcode: barcode ?? this.barcode);
  }
}
