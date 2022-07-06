// To parse this JSON data, do
//
//     final productInfoModel = productInfoModelFromJson(jsonString);

import 'dart:convert';

// ProductInfoModel productInfoModelFromJson(String str) => ProductInfoModel.fromJson(json.decode(str));

// String productInfoModelToJson(ProductInfoModel data) => json.encode(data.toJson());

class ProductInfoModel {
  String? _code;
  _Product? _product;
  int? _status;
  String? _status_verbose;

  // factory
  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    _code = json["code"];
    _product = _Product(json["product"]);
    _status = json["status"];
    _status_verbose = json["status_verbose"];
  }

  String? get code => _code;

  _Product? get product => _product;

  int? get status => _status;

  String? get status_verbose => _status_verbose;
}

class _Product {
  String? _id;
  String? _code;
  String? _productId;
  String? _imageFrontSmallUrl;
  String? _imageFrontThumbUrl;
  String? _imageFrontUrl;
  String? _imageIngredientsSmallUrl;
  String? _imageIngredientsThumbUrl;
  String? _imageIngredientsUrl;
  String? _imageNutritionSmallUrl;
  String? _imageNutritionThumbUrl;
  String? _imageNutritionUrl;
  String? _imageSmallUrl;
  String? _imageThumbUrl;
  String? _imageUrl;
  Images? _images;
  List<String>? _informersTags;
  List<Ingredient>? _ingredients;
  String? _ingredientsText;
  String? _labels;
  String? _lang;
  Languages? _languages;
  LanguagesCodes? _languagesCodes;
  String? _origins;
  String? _productName;
  String? _productNameEn;
  _Product(product) {
    _id = product['_id'];
    _code = product['code'];
    _productId = product['_productId'];
    _imageFrontSmallUrl = product['_code'];
    _imageFrontThumbUrl = product['_code'];
    _imageFrontUrl = product['_code'];
    _imageIngredientsSmallUrl = product['_code'];
    _imageIngredientsThumbUrl = product['_code'];
    _imageIngredientsUrl = product['_code'];
    _imageNutritionSmallUrl = product['_code'];
    _imageNutritionThumbUrl = product['_code'];
    _imageNutritionUrl = product['_code'];
    _imageSmallUrl = product['_code'];
    _imageThumbUrl = product['_code'];
    _imageUrl = product['_code'];
    _images = product['_code'];
    _informersTags = product['_code'];
    _ingredients = product['_code'];
    _labels = product['_code'];
    _lang = product['_code'];
    _languages = product['_code'];
    _languagesCodes = product['_code'];
    _origins = product['_code'];
    _productName = product['_code'];
    _productNameEn = product['_code'];
  }
  String? get id => _id;

  String? get code => _code;

  String? get productId => _productId;

  String? get imageFrontSmallUrl => _imageFrontSmallUrl;

  String? get imageFrontThumbUrl => _imageFrontThumbUrl;

  String? get imageFrontUrl => _imageFrontUrl;

  String? get imageIngredientsSmallUrl => _imageIngredientsSmallUrl;

  String? get imageIngredientsThumbUrl => _imageIngredientsThumbUrl;

  String? get imageIngredientsUrl => _imageIngredientsUrl;

  String? get imageNutritionSmallUrl => _imageNutritionSmallUrl;

  String? get imageNutritionThumbUrl => _imageNutritionThumbUrl;

  String? get imageNutritionUrl => _imageNutritionUrl;

  String? get imageSmallUrl => _imageSmallUrl;

  String? get imageThumbUrl => _imageThumbUrl;

  String? get imageUrl => _imageUrl;

  Images? get images => _images;

  List<String>? get informersTags => _informersTags;

  List<Ingredient>? get ingredients => _ingredients;

  String? get ingredientsText => _ingredientsText;

  String? get labels => _labels;

  String? get lang => _lang;

  Languages? get languages => _languages;

  LanguagesCodes? get languagesCodes => _languagesCodes;

  String? get origins => _origins;

  String? get productName => _productName;

  String? get productNameEn => _productNameEn;

}

class CategoriesProperties {
  CategoriesProperties();

  factory CategoriesProperties.fromJson(Map<String, dynamic> json) => CategoriesProperties();

  Map<String, dynamic> toJson() => {};
}

class EcoscoreData {
  EcoscoreData({
    this.adjustments,
    this.agribalyse,
    this.missing,
    this.missingAgribalyseMatchWarning,
    this.status,
  });

  Adjustments? adjustments;
  Agribalyse? agribalyse;
  Missing? missing;
  int? missingAgribalyseMatchWarning;
  String? status;

  factory EcoscoreData.fromJson(Map<String, dynamic> json) => EcoscoreData(
        adjustments: Adjustments.fromJson(json["adjustments"]),
        agribalyse: Agribalyse.fromJson(json["agribalyse"]),
        missing: Missing.fromJson(json["missing"]),
        missingAgribalyseMatchWarning: json["missing_agribalyse_match_warning"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "adjustments": adjustments!.toJson(),
        "agribalyse": agribalyse!.toJson(),
        "missing": missing!.toJson(),
        "missing_agribalyse_match_warning": missingAgribalyseMatchWarning,
        "status": status,
      };
}

class Adjustments {
  Adjustments({
    this.originsOfIngredients,
    this.packaging,
    this.productionSystem,
    this.threatenedSpecies,
  });

  OriginsOfIngredients? originsOfIngredients;
  Packaging? packaging;
  ProductionSystem? productionSystem;
  CategoriesProperties? threatenedSpecies;

  factory Adjustments.fromJson(Map<String, dynamic> json) => Adjustments(
        originsOfIngredients: OriginsOfIngredients.fromJson(json["origins_of_ingredients"]),
        packaging: Packaging.fromJson(json["packaging"]),
        productionSystem: ProductionSystem.fromJson(json["production_system"]),
        threatenedSpecies: CategoriesProperties.fromJson(json["threatened_species"]),
      );

  Map<String, dynamic> toJson() => {
        "origins_of_ingredients": originsOfIngredients!.toJson(),
        "packaging": packaging!.toJson(),
        "production_system": productionSystem!.toJson(),
        "threatened_species": threatenedSpecies!.toJson(),
      };
}

class OriginsOfIngredients {
  OriginsOfIngredients({
    this.aggregatedOrigins,
    this.epiScore,
    this.epiValue,
    this.originsFromOriginsField,
    this.transportationScores,
    this.transportationValues,
    this.values,
    this.warning,
  });

  List<AggregatedOrigin>? aggregatedOrigins;
  int? epiScore;
  int? epiValue;
  List<String>? originsFromOriginsField;
  Map<String, int>? transportationScores;
  Map<String, int>? transportationValues;
  Map<String, int>? values;
  String? warning;

  factory OriginsOfIngredients.fromJson(Map<String, dynamic> json) => OriginsOfIngredients(
        aggregatedOrigins:
            List<AggregatedOrigin>.from(json["aggregated_origins"].map((x) => AggregatedOrigin.fromJson(x))),
        epiScore: json["epi_score"],
        epiValue: json["epi_value"],
        originsFromOriginsField: List<String>.from(json["origins_from_origins_field"].map((x) => x)),
        transportationScores: Map.from(json["transportation_scores"]).map((k, v) => MapEntry<String, int>(k, v)),
        transportationValues: Map.from(json["transportation_values"]).map((k, v) => MapEntry<String, int>(k, v)),
        values: Map.from(json["values"]).map((k, v) => MapEntry<String, int>(k, v)),
        warning: json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "aggregated_origins": List<dynamic>.from(aggregatedOrigins!.map((x) => x.toJson())),
        "epi_score": epiScore,
        "epi_value": epiValue,
        "origins_from_origins_field": List<dynamic>.from(originsFromOriginsField!.map((x) => x)),
        "transportation_scores": Map.from(transportationScores!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "transportation_values": Map.from(transportationValues!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "values": Map.from(values!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "warning": warning,
      };
}

class AggregatedOrigin {
  AggregatedOrigin({
    this.origin,
    this.percent,
  });

  String? origin;
  int? percent;

  factory AggregatedOrigin.fromJson(Map<String, dynamic> json) => AggregatedOrigin(
        origin: json["origin"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "percent": percent,
      };
}

class Packaging {
  Packaging({
    this.nonRecyclableAndNonBiodegradableMaterials,
    this.value,
    this.warning,
  });

  int? nonRecyclableAndNonBiodegradableMaterials;
  int? value;
  String? warning;

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
        nonRecyclableAndNonBiodegradableMaterials: json["non_recyclable_and_non_biodegradable_materials"],
        value: json["value"],
        warning: json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "non_recyclable_and_non_biodegradable_materials": nonRecyclableAndNonBiodegradableMaterials,
        "value": value,
        "warning": warning,
      };
}

class ProductionSystem {
  ProductionSystem({
    this.labels,
    this.value,
    this.warning,
  });

  List<dynamic>? labels;
  int? value;
  String? warning;

  factory ProductionSystem.fromJson(Map<String, dynamic> json) => ProductionSystem(
        labels: List<dynamic>.from(json["labels"].map((x) => x)),
        value: json["value"],
        warning: json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "labels": List<dynamic>.from(labels!.map((x) => x)),
        "value": value,
        "warning": warning,
      };
}

class Agribalyse {
  Agribalyse({
    this.warning,
  });

  String? warning;

  factory Agribalyse.fromJson(Map<String, dynamic> json) => Agribalyse(
        warning: json["warning"],
      );

  Map<String, dynamic> toJson() => {
        "warning": warning,
      };
}

class Missing {
  Missing({
    this.categories,
    this.labels,
    this.origins,
    this.packagings,
  });

  int? categories;
  int? labels;
  int? origins;
  int? packagings;

  factory Missing.fromJson(Map<String, dynamic> json) => Missing(
        categories: json["categories"],
        labels: json["labels"],
        origins: json["origins"],
        packagings: json["packagings"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "labels": labels,
        "origins": origins,
        "packagings": packagings,
      };
}

class EcoscoreExtendedData {
  EcoscoreExtendedData({
    this.error,
  });

  String? error;

  factory EcoscoreExtendedData.fromJson(Map<String, dynamic> json) => EcoscoreExtendedData(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}

class Images {
  Images({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.frontEn,
    this.ingredientsEn,
    this.nutritionEn,
  });

  The1? the1;
  The1? the2;
  The1? the3;
  The1? the4;
  The1? the5;
  En? frontEn;
  En? ingredientsEn;
  En? nutritionEn;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        the1: The1.fromJson(json["1"]),
        the2: The1.fromJson(json["2"]),
        the3: The1.fromJson(json["3"]),
        the4: The1.fromJson(json["4"]),
        the5: The1.fromJson(json["5"]),
        frontEn: En.fromJson(json["front_en"]),
        ingredientsEn: En.fromJson(json["ingredients_en"]),
        nutritionEn: En.fromJson(json["nutrition_en"]),
      );

  Map<String, dynamic> toJson() => {
        "1": the1!.toJson(),
        "2": the2!.toJson(),
        "3": the3!.toJson(),
        "4": the4!.toJson(),
        "5": the5!.toJson(),
        "front_en": frontEn!.toJson(),
        "ingredients_en": ingredientsEn!.toJson(),
        "nutrition_en": nutritionEn!.toJson(),
      };
}

class En {
  En({
    this.angle,
    this.geometry,
    this.imgid,
    this.normalize,
    this.rev,
    this.sizes,
    this.whiteMagic,
    this.x1,
    this.x2,
    this.y1,
    this.y2,
  });

  int? angle;
  String? geometry;
  String? imgid;
  dynamic normalize;
  String? rev;
  Sizes? sizes;
  dynamic whiteMagic;
  String? x1;
  String? x2;
  String? y1;
  String? y2;

  factory En.fromJson(Map<String, dynamic> json) => En(
        angle: json["angle"],
        geometry: json["geometry"],
        imgid: json["imgid"],
        normalize: json["normalize"],
        rev: json["rev"],
        sizes: Sizes.fromJson(json["sizes"]),
        whiteMagic: json["white_magic"],
        x1: json["x1"],
        x2: json["x2"],
        y1: json["y1"],
        y2: json["y2"],
      );

  Map<String, dynamic> toJson() => {
        "angle": angle,
        "geometry": geometry,
        "imgid": imgid,
        "normalize": normalize,
        "rev": rev,
        "sizes": sizes!.toJson(),
        "white_magic": whiteMagic,
        "x1": x1,
        "x2": x2,
        "y1": y1,
        "y2": y2,
      };
}

class Sizes {
  Sizes({
    this.the100,
    this.the400,
    this.full,
    this.the200,
  });

  The100? the100;
  The100? the400;
  The100? full;
  The100? the200;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        the100: The100.fromJson(json["100"]),
        the400: The100.fromJson(json["400"]),
        full: The100.fromJson(json["full"]),
        the200: json["200"] == null ? null : The100.fromJson(json["200"]),
      );

  Map<String, dynamic> toJson() => {
        "100": the100!.toJson(),
        "400": the400!.toJson(),
        "full": full!.toJson(),
        "200": the200 == null ? null : the200!.toJson(),
      };
}

class The100 {
  The100({
    this.h,
    this.w,
  });

  int? h;
  int? w;

  factory The100.fromJson(Map<String, dynamic> json) => The100(
        h: json["h"],
        w: json["w"],
      );

  Map<String, dynamic> toJson() => {
        "h": h,
        "w": w,
      };
}

class The1 {
  The1({
    this.sizes,
    this.uploadedT,
    this.uploader,
  });

  Sizes? sizes;
  int? uploadedT;
  String? uploader;

  factory The1.fromJson(Map<String, dynamic> json) => The1(
        sizes: Sizes.fromJson(json["sizes"]),
        uploadedT: json["uploaded_t"],
        uploader: json["uploader"],
      );

  Map<String, dynamic> toJson() => {
        "sizes": sizes!.toJson(),
        "uploaded_t": uploadedT,
        "uploader": uploader,
      };
}

class Ingredient {
  Ingredient({
    this.id,
    this.percentEstimate,
    this.percentMax,
    this.percentMin,
    this.text,
    this.vegan,
    this.vegetarian,
  });

  String? id;
  double? percentEstimate;
  double? percentMax;
  int? percentMin;
  String? text;
  String? vegan;
  String? vegetarian;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        percentEstimate: json["percent_estimate"].toDouble(),
        percentMax: json["percent_max"].toDouble(),
        percentMin: json["percent_min"],
        text: json["text"],
        vegan: json["vegan"] == null ? null : json["vegan"],
        vegetarian: json["vegetarian"] == null ? null : json["vegetarian"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "percent_estimate": percentEstimate,
        "percent_max": percentMax,
        "percent_min": percentMin,
        "text": text,
        "vegan": vegan == null ? null : vegan,
        "vegetarian": vegetarian == null ? null : vegetarian,
      };
}

class IngredientsAnalysis {
  IngredientsAnalysis({
    this.enVeganStatusUnknown,
    this.enVegetarianStatusUnknown,
  });

  List<String>? enVeganStatusUnknown;
  List<String>? enVegetarianStatusUnknown;

  factory IngredientsAnalysis.fromJson(Map<String, dynamic> json) => IngredientsAnalysis(
        enVeganStatusUnknown: List<String>.from(json["en:vegan-status-unknown"].map((x) => x)),
        enVegetarianStatusUnknown: List<String>.from(json["en:vegetarian-status-unknown"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "en:vegan-status-unknown": List<dynamic>.from(enVeganStatusUnknown!.map((x) => x)),
        "en:vegetarian-status-unknown": List<dynamic>.from(enVegetarianStatusUnknown!.map((x) => x)),
      };
}

class Languages {
  Languages({
    this.enEnglish,
  });

  int? enEnglish;

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        enEnglish: json["en:english"],
      );

  Map<String, dynamic> toJson() => {
        "en:english": enEnglish,
      };
}

class LanguagesCodes {
  LanguagesCodes({
    this.en,
  });

  int? en;

  factory LanguagesCodes.fromJson(Map<String, dynamic> json) => LanguagesCodes(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Nutriments {
  Nutriments({
    this.carbohydrates,
    this.carbohydrates100G,
    this.carbohydratesUnit,
    this.carbohydratesValue,
    this.energy,
    this.energyKcal,
    this.energyKcal100G,
    this.energyKcalUnit,
    this.energyKcalValue,
    this.energy100G,
    this.energyUnit,
    this.energyValue,
    this.fat,
    this.fat100G,
    this.fatUnit,
    this.fatValue,
    this.fruitsVegetablesNutsEstimateFromIngredients100G,
    this.fruitsVegetablesNutsEstimateFromIngredientsServing,
    this.novaGroup,
    this.novaGroup100G,
    this.novaGroupServing,
    this.proteins,
    this.proteins100G,
    this.proteinsUnit,
    this.proteinsValue,
    this.salt,
    this.salt100G,
    this.saltUnit,
    this.saltValue,
    this.saturatedFat,
    this.saturatedFat100G,
    this.saturatedFatUnit,
    this.saturatedFatValue,
    this.sodium,
    this.sodium100G,
    this.sodiumUnit,
    this.sodiumValue,
    this.sugars,
    this.sugars100G,
    this.sugarsUnit,
    this.sugarsValue,
  });

  double? carbohydrates;
  double? carbohydrates100G;
  String? carbohydratesUnit;
  double? carbohydratesValue;
  int? energy;
  double? energyKcal;
  double? energyKcal100G;
  String? energyKcalUnit;
  double? energyKcalValue;
  int? energy100G;
  String? energyUnit;
  double? energyValue;
  int? fat;
  int? fat100G;
  String? fatUnit;
  int? fatValue;
  int? fruitsVegetablesNutsEstimateFromIngredients100G;
  int? fruitsVegetablesNutsEstimateFromIngredientsServing;
  int? novaGroup;
  int? novaGroup100G;
  int? novaGroupServing;
  int? proteins;
  int? proteins100G;
  String? proteinsUnit;
  int? proteinsValue;
  int? salt;
  int? salt100G;
  String? saltUnit;
  int? saltValue;
  int? saturatedFat;
  int? saturatedFat100G;
  String? saturatedFatUnit;
  int? saturatedFatValue;
  int? sodium;
  int? sodium100G;
  String? sodiumUnit;
  int? sodiumValue;
  int? sugars;
  int? sugars100G;
  String? sugarsUnit;
  int? sugarsValue;

  factory Nutriments.fromJson(Map<String, dynamic> json) => Nutriments(
        carbohydrates: json["carbohydrates"].toDouble(),
        carbohydrates100G: json["carbohydrates_100g"].toDouble(),
        carbohydratesUnit: json["carbohydrates_unit"],
        carbohydratesValue: json["carbohydrates_value"].toDouble(),
        energy: json["energy"],
        energyKcal: json["energy-kcal"].toDouble(),
        energyKcal100G: json["energy-kcal_100g"].toDouble(),
        energyKcalUnit: json["energy-kcal_unit"],
        energyKcalValue: json["energy-kcal_value"].toDouble(),
        energy100G: json["energy_100g"],
        energyUnit: json["energy_unit"],
        energyValue: json["energy_value"].toDouble(),
        fat: json["fat"],
        fat100G: json["fat_100g"],
        fatUnit: json["fat_unit"],
        fatValue: json["fat_value"],
        fruitsVegetablesNutsEstimateFromIngredients100G:
            json["fruits-vegetables-nuts-estimate-from-ingredients_100g"],
        fruitsVegetablesNutsEstimateFromIngredientsServing:
            json["fruits-vegetables-nuts-estimate-from-ingredients_serving"],
        novaGroup: json["nova-group"],
        novaGroup100G: json["nova-group_100g"],
        novaGroupServing: json["nova-group_serving"],
        proteins: json["proteins"],
        proteins100G: json["proteins_100g"],
        proteinsUnit: json["proteins_unit"],
        proteinsValue: json["proteins_value"],
        salt: json["salt"],
        salt100G: json["salt_100g"],
        saltUnit: json["salt_unit"],
        saltValue: json["salt_value"],
        saturatedFat: json["saturated-fat"],
        saturatedFat100G: json["saturated-fat_100g"],
        saturatedFatUnit: json["saturated-fat_unit"],
        saturatedFatValue: json["saturated-fat_value"],
        sodium: json["sodium"],
        sodium100G: json["sodium_100g"],
        sodiumUnit: json["sodium_unit"],
        sodiumValue: json["sodium_value"],
        sugars: json["sugars"],
        sugars100G: json["sugars_100g"],
        sugarsUnit: json["sugars_unit"],
        sugarsValue: json["sugars_value"],
      );

  Map<String, dynamic> toJson() => {
        "carbohydrates": carbohydrates,
        "carbohydrates_100g": carbohydrates100G,
        "carbohydrates_unit": carbohydratesUnit,
        "carbohydrates_value": carbohydratesValue,
        "energy": energy,
        "energy-kcal": energyKcal,
        "energy-kcal_100g": energyKcal100G,
        "energy-kcal_unit": energyKcalUnit,
        "energy-kcal_value": energyKcalValue,
        "energy_100g": energy100G,
        "energy_unit": energyUnit,
        "energy_value": energyValue,
        "fat": fat,
        "fat_100g": fat100G,
        "fat_unit": fatUnit,
        "fat_value": fatValue,
        "fruits-vegetables-nuts-estimate-from-ingredients_100g": fruitsVegetablesNutsEstimateFromIngredients100G,
        "fruits-vegetables-nuts-estimate-from-ingredients_serving":
            fruitsVegetablesNutsEstimateFromIngredientsServing,
        "nova-group": novaGroup,
        "nova-group_100g": novaGroup100G,
        "nova-group_serving": novaGroupServing,
        "proteins": proteins,
        "proteins_100g": proteins100G,
        "proteins_unit": proteinsUnit,
        "proteins_value": proteinsValue,
        "salt": salt,
        "salt_100g": salt100G,
        "salt_unit": saltUnit,
        "salt_value": saltValue,
        "saturated-fat": saturatedFat,
        "saturated-fat_100g": saturatedFat100G,
        "saturated-fat_unit": saturatedFatUnit,
        "saturated-fat_value": saturatedFatValue,
        "sodium": sodium,
        "sodium_100g": sodium100G,
        "sodium_unit": sodiumUnit,
        "sodium_value": sodiumValue,
        "sugars": sugars,
        "sugars_100g": sugars100G,
        "sugars_unit": sugarsUnit,
        "sugars_value": sugarsValue,
      };
}

class SelectedImages {
  SelectedImages({
    this.front,
    this.ingredients,
    this.nutrition,
  });

  Front? front;
  Front? ingredients;
  Front? nutrition;

  factory SelectedImages.fromJson(Map<String, dynamic> json) => SelectedImages(
        front: Front.fromJson(json["front"]),
        ingredients: Front.fromJson(json["ingredients"]),
        nutrition: Front.fromJson(json["nutrition"]),
      );

  Map<String, dynamic> toJson() => {
        "front": front!.toJson(),
        "ingredients": ingredients!.toJson(),
        "nutrition": nutrition!.toJson(),
      };
}

class Front {
  Front({
    this.display,
    this.small,
    this.thumb,
  });

  Display? display;
  Display? small;
  Display? thumb;

  factory Front.fromJson(Map<String, dynamic> json) => Front(
        display: Display.fromJson(json["display"]),
        small: Display.fromJson(json["small"]),
        thumb: Display.fromJson(json["thumb"]),
      );

  Map<String, dynamic> toJson() => {
        "display": display!.toJson(),
        "small": small!.toJson(),
        "thumb": thumb!.toJson(),
      };
}

class Display {
  Display({
    this.en,
  });

  String? en;

  factory Display.fromJson(Map<String, dynamic> json) => Display(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}
