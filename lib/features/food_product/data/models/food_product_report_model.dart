import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';

class FoodProductReportModel extends FoodProductReport {
  const FoodProductReportModel({
    required super.barcode,
    required super.userId,
    required super.incorrectImage,
    required super.incorrectProductName,
    required super.incorrectMacros,
    required super.incorrectIngredient,
    required super.incorrectLabel,
    required super.isWrongProduct,
    required super.other,
    super.comment,
  });

  const FoodProductReportModel.empty()
      : this(
          barcode: '_empty.barcode',
          userId: 'userId',
          incorrectImage: false,
          incorrectProductName: false,
          incorrectMacros: false,
          incorrectIngredient: false,
          incorrectLabel: false,
          isWrongProduct: false,
          other: false,
          comment: '_empty.comment',
        );

  factory FoodProductReportModel.fromJson(String source) => FoodProductReportModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  FoodProductReportModel.fromMap(DataMap dataMap)
      : this(
          barcode: dataMap['barcode'] == null ? '' : dataMap['barcode'] as String,
          userId: dataMap['userId'] == null ? '' : dataMap['userId'] as String,
          incorrectImage: bool.tryParse(dataMap['incorrectImage'] as String) ?? false,
          incorrectProductName: bool.tryParse(dataMap['incorrectProductName'] as String) ?? false,
          incorrectMacros: bool.tryParse(dataMap['incorrectMacros'] as String) ?? false,
          incorrectIngredient: bool.tryParse(dataMap['incorrectIngredient'] as String) ?? false,
          incorrectLabel: bool.tryParse(dataMap['incorrectLabel'] as String) ?? false,
          isWrongProduct: bool.tryParse(dataMap['isWrongProduct'] as String) ?? false,
          other: bool.tryParse(dataMap['other'] as String) ?? false,
          comment: dataMap['comment'] == null ? '' : dataMap['comment'] as String,
        );

  FoodProductReportModel copyWith({
    String? barcode,
    String? userId,
    bool? incorrectImage,
    bool? incorrectProductName,
    bool? incorrectMacros,
    bool? incorrectIngredient,
    bool? incorrectLabel,
    bool? isWrongProduct,
    bool? other,
    String? comment,
  }) {
    return FoodProductReportModel(
      barcode: barcode ?? this.barcode,
      userId: userId ?? this.userId,
      incorrectImage: incorrectImage ?? this.incorrectImage,
      incorrectProductName: incorrectProductName ?? this.incorrectProductName,
      incorrectMacros: incorrectMacros ?? this.incorrectMacros,
      incorrectIngredient: incorrectIngredient ?? this.incorrectIngredient,
      incorrectLabel: incorrectLabel ?? this.incorrectLabel,
      isWrongProduct: isWrongProduct ?? this.isWrongProduct,
      other: other ?? this.other,
    );
  }

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'barcode': barcode,
        'userId': userId,
        'incorrectImage': incorrectImage,
        'incorrectProductName': incorrectProductName,
        'incorrectMacros': incorrectMacros,
        'incorrectIngredient': incorrectIngredient,
        'incorrectLabel': incorrectLabel,
        'isWrongProduct': isWrongProduct,
        'other': other,
      };
}
