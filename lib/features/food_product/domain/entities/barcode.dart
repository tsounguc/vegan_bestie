import 'package:equatable/equatable.dart';

class Barcode extends Equatable {
  const Barcode({required this.barcode});

  const Barcode.empty() : this(barcode: '_empty.barcode');

  final String barcode;

  @override
  List<Object?> get props => [barcode];
}
