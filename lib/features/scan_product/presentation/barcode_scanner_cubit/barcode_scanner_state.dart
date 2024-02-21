part of 'barcode_scanner_cubit.dart';

@immutable
abstract class BarcodeScannerState extends Equatable {
  const BarcodeScannerState();
}

class InitialScannerState extends BarcodeScannerState {
  @override
  List<Object?> get props => [];
}

class ScanningBarcodeState extends BarcodeScannerState {
  @override
  List<Object?> get props => [];
}

class BarcodeFoundState extends BarcodeScannerState {
  final String barcode;

  BarcodeFoundState({required this.barcode});

  @override
  List<Object?> get props => [];
}

class ScanningCanceledState extends BarcodeScannerState {
  final String? barcode;
  final String? message;

  ScanningCanceledState({required this.barcode, required this.message});

  @override
  List<Object?> get props => [barcode];
}

class ScanningErrorState extends BarcodeScannerState {
  final error;

  ScanningErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
