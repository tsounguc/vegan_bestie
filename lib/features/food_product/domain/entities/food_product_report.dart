import 'package:equatable/equatable.dart';

class FoodProductReport extends Equatable {
  const FoodProductReport({
    required this.id,
    required this.barcode,
    required this.userId,
    required this.userName,
    required this.incorrectImage,
    required this.incorrectProductName,
    required this.incorrectMacros,
    required this.incorrectIngredients,
    required this.incorrectLabel,
    required this.isWrongProduct,
    required this.doesNotExist,
    required this.other,
    this.comment,
  });

  const FoodProductReport.empty()
      : this(
          id: '_empty.id',
          barcode: '_empty.barcode',
          userId: '_empty.userId',
          userName: '_empty.userName',
          incorrectImage: false,
          incorrectProductName: false,
          incorrectMacros: false,
          incorrectIngredients: false,
          incorrectLabel: false,
          isWrongProduct: false,
          doesNotExist: false,
          other: false,
          comment: '_empty.comment',
        );
  final String id;
  final String barcode;
  final String userId;
  final String userName;
  final bool incorrectImage;
  final bool incorrectProductName;
  final bool incorrectMacros;
  final bool incorrectIngredients;
  final bool incorrectLabel;
  final bool isWrongProduct;
  final bool doesNotExist;
  final bool other;
  final String? comment;

  @override
  List<Object?> get props => [
        id,
        barcode,
        userId,
        userName,
        incorrectImage,
        incorrectProductName,
        incorrectMacros,
        incorrectIngredients,
        incorrectLabel,
        isWrongProduct,
        doesNotExist,
        other,
        comment,
      ];
}
