class CategoriesProperties {
  CategoriesProperties();

  factory CategoriesProperties.fromJson(Map<String, dynamic>? json) => CategoriesProperties();

  Map<String, dynamic> toJson() => {};
}

class EcoscoreData {
  EcoscoreData({
    required this.adjustments,
    required this.agribalyse,
    required this.missing,
    required this.missingAgribalyseMatchWarning,
    required this.status,
  });

  Adjustments? adjustments;
  Agribalyse? agribalyse;
  Missing? missing;
  int? missingAgribalyseMatchWarning;
  String? status;

  factory EcoscoreData.fromJson(Map<String, dynamic>? json) => EcoscoreData(
    adjustments: Adjustments.fromJson(json?["adjustments"]),
    agribalyse: Agribalyse.fromJson(json?["agribalyse"]),
    missing: Missing.fromJson(json?["missing"]),
    missingAgribalyseMatchWarning: json?["missing_agribalyse_match_warning"],
    status: json?["status"],
  );

  Map<String, dynamic> toJson() => {
    "adjustments": adjustments!.toJson(),
    "agribalyse": agribalyse!.toJson(),
    "missing": missing!.toJson(),
    "missing_agribalyse_match_warning": missingAgribalyseMatchWarning!,
    "status": status!,
  };
}

class Adjustments {
  Adjustments({
    // required this.originsOfIngredients,
    required this.packaging,
    required this.productionSystem,
    required this.threatenedSpecies,
  });

  // OriginsOfIngredients? originsOfIngredients;
  Packaging? packaging;
  ProductionSystem? productionSystem;
  CategoriesProperties? threatenedSpecies;

  factory Adjustments.fromJson(Map<String, dynamic>? json) => Adjustments(
    // originsOfIngredients: OriginsOfIngredients.fromJson(json?["origins_of_ingredients"]),
    packaging: Packaging.fromJson(json?["packaging"]),
    productionSystem: ProductionSystem.fromJson(json?["production_system"]),
    threatenedSpecies: CategoriesProperties.fromJson(json?["threatened_species"]),
  );

  Map<String, dynamic> toJson() => {
    // "origins_of_ingredients": originsOfIngredients!.toJson(),
    "packaging": packaging!.toJson(),
    "production_system": productionSystem!.toJson(),
    "threatened_species": threatenedSpecies!.toJson(),
  };
}

class OriginsOfIngredients {
  OriginsOfIngredients({
    required this.aggregatedOrigins,
    required this.epiScore,
    required this.epiValue,
    required this.originsFromOriginsField,
    required this.transportationScores,
    required this.transportationValues,
    required this.values,
    required this.warning,
  });

  List<AggregatedOrigin>? aggregatedOrigins;
  double? epiScore;
  double? epiValue;
  List<String>? originsFromOriginsField;
  Map<String?, int?> transportationScores;
  Map<String?, int?> transportationValues;
  Map<String?, int?> values;
  String? warning;

  factory OriginsOfIngredients.fromJson(Map<String, dynamic>? json) => OriginsOfIngredients(
    aggregatedOrigins: json?["aggregated_origins"] != null
        ? List<AggregatedOrigin>.from(json?["aggregated_origins"].map((x) => AggregatedOrigin.fromJson(x)))
        : [],
    epiScore: json?["epi_score"]?.toDouble(),
    epiValue: json?["epi_value"]?.toDouble(),
    originsFromOriginsField: json?["origins_from_origins_field"] != null
        ? List<String>.from(json?["origins_from_origins_field"].map((x) => x))
        : [],
    transportationScores: json?["transportation_scores"] != null
        ? Map.from(json?["transportation_scores"]).map((k, v) => MapEntry<String, int>(k, v))
        : Map<String, int>(),
    transportationValues: json?["transportation_values"] != null
        ? Map.from(json?["transportation_values"]).map((k, v) => MapEntry<String, int>(k, v))
        : Map<String, int>(),
    values: json?["values"] != null
        ? Map.from(json?["values"]).map((k, v) => MapEntry<String, int>(k, v))
        : Map<String, int>(),
    warning: json?["warning"],
  );

  Map<String, dynamic> toJson() => {
    "aggregated_origins": List<dynamic>.from(aggregatedOrigins!.map((x) => x.toJson())),
    "epi_score": epiScore!,
    "epi_value": epiValue!,
    "origins_from_origins_field": List<dynamic>.from(originsFromOriginsField!.map((x) => x)),
    "transportation_scores": Map.from(transportationScores).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "transportation_values": Map.from(transportationValues).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "values": Map.from(values).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "warning": warning,
  };
}

class AggregatedOrigin {
  AggregatedOrigin({
    required this.origin,
    required this.percent,
  });

  String? origin;
  double? percent;

  factory AggregatedOrigin.fromJson(Map<String, dynamic> json) => AggregatedOrigin(
    origin: json["origin"],
    percent: json["percent"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "origin": origin!,
    "percent": percent!,
  };
}

class Packaging {
  Packaging({
    required this.nonRecyclableAndNonBiodegradableMaterials,
    required this.value,
    required this.warning,
  });

  int? nonRecyclableAndNonBiodegradableMaterials;
  double? value;
  String? warning;

  factory Packaging.fromJson(Map<String, dynamic>? json) => Packaging(
    nonRecyclableAndNonBiodegradableMaterials: json?["non_recyclable_and_non_biodegradable_materials"],
    value: json?["value"]?.toDouble(),
    warning: json?["warning"],
  );

  Map<String, dynamic> toJson() => {
    "non_recyclable_and_non_biodegradable_materials": nonRecyclableAndNonBiodegradableMaterials!,
    "value": value!,
    "warning": warning!,
  };
}

class ProductionSystem {
  ProductionSystem({
    required this.labels,
    required this.value,
    required this.warning,
  });

  List<dynamic>? labels;
  double? value;
  String? warning;

  factory ProductionSystem.fromJson(Map<String, dynamic>? json) => ProductionSystem(
    labels: json?["labels"] != null ? List<dynamic>.from(json?["labels"].map((x) => x)) : [],
    value: json?["value"]?.toDouble(),
    warning: json?["warning"],
  );

  Map<String, dynamic> toJson() => {
    "labels": List<dynamic>.from(labels!.map((x) => x)),
    "value": value!,
    "warning": warning!,
  };
}

class Agribalyse {
  Agribalyse({
    required this.warning,
  });

  String? warning;

  factory Agribalyse.fromJson(Map<String, dynamic>? json) => Agribalyse(
    warning: json?["warning"],
  );

  Map<String, dynamic> toJson() => {
    "warning": warning!,
  };
}

class Missing {
  Missing({
    required this.categories,
    required this.labels,
    required this.origins,
    required this.packagings,
  });

  int? categories;
  int? labels;
  int? origins;
  int? packagings;

  factory Missing.fromJson(Map<String, dynamic>? json) => Missing(
    categories: json?["categories"],
    labels: json?["labels"],
    origins: json?["origins"],
    packagings: json?["packagings"],
  );

  Map<String, dynamic> toJson() => {
    "categories": categories!,
    "labels": labels!,
    "origins": origins!,
    "packagings": packagings!,
  };
}

class EcoscoreExtendedData {
  EcoscoreExtendedData({
    required this.error,
  });

  String? error;

  factory EcoscoreExtendedData.fromJson(Map<String, dynamic>? json) => EcoscoreExtendedData(
    error: json?["error"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "error": error!,
  };
}

class Images {
  Images({
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.frontEn,
    required this.ingredientsEn,
    required this.nutritionEn,
  });

  The1? the1;
  The1? the2;
  The1? the3;
  The1? the4;
  The1? the5;
  En? frontEn;
  En? ingredientsEn;
  En? nutritionEn;

  factory Images.fromJson(Map<String, dynamic>? json) => Images(
    the1: The1.fromJson(json?["1"]),
    the2: The1.fromJson(json?["2"]),
    the3: The1.fromJson(json?["3"]),
    the4: The1.fromJson(json?["4"]),
    the5: The1.fromJson(json?["5"]),
    frontEn: En.fromJson(json?["front_en"]),
    ingredientsEn: En.fromJson(json?["ingredients_en"]),
    nutritionEn: En.fromJson(json?["nutrition_en"]),
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
    required this.angle,
    required this.geometry,
    required this.imgid,
    this.normalize,
    required this.rev,
    required this.sizes,
    this.whiteMagic,
    required this.x1,
    required this.x2,
    required this.y1,
    required this.y2,
  });

  dynamic angle;
  String? geometry;
  dynamic imgid;
  dynamic normalize;
  dynamic rev;
  Sizes? sizes;
  dynamic whiteMagic;
  dynamic x1;
  dynamic x2;
  dynamic y1;
  dynamic y2;

  factory En.fromJson(Map<String, dynamic>? json) => En(
    angle: json?["angle"],
    geometry: json?["geometry"],
    imgid: json?["imgid"],
    normalize: json?["normalize"],
    rev: json?["rev"],
    sizes: Sizes.fromJson(json?["sizes"]),
    whiteMagic: json?["white_magic"],
    x1: json?["x1"],
    x2: json?["x2"],
    y1: json?["y1"],
    y2: json?["y2"],
  );

  Map<String, dynamic> toJson() => {
    "angle": angle!,
    "geometry": geometry!,
    "imgid": imgid!,
    "normalize": normalize!,
    "rev": rev!,
    "sizes": sizes!.toJson(),
    "white_magic": whiteMagic!,
    "x1": x1!,
    "x2": x2!,
    "y1": y1!,
    "y2": y2!,
  };
}

class Sizes {
  Sizes({
    required this.the100,
    required this.the400,
    required this.full,
    required this.the200,
  });

  The100? the100;
  The100? the400;
  The100? full;
  The100? the200;

  factory Sizes.fromJson(Map<String, dynamic>? json) => Sizes(
    the100: The100.fromJson(json?["100"]),
    the400: The100.fromJson(json?["400"]),
    full: The100.fromJson(json?["full"]),
    the200: json?["200"] == null ? null : The100.fromJson(json?["200"]),
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
    required this.h,
    required this.w,
  });

  double? h;
  double? w;

  factory The100.fromJson(Map<String, dynamic>? json) => The100(
    h: json?["h"]?.toDouble(),
    w: json?["w"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "h": h!,
    "w": w!,
  };
}

class The1 {
  The1({
    required this.sizes,
    required this.uploadedT,
    required this.uploader,
  });

  Sizes? sizes;
  dynamic uploadedT;
  String? uploader;

  factory The1.fromJson(Map<String, dynamic>? json) => The1(
    sizes: Sizes.fromJson(json?["sizes"]),
    uploadedT: json?["uploaded_t"],
    uploader: json?["uploader"],
  );

  Map<String, dynamic> toJson() => {
    "sizes": sizes!.toJson(),
    "uploaded_t": uploadedT!,
    "uploader": uploader!,
  };
}

class Ingredient {
  Ingredient({
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

  factory Ingredient.fromJson(Map<String, dynamic>? json) => Ingredient(
    id: json?["id"],
    percentEstimate: json?["percent_estimate"],
    percentMax: json?["percent_max"],
    percentMin: json?["percent_min"],
    text: json?["text"],
    vegan: json?["vegan"] == null ? null : json?["vegan"],
    vegetarian: json?["vegetarian"] == null ? null : json?["vegetarian"],
  );

  Map<String, dynamic> toJson() => {
    "id": id!,
    "percent_estimate": percentEstimate!,
    "percent_max": percentMax!,
    "percent_min": percentMin!,
    "text": text!,
    "vegan": vegan == null ? null : vegan,
    "vegetarian": vegetarian == null ? null : vegetarian,
  };
}

class IngredientsAnalysis {
  IngredientsAnalysis({
    required this.enPalmOilContentUnknown,
    required this.enVeganStatusUnknown,
    required this.enVegetarianStatusUnknown,
  });

  List<String>? enPalmOilContentUnknown;
  List<String>? enVeganStatusUnknown;
  List<String>? enVegetarianStatusUnknown;

  factory IngredientsAnalysis.fromJson(Map<String, dynamic>? json) => IngredientsAnalysis(
    enPalmOilContentUnknown: json?["en:palm-oil-content-unknown"] != null
        ? List<String>.from(json?["en:palm-oil-content-unknown"].map((x) => x))
        : [],
    enVeganStatusUnknown: json?["en:vegan-status-unknown"] != null
        ? List<String>.from(json?["en:vegan-status-unknown"].map((x) => x))
        : [],
    enVegetarianStatusUnknown: json?["en:vegetarian-status-unknown"] != null
        ? List<String>.from(json?["en:vegetarian-status-unknown"].map((x) => x))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "en:palm-oil-content-unknown": List<dynamic>.from(enPalmOilContentUnknown!.map((x) => x)),
    "en:vegan-status-unknown": List<dynamic>.from(enVeganStatusUnknown!.map((x) => x)),
    "en:vegetarian-status-unknown": List<dynamic>.from(enVegetarianStatusUnknown!.map((x) => x)),
  };
}

class Languages {
  Languages({
    required this.enEnglish,
  });

  int? enEnglish;

  factory Languages.fromJson(Map<String, dynamic>? json) => Languages(
    enEnglish: json?["en:english"],
  );

  Map<String, dynamic> toJson() => {
    "en:english": enEnglish!,
  };
}

class LanguagesCodes {
  LanguagesCodes({
    required this.en,
  });

  int? en;

  factory LanguagesCodes.fromJson(Map<String, dynamic>? json) => LanguagesCodes(
    en: json?["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en!,
  };
}

class NovaGroupsMarkers {
  NovaGroupsMarkers({
    required this.the4,
  });

  List<List<String>?>? the4;

  factory NovaGroupsMarkers.fromJson(Map<String, dynamic>? json) => NovaGroupsMarkers(
    the4: json?["4"] != null
        ? List<List<String>>.from(json?["4"].map((x) => List<String>.from(x.map((x) => x))))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "4": List<dynamic>.from(the4!.map((x) => List<dynamic>.from(x!.map((x) => x)))),
  };
}

class Nutriments {
  Nutriments({
    required this.carbohydrates,
    required this.carbohydrates100G,
    required this.carbohydratesUnit,
    required this.carbohydratesValue,
    required this.energy,
    required this.energyKcal,
    required this.energyKcal100G,
    required this.energyKcalUnit,
    required this.energyKcalValue,
    required this.energy100G,
    required this.energyUnit,
    required this.energyValue,
    required this.fat,
    required this.fat100G,
    required this.fatUnit,
    required this.fatValue,
    required this.fruitsVegetablesNutsEstimateFromIngredients100G,
    required this.fruitsVegetablesNutsEstimateFromIngredientsServing,
    required this.novaGroup,
    required this.novaGroup100G,
    required this.novaGroupServing,
    required this.proteins,
    required this.proteins100G,
    required this.proteinsUnit,
    required this.proteinsValue,
    required this.salt,
    required this.salt100G,
    required this.saltUnit,
    required this.saltValue,
    required this.saturatedFat,
    required this.saturatedFat100G,
    required this.saturatedFatUnit,
    required this.saturatedFatValue,
    required this.sodium,
    required this.sodium100G,
    required this.sodiumUnit,
    required this.sodiumValue,
    required this.sugars,
    required this.sugars100G,
    required this.sugarsUnit,
    required this.sugarsValue,
  });

  double? carbohydrates;
  double? carbohydrates100G;
  String? carbohydratesUnit;
  double? carbohydratesValue;
  double? energy;
  double? energyKcal;
  double? energyKcal100G;
  String? energyKcalUnit;
  double? energyKcalValue;
  double? energy100G;
  String? energyUnit;
  double? energyValue;
  double? fat;
  double? fat100G;
  String? fatUnit;
  double? fatValue;
  double? fruitsVegetablesNutsEstimateFromIngredients100G;
  double? fruitsVegetablesNutsEstimateFromIngredientsServing;
  double? novaGroup;
  double? novaGroup100G;
  double? novaGroupServing;
  double? proteins;
  double? proteins100G;
  String? proteinsUnit;
  double? proteinsValue;
  double? salt;
  double? salt100G;
  String? saltUnit;
  double? saltValue;
  double? saturatedFat;
  double? saturatedFat100G;
  String? saturatedFatUnit;
  double? saturatedFatValue;
  double? sodium;
  double? sodium100G;
  String? sodiumUnit;
  double? sodiumValue;
  double? sugars;
  double? sugars100G;
  String? sugarsUnit;
  double? sugarsValue;

  factory Nutriments.fromJson(Map<String, dynamic>? json) => Nutriments(
    carbohydrates: json?["carbohydrates"]?.toDouble(),
    carbohydrates100G: json?["carbohydrates_100g"]?.toDouble(),
    carbohydratesUnit: json?["carbohydrates_unit"],
    carbohydratesValue: json?["carbohydrates_value"]?.toDouble(),
    energy: json?["energy"]?.toDouble(),
    energyKcal: json?["energy-kcal"]?.toDouble(),
    energyKcal100G: json?["energy-kcal_100g"]?.toDouble(),
    energyKcalUnit: json?["energy-kcal_unit"],
    energyKcalValue: json?["energy-kcal_value"]?.toDouble(),
    energy100G: json?["energy_100g"]?.toDouble(),
    energyUnit: json?["energy_unit"],
    energyValue: json?["energy_value"]?.toDouble(),
    fat: json?["fat"]?.toDouble(),
    fat100G: json?["fat_100g"]?.toDouble(),
    fatUnit: json?["fat_unit"],
    fatValue: json?["fat_value"]?.toDouble(),
    fruitsVegetablesNutsEstimateFromIngredients100G:
    json?["fruits-vegetables-nuts-estimate-from-ingredients_100g"]?.toDouble(),
    fruitsVegetablesNutsEstimateFromIngredientsServing:
    json?["fruits-vegetables-nuts-estimate-from-ingredients_serving"]?.toDouble(),
    novaGroup: json?["nova-group"]?.toDouble(),
    novaGroup100G: json?["nova-group_100g"]?.toDouble(),
    novaGroupServing: json?["nova-group_serving"]?.toDouble(),
    proteins: json?["proteins"]?.toDouble(),
    proteins100G: json?["proteins_100g"]?.toDouble(),
    proteinsUnit: json?["proteins_unit"],
    proteinsValue: json?["proteins_value"]?.toDouble(),
    salt: json?["salt"]?.toDouble(),
    salt100G: json?["salt_100g"]?.toDouble(),
    saltUnit: json?["salt_unit"],
    saltValue: json?["salt_value"]?.toDouble(),
    saturatedFat: json?["saturated-fat"]?.toDouble(),
    saturatedFat100G: json?["saturated-fat_100g"]?.toDouble(),
    saturatedFatUnit: json?["saturated-fat_unit"],
    saturatedFatValue: json?["saturated-fat_value"]?.toDouble(),
    sodium: json?["sodium"]?.toDouble(),
    sodium100G: json?["sodium_100g"]?.toDouble(),
    sodiumUnit: json?["sodium_unit"],
    sodiumValue: json?["sodium_value"]?.toDouble(),
    sugars: json?["sugars"]?.toDouble(),
    sugars100G: json?["sugars_100g"]?.toDouble(),
    sugarsUnit: json?["sugars_unit"],
    sugarsValue: json?["sugars_value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "carbohydrates": carbohydrates!,
    "carbohydrates_100g": carbohydrates100G!,
    "carbohydrates_unit": carbohydratesUnit!,
    "carbohydrates_value": carbohydratesValue!,
    "energy": energy!,
    "energy-kcal": energyKcal!,
    "energy-kcal_100g": energyKcal100G!,
    "energy-kcal_unit": energyKcalUnit!,
    "energy-kcal_value": energyKcalValue!,
    "energy_100g": energy100G!,
    "energy_unit": energyUnit!,
    "energy_value": energyValue!,
    "fat": fat!,
    "fat_100g": fat100G!,
    "fat_unit": fatUnit!,
    "fat_value": fatValue!,
    "fruits-vegetables-nuts-estimate-from-ingredients_100g": fruitsVegetablesNutsEstimateFromIngredients100G!,
    "fruits-vegetables-nuts-estimate-from-ingredients_serving":
    fruitsVegetablesNutsEstimateFromIngredientsServing!,
    "nova-group": novaGroup!,
    "nova-group_100g": novaGroup100G!,
    "nova-group_serving": novaGroupServing!,
    "proteins": proteins!,
    "proteins_100g": proteins100G!,
    "proteins_unit": proteinsUnit!,
    "proteins_value": proteinsValue!,
    "salt": salt!,
    "salt_100g": salt100G!,
    "salt_unit": saltUnit!,
    "salt_value": saltValue!,
    "saturated-fat": saturatedFat!,
    "saturated-fat_100g": saturatedFat100G!,
    "saturated-fat_unit": saturatedFatUnit!,
    "saturated-fat_value": saturatedFatValue!,
    "sodium": sodium!,
    "sodium_100g": sodium100G!,
    "sodium_unit": sodiumUnit!,
    "sodium_value": sodiumValue!,
    "sugars": sugars!,
    "sugars_100g": sugars100G!,
    "sugars_unit": sugarsUnit!,
    "sugars_value": sugarsValue!,
  };
}

class SelectedImages {
  SelectedImages({
    required this.front,
    required this.ingredients,
    required this.nutrition,
  });

  Front? front;
  Front? ingredients;
  Front? nutrition;

  factory SelectedImages.fromJson(Map<String, dynamic>? json) => SelectedImages(
    front: Front.fromJson(json?["front"]),
    ingredients: Front.fromJson(json?["ingredients"]),
    nutrition: Front.fromJson(json?["nutrition"]),
  );

  Map<String, dynamic> toJson() => {
    "front": front!.toJson(),
    "ingredients": ingredients!.toJson(),
    "nutrition": nutrition!.toJson(),
  };
}

class Front {
  Front({
    required this.display,
    required this.small,
    required this.thumb,
  });

  Display? display;
  Display? small;
  Display? thumb;

  factory Front.fromJson(Map<String, dynamic>? json) => Front(
    display: Display.fromJson(json?["display"]),
    small: Display.fromJson(json?["small"]),
    thumb: Display.fromJson(json?["thumb"]),
  );

  Map<String, dynamic> toJson() => {
    "display": display!.toJson(),
    "small": small!.toJson(),
    "thumb": thumb!.toJson(),
  };
}

class Display {
  Display({
    required this.en,
  });

  String? en;

  factory Display.fromJson(Map<String, dynamic>? json) => Display(
    en: json?["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en!,
  };
}
