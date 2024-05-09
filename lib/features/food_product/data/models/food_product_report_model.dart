import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';

class FoodProductReportModel extends FoodProductReport {
  const FoodProductReportModel({
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
    required super.other,
    super.comment,
  });

  const FoodProductReportModel.empty()
      : this(
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

  factory FoodProductReportModel.fromJson(String source) => FoodProductReportModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  FoodProductReportModel.fromMap(DataMap dataMap)
      : this(
          barcode: dataMap['barcode'] == null ? '' : dataMap['barcode'] as String,
          userId: dataMap['userId'] == null ? '' : dataMap['userId'] as String,
          userName: dataMap['userName'] == null ? '' : dataMap['userName'] as String,
          incorrectImage: bool.tryParse(dataMap['incorrectImage'] as String) ?? false,
          incorrectProductName: bool.tryParse(dataMap['incorrectProductName'] as String) ?? false,
          incorrectMacros: bool.tryParse(dataMap['incorrectMacros'] as String) ?? false,
          incorrectIngredients: bool.tryParse(dataMap['incorrectIngredients'] as String) ?? false,
          incorrectLabel: bool.tryParse(dataMap['incorrectLabel'] as String) ?? false,
          isWrongProduct: bool.tryParse(dataMap['isWrongProduct'] as String) ?? false,
          doesNotExist: bool.tryParse(dataMap['doesNotExist'] as String) ?? false,
          other: bool.tryParse(dataMap['other'] as String) ?? false,
          comment: dataMap['comment'] == null ? '' : dataMap['comment'] as String,
        );

  FoodProductReportModel copyWith({
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
    bool? other,
    String? comment,
  }) {
    return FoodProductReportModel(
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
      other: other ?? this.other,
      comment: comment ?? this.comment,
    );
  }

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
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
        'other': other,
        'comment': comment,
      };
}
