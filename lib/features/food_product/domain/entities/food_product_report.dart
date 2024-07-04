import 'package:equatable/equatable.dart';

class FoodProductReport extends Equatable {
  const FoodProductReport({
    required this.id,
    required this.barcode,
    required this.userId,
    required this.userName,
    required this.incorrectImage,
    required this.incorrectProductName,
    required this.productNameSuggestion,
    required this.incorrectMacros,
    required this.macrosSuggestion,
    required this.incorrectIngredients,
    required this.ingredientsSuggestion,
    required this.incorrectLabel,
    required this.labelSuggestion,
    required this.isWrongProduct,
    required this.productDescription,
    required this.doesNotExist,
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
          productNameSuggestion: '_empty.productName',
          incorrectMacros: false,
          macrosSuggestion: '_empty.macros',
          incorrectIngredients: false,
          ingredientsSuggestion: '_empty.ingredients',
          incorrectLabel: false,
          labelSuggestion: '_empty.label',
          isWrongProduct: false,
          productDescription: 'empty.productDescription',
          doesNotExist: false,
          comment: '_empty.comment',
        );
  final String id;
  final String barcode;
  final String userId;
  final String userName;
  final bool incorrectImage;

  final bool incorrectProductName;
  final String productNameSuggestion;
  final bool incorrectMacros;
  final String macrosSuggestion;
  final bool incorrectIngredients;
  final String ingredientsSuggestion;
  final bool incorrectLabel;
  final String labelSuggestion;
  final bool isWrongProduct;
  final String productDescription;
  final bool doesNotExist;
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
        comment,
      ];
}
