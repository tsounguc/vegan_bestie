import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';

class FoodProductReportModel extends FoodProductReport {
  const FoodProductReportModel({
    required super.id,
    required super.barcode,
    required super.userId,
    required super.userName,
    required super.incorrectImage,
    required super.incorrectProductName,
    required super.incorrectMacros,
    required super.incorrectIngredients,
    required super.incorrectLabel,
    required super.isWrongProduct,
    required super.doesNotExist,
    required super.productNameSuggestion,
    required super.macrosSuggestion,
    required super.ingredientsSuggestion,
    required super.labelSuggestion,
    required super.productDescription,
    super.comment,
  });

  const FoodProductReportModel.empty()
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

  factory FoodProductReportModel.fromJson(String source) => FoodProductReportModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  FoodProductReportModel.fromMap(DataMap dataMap)
      : this(
          id: dataMap['id'] == null ? '' : dataMap['id'] as String,
          barcode: dataMap['barcode'] == null ? '' : dataMap['barcode'] as String,
          userId: dataMap['userId'] == null ? '' : dataMap['userId'] as String,
          userName: dataMap['userName'] == null ? '' : dataMap['userName'] as String,
          incorrectImage: dataMap['incorrectImage'] as bool,
          incorrectProductName: dataMap['incorrectProductName'] as bool,
          productNameSuggestion:
              dataMap['productNameSuggestion'] == null ? '' : dataMap['productNameSuggestion'] as String,
          incorrectMacros: dataMap['incorrectMacros'] as bool,
          macrosSuggestion: dataMap['macrosSuggestion'] == null ? '' : dataMap['macrosSuggestion'] as String,
          incorrectIngredients: dataMap['incorrectIngredients'] as bool,
          ingredientsSuggestion:
              dataMap['ingredientsSuggestion'] == null ? '' : dataMap['ingredientsSuggestion'] as String,
          incorrectLabel: dataMap['incorrectLabel'] as bool,
          labelSuggestion: dataMap['labelSuggestion'] == null ? '' : dataMap['labelSuggestion'] as String,
          isWrongProduct: dataMap['isWrongProduct'] as bool,
          productDescription: dataMap['productDescription'] == null ? '' : dataMap['productDescription'] as String,
          doesNotExist: dataMap['doesNotExist'] as bool,
          comment: dataMap['comment'] == null ? '' : dataMap['comment'] as String,
        );

  FoodProductReportModel copyWith({
    String? id,
    String? barcode,
    String? userId,
    String? userName,
    bool? incorrectImage,
    bool? incorrectProductName,
    bool? incorrectMacros,
    bool? incorrectIngredients,
    bool? incorrectLabel,
    bool? isWrongProduct,
    bool? doesNotExist,
    String? comment,
    String? productNameSuggestion,
    String? macrosSuggestion,
    String? ingredientsSuggestion,
    String? labelSuggestion,
    String? productDescription,
  }) {
    return FoodProductReportModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      incorrectImage: incorrectImage ?? this.incorrectImage,
      incorrectProductName: incorrectProductName ?? this.incorrectProductName,
      incorrectMacros: incorrectMacros ?? this.incorrectMacros,
      incorrectIngredients: incorrectIngredients ?? this.incorrectIngredients,
      incorrectLabel: incorrectLabel ?? this.incorrectLabel,
      isWrongProduct: isWrongProduct ?? this.isWrongProduct,
      doesNotExist: doesNotExist ?? this.doesNotExist,
      productNameSuggestion: productNameSuggestion ?? this.productNameSuggestion,
      macrosSuggestion: macrosSuggestion ?? this.macrosSuggestion,
      ingredientsSuggestion: ingredientsSuggestion ?? this.ingredientsSuggestion,
      labelSuggestion: labelSuggestion ?? this.labelSuggestion,
      productDescription: productDescription ?? this.productDescription,
      comment: comment ?? this.comment,
    );
  }

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'id': id,
        'barcode': barcode,
        'userId': userId,
        'userName': userName,
        'incorrectImage': incorrectImage,
        'incorrectProductName': incorrectProductName,
        'incorrectMacros': incorrectMacros,
        'incorrectIngredients': incorrectIngredients,
        'incorrectLabel': incorrectLabel,
        'isWrongProduct': isWrongProduct,
        'doesNotExist': doesNotExist,
        'comment': comment,
        'productNameSuggestion': productNameSuggestion,
        'macrosSuggestion': macrosSuggestion,
        'ingredientsSuggestion': ingredientsSuggestion,
        'labelSuggestion': labelSuggestion,
        'productDescription': productDescription,
      };
}
