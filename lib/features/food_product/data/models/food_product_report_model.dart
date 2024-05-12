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
    required super.other,
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
          id: dataMap['id'] == null ? '' : dataMap['id'] as String,
          barcode: dataMap['barcode'] == null ? '' : dataMap['barcode'] as String,
          userId: dataMap['userId'] == null ? '' : dataMap['userId'] as String,
          userName: dataMap['userName'] == null ? '' : dataMap['userName'] as String,
          incorrectImage: dataMap['incorrectImage'] as bool,
          incorrectProductName: dataMap['incorrectProductName'] as bool,
          incorrectMacros: dataMap['incorrectMacros'] as bool,
          incorrectIngredients: dataMap['incorrectIngredients'] as bool,
          incorrectLabel: dataMap['incorrectLabel'] as bool,
          isWrongProduct: dataMap['isWrongProduct'] as bool,
          doesNotExist: dataMap['doesNotExist'] as bool,
          other: dataMap['other'] as bool,
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
    bool? other,
    String? comment,
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
      other: other ?? this.other,
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
        'other': other,
        'comment': comment,
      };
}
