class SearchProductEntity {
  String? code;
  String? productName;
  List<SearchIngredientEntity>? ingredients;
  String? ingredientsText;
  String? labels;
  String? imageFrontUrl;
  double? proteins;
  double? proteins100G;
  String? proteinsUnit;
  double? proteinsValue;
  double? carbohydrates;
  double? carbohydrates100G;
  String? carbohydratesUnit;
  double? carbohydratesValue;
  double? fat;
  double? fat100G;
  String? fatUnit;
  double? fatValue;

  SearchProductEntity({
    this.code,
    this.productName,
    this.ingredients,
    this.ingredientsText,
    this.labels,
    this.imageFrontUrl,
    this.proteins,
    this.proteins100G,
    this.proteinsUnit,
    this.proteinsValue,
    this.carbohydrates,
    this.carbohydrates100G,
    this.carbohydratesUnit,
    this.carbohydratesValue,
    this.fat,
    this.fat100G,
    this.fatUnit,
    this.fatValue,
  });
}

class SearchIngredientEntity {
  SearchIngredientEntity({
    required this.id,
    required this.percentEstimate,
    required this.percentMax,
    required this.percentMin,
    required this.text,
    required this.vegan,
    required this.vegetarian,
  });

  String? id;
  dynamic percentEstimate;
  dynamic percentMax;
  dynamic percentMin;
  String? text;
  String? vegan;
  String? vegetarian;
}
