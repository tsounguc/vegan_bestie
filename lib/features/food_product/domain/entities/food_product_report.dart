import 'package:equatable/equatable.dart';

class FoodProductReport extends Equatable {
  const FoodProductReport({
    required this.barcode,
    required this.userId,
    required this.incorrectImage,
    required this.incorrectProductName,
    required this.incorrectMacros,
    required this.incorrectIngredient,
    required this.incorrectLabel,
    required this.isWrongProduct,
    required this.doesNotExist,
    required this.other,
    this.comment,
  });

  final String barcode;
  final String userId;
  final bool incorrectImage;
  final bool incorrectProductName;
  final bool incorrectMacros;
  final bool incorrectIngredient;
  final bool incorrectLabel;
  final bool isWrongProduct;
  final bool doesNotExist;
  final bool other;
  final String? comment;

  @override
  List<Object?> get props => [
        barcode,
        userId,
        incorrectImage,
        incorrectProductName,
        incorrectMacros,
        incorrectIngredient,
        incorrectLabel,
        isWrongProduct,
        doesNotExist,
        other,
        comment,
      ];
}
