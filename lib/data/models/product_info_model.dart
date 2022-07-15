// To parse this JSON data, do
//
//     final productInfoModel = productInfoModelFromJson(jsonString);

import 'dart:convert';

ProductInfoModel productInfoModelFromJson(String str) => ProductInfoModel.fromJson(json.decode(str));

String productInfoModelToJson(ProductInfoModel data) => json.encode(data.toJson());

class ProductInfoModel {
  ProductInfoModel({
    required this.code,
    required this.product,
    required this.status,
    required this.statusVerbose,
  });

  String? code;
  Product? product;
  int? status;
  String? statusVerbose;

  factory ProductInfoModel.fromJson(Map<String, dynamic>? json) => ProductInfoModel(
    code: json?["code"],
    product: Product.fromJson(json?["product"]),
    status: json?["status"],
    statusVerbose: json?["status_verbose"],
  );

  Map<String, dynamic> toJson() => {
    "code": code!,
    "product": product!.toJson(),
    "status": status!,
    "status_verbose": statusVerbose!,
  };
}

class Product {
  Product({
    required this.id,
    required this.keywords,
    required this.addedCountriesTags,
    required this.additivesN,
    required this.additivesOldN,
    required this.additivesOldTags,
    required this.additivesOriginalTags,
    required this.additivesTags,
    required this.allergens,
    required this.allergensFromIngredients,
    required this.allergensFromUser,
    required this.allergensHierarchy,
    required this.allergensLc,
    required this.allergensTags,
    required this.aminoAcidsTags,
    required this.brands,
    required this.brandsTags,
    required this.categories,
    required this.categoriesHierarchy,
    required this.categoriesLc,
    required this.categoriesProperties,
    required this.categoriesPropertiesTags,
    required this.categoriesTags,
    required this.checkersTags,
    required this.citiesTags,
    required this.code,
    required this.codesTags,
    required this.complete,
    required this.completeness,
    required this.correctorsTags,
    required this.countries,
    required this.countriesHierarchy,
    required this.countriesLc,
    required this.countriesTags,
    required this.createdT,
    required this.creator,
    required this.dataQualityBugsTags,
    required this.dataQualityErrorsTags,
    required this.dataQualityInfoTags,
    required this.dataQualityTags,
    required this.dataQualityWarningsTags,
    required this.dataSources,
    required this.dataSourcesTags,
    required this.debugParamSortedLangs,
    required this.ecoscoreData,
    required this.ecoscoreExtendedData,
    required this.ecoscoreExtendedDataVersion,
    required this.ecoscoreGrade,
    required this.ecoscoreTags,
    required this.editorsTags,
    required this.embCodes,
    required this.embCodesTags,
    required this.entryDatesTags,
    required this.expirationDate,
    required this.foodGroupsTags,
    required this.genericName,
    required this.genericNameEn,
    required this.productId,
    required this.imageFrontSmallUrl,
    required this.imageFrontThumbUrl,
    required this.imageFrontUrl,
    required this.imageIngredientsSmallUrl,
    required this.imageIngredientsThumbUrl,
    required this.imageIngredientsUrl,
    required this.imageNutritionSmallUrl,
    required this.imageNutritionThumbUrl,
    required this.imageNutritionUrl,
    required this.imageSmallUrl,
    required this.imageThumbUrl,
    required this.imageUrl,
    required this.images,
    required this.informersTags,
    required this.ingredients,
    required this.ingredientsAnalysis,
    required this.ingredientsAnalysisTags,
    required this.ingredientsFromOrThatMayBeFromPalmOilN,
    required this.ingredientsFromPalmOilN,
    required this.ingredientsFromPalmOilTags,
    required this.ingredientsHierarchy,
    required this.ingredientsN,
    required this.ingredientsNTags,
    required this.ingredientsOriginalTags,
    required this.ingredientsPercentAnalysis,
    required this.ingredientsTags,
    required this.ingredientsText,
    required this.ingredientsTextEn,
    required this.ingredientsTextWithAllergens,
    required this.ingredientsTextWithAllergensEn,
    required this.ingredientsThatMayBeFromPalmOilN,
    required this.ingredientsThatMayBeFromPalmOilTags,
    required this.ingredientsWithSpecifiedPercentN,
    required this.ingredientsWithSpecifiedPercentSum,
    required this.ingredientsWithUnspecifiedPercentN,
    required this.ingredientsWithUnspecifiedPercentSum,
    required this.interfaceVersionCreated,
    required this.interfaceVersionModified,
    required this.knownIngredientsN,
    required this.labels,
    required this.labelsHierarchy,
    required this.labelsLc,
    required this.labelsTags,
    required this.lang,
    required this.languages,
    required this.languagesCodes,
    required this.languagesHierarchy,
    required this.languagesTags,
    required this.lastEditDatesTags,
    required this.lastEditor,
    required this.lastImageDatesTags,
    required this.lastImageT,
    required this.lastModifiedBy,
    required this.lastModifiedT,
    required this.lc,
    required this.link,
    required this.mainCountriesTags,
    required this.manufacturingPlaces,
    required this.manufacturingPlacesTags,
    required this.maxImgid,
    required this.mineralsTags,
    required this.miscTags,
    required this.noNutritionData,
    required this.novaGroup,
    required this.novaGroupDebug,
    required this.novaGroups,
    required this.novaGroupsMarkers,
    required this.novaGroupsTags,
    required this.nucleotidesTags,
    required this.nutrientLevels,
    required this.nutrientLevelsTags,
    required this.nutriments,
    required this.nutritionData,
    required this.nutritionDataPer,
    required this.nutritionDataPrepared,
    required this.nutritionDataPreparedPer,
    required this.nutritionGradesTags,
    required this.nutritionScoreBeverage,
    required this.nutritionScoreDebug,
    required this.origins,
    required this.originsHierarchy,
    required this.originsLc,
    required this.originsTags,
    required this.otherNutritionalSubstancesTags,
    required this.packaging,
    required this.packagingHierarchy,
    required this.packagingLc,
    required this.packagingOld,
    required this.packagingTags,
    required this.packagingText,
    required this.packagingTextEn,
    required this.packagings,
    required this.photographersTags,
    required this.pnnsGroups1,
    required this.pnnsGroups1Tags,
    required this.pnnsGroups2,
    required this.pnnsGroups2Tags,
    required this.popularityKey,
    required this.popularityTags,
    required this.productName,
    required this.productNameEn,
    required this.purchasePlaces,
    required this.purchasePlacesTags,
    required this.quantity,
    required this.removedCountriesTags,
    required this.rev,
    required this.scansN,
    required this.selectedImages,
    required this.servingQuantity,
    required this.servingSize,
    required this.sortkey,
    required this.states,
    required this.statesHierarchy,
    required this.statesTags,
    required this.stores,
    required this.storesTags,
    required this.traces,
    required this.tracesFromIngredients,
    required this.tracesFromUser,
    required this.tracesHierarchy,
    required this.tracesLc,
    required this.tracesTags,
    required this.uniqueScansN,
    required this.unknownIngredientsN,
    required this.unknownNutrientsTags,
    required this.updateKey,
    required this.vitaminsTags,
    required this.withSweeteners,
  });

  String? id;
  List<String>? keywords;
  List<dynamic>? addedCountriesTags;
  int? additivesN;
  int? additivesOldN;
  List<String>? additivesOldTags;
  List<String>? additivesOriginalTags;
  List<String>? additivesTags;
  String? allergens;
  String? allergensFromIngredients;
  String? allergensFromUser;
  List<dynamic>? allergensHierarchy;
  String? allergensLc;
  List<dynamic>? allergensTags;
  List<dynamic>? aminoAcidsTags;
  String? brands;
  List<dynamic>? brandsTags;
  String? categories;
  List<dynamic>? categoriesHierarchy;
  String? categoriesLc;
  CategoriesProperties? categoriesProperties;
  List<String>? categoriesPropertiesTags;
  List<dynamic>? categoriesTags;
  List<dynamic>? checkersTags;
  List<dynamic>? citiesTags;
  String? code;
  List<String>? codesTags;
  int? complete;
  double? completeness;
  List<String>? correctorsTags;
  String? countries;
  List<String>? countriesHierarchy;
  String? countriesLc;
  List<String>? countriesTags;
  int? createdT;
  String? creator;
  List<dynamic>? dataQualityBugsTags;
  List<dynamic>? dataQualityErrorsTags;
  List<String>? dataQualityInfoTags;
  List<String>? dataQualityTags;
  List<String>? dataQualityWarningsTags;
  String? dataSources;
  List<String>? dataSourcesTags;
  List<String>? debugParamSortedLangs;
  EcoscoreData? ecoscoreData;
  EcoscoreExtendedData? ecoscoreExtendedData;
  String? ecoscoreExtendedDataVersion;
  String? ecoscoreGrade;
  List<String>? ecoscoreTags;
  List<String>? editorsTags;
  String? embCodes;
  List<dynamic>? embCodesTags;
  List<String>? entryDatesTags;
  String? expirationDate;
  List<dynamic>? foodGroupsTags;
  String? genericName;
  String? genericNameEn;
  String? productId;
  String? imageFrontSmallUrl;
  String? imageFrontThumbUrl;
  String? imageFrontUrl;
  String? imageIngredientsSmallUrl;
  String? imageIngredientsThumbUrl;
  String? imageIngredientsUrl;
  String? imageNutritionSmallUrl;
  String? imageNutritionThumbUrl;
  String? imageNutritionUrl;
  String? imageSmallUrl;
  String? imageThumbUrl;
  String? imageUrl;
  Images? images;
  List<String>? informersTags;
  List<Ingredient>? ingredients;
  IngredientsAnalysis? ingredientsAnalysis;
  List<String>? ingredientsAnalysisTags;
  int? ingredientsFromOrThatMayBeFromPalmOilN;
  int? ingredientsFromPalmOilN;
  List<dynamic>? ingredientsFromPalmOilTags;
  List<String>? ingredientsHierarchy;
  int? ingredientsN;
  List<String>? ingredientsNTags;
  List<String>? ingredientsOriginalTags;
  int? ingredientsPercentAnalysis;
  List<String>? ingredientsTags;
  String? ingredientsText;
  String? ingredientsTextEn;
  String? ingredientsTextWithAllergens;
  String? ingredientsTextWithAllergensEn;
  int? ingredientsThatMayBeFromPalmOilN;
  List<dynamic>? ingredientsThatMayBeFromPalmOilTags;
  int? ingredientsWithSpecifiedPercentN;
  int? ingredientsWithSpecifiedPercentSum;
  int? ingredientsWithUnspecifiedPercentN;
  int? ingredientsWithUnspecifiedPercentSum;
  String? interfaceVersionCreated;
  String? interfaceVersionModified;
  int? knownIngredientsN;
  String? labels;
  List<dynamic>? labelsHierarchy;
  String? labelsLc;
  List<dynamic>? labelsTags;
  String? lang;
  Languages? languages;
  LanguagesCodes? languagesCodes;
  List<String>? languagesHierarchy;
  List<String>? languagesTags;
  List<String>? lastEditDatesTags;
  String? lastEditor;
  List<String>? lastImageDatesTags;
  int? lastImageT;
  String? lastModifiedBy;
  int? lastModifiedT;
  String? lc;
  String? link;
  List<dynamic>? mainCountriesTags;
  String? manufacturingPlaces;
  List<dynamic>? manufacturingPlacesTags;
  String? maxImgid;
  List<dynamic>? mineralsTags;
  List<String>? miscTags;
  String? noNutritionData;
  int? novaGroup;
  String? novaGroupDebug;
  String? novaGroups;
  NovaGroupsMarkers? novaGroupsMarkers;
  List<String>? novaGroupsTags;
  List<dynamic>? nucleotidesTags;
  CategoriesProperties? nutrientLevels;
  List<dynamic>? nutrientLevelsTags;
  Nutriments? nutriments;
  String? nutritionData;
  String? nutritionDataPer;
  String? nutritionDataPrepared;
  String? nutritionDataPreparedPer;
  List<String>? nutritionGradesTags;
  int? nutritionScoreBeverage;
  String? nutritionScoreDebug;
  String? origins;
  List<dynamic>? originsHierarchy;
  String? originsLc;
  List<dynamic>? originsTags;
  List<dynamic>? otherNutritionalSubstancesTags;
  String? packaging;
  List<dynamic>? packagingHierarchy;
  String? packagingLc;
  String? packagingOld;
  List<dynamic>? packagingTags;
  String? packagingText;
  String? packagingTextEn;
  List<dynamic>? packagings;
  List<String>? photographersTags;
  String? pnnsGroups1;
  List<String>? pnnsGroups1Tags;
  String? pnnsGroups2;
  List<String>? pnnsGroups2Tags;
  int? popularityKey;
  List<String>? popularityTags;
  String? productName;
  String? productNameEn;
  String? purchasePlaces;
  List<dynamic>? purchasePlacesTags;
  String? quantity;
  List<dynamic>? removedCountriesTags;
  int? rev;
  int? scansN;
  SelectedImages? selectedImages;
  String? servingQuantity;
  String? servingSize;
  int? sortkey;
  String? states;
  List<String>? statesHierarchy;
  List<String>? statesTags;
  String? stores;
  List<dynamic>? storesTags;
  String? traces;
  String? tracesFromIngredients;
  String? tracesFromUser;
  List<dynamic>? tracesHierarchy;
  String? tracesLc;
  List<dynamic>? tracesTags;
  int? uniqueScansN;
  int? unknownIngredientsN;
  List<dynamic>? unknownNutrientsTags;
  String? updateKey;
  List<dynamic>? vitaminsTags;
  int? withSweeteners;

  factory Product.fromJson(Map<String, dynamic>? json) => Product(
    id: json?["_id"],
    keywords: json?["_keywords"] != null ? List<String>.from(json?["_keywords"].map((x) => x)) : [],
    addedCountriesTags: json?["added_countries_tags"] != null ? List<dynamic>.from(json?["added_countries_tags"].map((x) => x == null ? "" : x)) : [],
    additivesN: json?["additives_n"],
    additivesOldN: json?["additives_old_n"],
    additivesOldTags: json?["additives_old_tags"] != null ? List<String>.from(json?["additives_old_tags"].map((x) => x)) : [],
    additivesOriginalTags: json?["additives_original_tags"] != null ? List<String>.from(json?["additives_original_tags"].map((x) => x)) : [],
    additivesTags: json?["additives_tags"] != null ? List<String>.from(json?["additives_tags"].map((x) => x)) : [],
    allergens: json?["allergens"],
    allergensFromIngredients: json?["allergens_from_ingredients"],
    allergensFromUser: json?["allergens_from_user"],
    allergensHierarchy: json?["allergens_hierarchy"] != null ? List<dynamic>.from(json?["allergens_hierarchy"].map((x) => x == null ? "" : x)) : [],
    allergensLc: json?["allergens_lc"],
    allergensTags: json?["allergens_tags"] != null ? List<dynamic>.from(json?["allergens_tags"].map((x) => x == null ? "" : x)) : [],
    aminoAcidsTags: json?["amino_acids_tags"] != null ? List<dynamic>.from(json?["amino_acids_tags"].map((x) => x == null ? "" : x)) : [],
    brands: json?["brands"],
    brandsTags: json?["brands_tags"] != null ? List<dynamic>.from(json?["brands_tags"].map((x) => x == null ? "" : x)) : [],
    categories: json?["categories"],
    categoriesHierarchy: json?["categories_hierarchy"] != null ? List<dynamic>.from(json?["categories_hierarchy"].map((x) => x == null ? "" : x)) : [],
    categoriesLc: json?["categories_lc"],
    categoriesProperties: CategoriesProperties.fromJson(json?["categories_properties"]),
    categoriesPropertiesTags: json?["categories_properties_tags"] != null ? List<String>.from(json?["categories_properties_tags"].map((x) => x)) : [],
    categoriesTags: json?["categories_tags"] != null ? List<dynamic>.from(json?["categories_tags"].map((x) => x == null ? "" : x)) : [],
    checkersTags: json?["checkers_tags"] != null ? List<dynamic>.from(json?["checkers_tags"].map((x) => x == null ? "" : x)) : [],
    citiesTags: json?["cities_tags"] != null ? List<dynamic>.from(json?["cities_tags"].map((x) => x == null ? "" : x)) : [],
    code: json?["code"],
    codesTags: json?["codes_tags"] != null ? List<String>.from(json?["codes_tags"].map((x) => x)) : [],
    complete: json?["complete"],
    completeness: json?["completeness"]?.toDouble(),
    correctorsTags: json?["correctors_tags"] != null ? List<String>.from(json?["correctors_tags"].map((x) => x)) : [],
    countries: json?["countries"],
    countriesHierarchy: json?["countries_hierarchy"] != null ? List<String>.from(json?["countries_hierarchy"].map((x) => x)) : [],
    countriesLc: json?["countries_lc"],
    countriesTags: json?["countries_tags"] != null ? List<String>.from(json?["countries_tags"].map((x) => x)) : [],
    createdT: json?["created_t"],
    creator: json?["creator"],
    dataQualityBugsTags: json?["data_quality_bugs_tags"] != null ? List<dynamic>.from(json?["data_quality_bugs_tags"].map((x) => x == null ? "" : x)) : [],
    dataQualityErrorsTags: json?["data_quality_errors_tags"] != null ? List<dynamic>.from(json?["data_quality_errors_tags"].map((x) => x == null ? "" : x)) : [],
    dataQualityInfoTags: json?["data_quality_info_tags"] != null ? List<String>.from(json?["data_quality_info_tags"].map((x) => x)) : [],
    dataQualityTags: json?["data_quality_tags"] != null ? List<String>.from(json?["data_quality_tags"].map((x) => x)) : [],
    dataQualityWarningsTags: json?["data_quality_warnings_tags"] != null ? List<String>.from(json?["data_quality_warnings_tags"].map((x) => x)) : [],
    dataSources: json?["data_sources"],
    dataSourcesTags: json?["data_sources_tags"] != null ? List<String>.from(json?["data_sources_tags"].map((x) => x)) : [],
    debugParamSortedLangs: json?["debug_param_sorted_langs"] != null ? List<String>.from(json?["debug_param_sorted_langs"].map((x) => x)) : [],
    ecoscoreData: EcoscoreData.fromJson(json?["ecoscore_data"]),
    ecoscoreExtendedData: EcoscoreExtendedData.fromJson(json?["ecoscore_extended_data"]),
    ecoscoreExtendedDataVersion: json?["ecoscore_extended_data_version"],
    ecoscoreGrade: json?["ecoscore_grade"],
    ecoscoreTags: json?["ecoscore_tags"] != null ? List<String>.from(json?["ecoscore_tags"].map((x) => x)) : [],
    editorsTags: json?["editors_tags"] != null ? List<String>.from(json?["editors_tags"].map((x) => x)) : [],
    embCodes: json?["emb_codes"],
    embCodesTags: json?["emb_codes_tags"] != null ? List<dynamic>.from(json?["emb_codes_tags"].map((x) => x == null ? "" : x)) : [],
    entryDatesTags: json?["entry_dates_tags"] != null ? List<String>.from(json?["entry_dates_tags"].map((x) => x)) : [],
    expirationDate: json?["expiration_date"],
    foodGroupsTags: json?["food_groups_tags"] != null ? List<dynamic>.from(json?["food_groups_tags"].map((x) => x == null ? "" : x)) : [],
    genericName: json?["generic_name"],
    genericNameEn: json?["generic_name_en"],
    productId: json?["id"],
    imageFrontSmallUrl: json?["image_front_small_url"],
    imageFrontThumbUrl: json?["image_front_thumb_url"],
    imageFrontUrl: json?["image_front_url"],
    imageIngredientsSmallUrl: json?["image_ingredients_small_url"],
    imageIngredientsThumbUrl: json?["image_ingredients_thumb_url"],
    imageIngredientsUrl: json?["image_ingredients_url"],
    imageNutritionSmallUrl: json?["image_nutrition_small_url"],
    imageNutritionThumbUrl: json?["image_nutrition_thumb_url"],
    imageNutritionUrl: json?["image_nutrition_url"],
    imageSmallUrl: json?["image_small_url"],
    imageThumbUrl: json?["image_thumb_url"],
    imageUrl: json?["image_url"],
    images: Images.fromJson(json?["images"]),
    informersTags: json?["informers_tags"] != null ? List<String>.from(json?["informers_tags"].map((x) => x)) : [],
    ingredients: json?["ingredients"] != null ? List<Ingredient>.from(json?["ingredients"].map((x) => Ingredient.fromJson(x))) : [],
    ingredientsAnalysis: IngredientsAnalysis.fromJson(json?["ingredients_analysis"]),
    ingredientsAnalysisTags: json?["ingredients_analysis_tags"] != null ? List<String>.from(json?["ingredients_analysis_tags"].map((x) => x)) : [],
    ingredientsFromOrThatMayBeFromPalmOilN: json?["ingredients_from_or_that_may_be_from_palm_oil_n"],
    ingredientsFromPalmOilN: json?["ingredients_from_palm_oil_n"],
    ingredientsFromPalmOilTags: json?["ingredients_from_palm_oil_tags"] != null ? List<dynamic>.from(json?["ingredients_from_palm_oil_tags"].map((x) => x == null ? "" : x)) : [],
    ingredientsHierarchy: json?["ingredients_hierarchy"] != null ? List<String>.from(json?["ingredients_hierarchy"].map((x) => x)) : [],
    ingredientsN: json?["ingredients_n"],
    ingredientsNTags: json?["ingredients_n_tags"] != null ? List<String>.from(json?["ingredients_n_tags"].map((x) => x)) : [],
    ingredientsOriginalTags: json?["ingredients_original_tags"] != null ? List<String>.from(json?["ingredients_original_tags"].map((x) => x)) : [],
    ingredientsPercentAnalysis: json?["ingredients_percent_analysis"],
    ingredientsTags: json?["ingredients_tags"] != null ? List<String>.from(json?["ingredients_tags"].map((x) => x)) : [],
    ingredientsText: json?["ingredients_text"],
    ingredientsTextEn: json?["ingredients_text_en"],
    ingredientsTextWithAllergens: json?["ingredients_text_with_allergens"],
    ingredientsTextWithAllergensEn: json?["ingredients_text_with_allergens_en"],
    ingredientsThatMayBeFromPalmOilN: json?["ingredients_that_may_be_from_palm_oil_n"],
    ingredientsThatMayBeFromPalmOilTags: json?["ingredients_that_may_be_from_palm_oil_tags"] != null ? List<dynamic>.from(json?["ingredients_that_may_be_from_palm_oil_tags"].map((x) => x == null ? "" : x)) : [],
    ingredientsWithSpecifiedPercentN: json?["ingredients_with_specified_percent_n"],
    ingredientsWithSpecifiedPercentSum: json?["ingredients_with_specified_percent_sum"],
    ingredientsWithUnspecifiedPercentN: json?["ingredients_with_unspecified_percent_n"],
    ingredientsWithUnspecifiedPercentSum: json?["ingredients_with_unspecified_percent_sum"],
    interfaceVersionCreated: json?["interface_version_created"],
    interfaceVersionModified: json?["interface_version_modified"],
    knownIngredientsN: json?["known_ingredients_n"],
    labels: json?["labels"],
    labelsHierarchy: json?["labels_hierarchy"] != null ? List<dynamic>.from(json?["labels_hierarchy"].map((x) => x == null ? "" : x)) : [],
    labelsLc: json?["labels_lc"],
    labelsTags: json?["labels_tags"] != null ? List<dynamic>.from(json?["labels_tags"].map((x) => x == null ? "" : x)) : [],
    lang: json?["lang"],
    languages: Languages.fromJson(json?["languages"]),
    languagesCodes: LanguagesCodes.fromJson(json?["languages_codes"]),
    languagesHierarchy: json?["languages_hierarchy"] != null ? List<String>.from(json?["languages_hierarchy"].map((x) => x)) : [],
    languagesTags: json?["languages_tags"] != null? List<String>.from(json?["languages_tags"].map((x) => x)) : [],
    lastEditDatesTags: json?["last_edit_dates_tags"] != null ? List<String>.from(json?["last_edit_dates_tags"].map((x) => x)) : [],
    lastEditor: json?["last_editor"],
    lastImageDatesTags: json?["last_image_dates_tags"] != null ? List<String>.from(json?["last_image_dates_tags"].map((x) => x)) : [],
    lastImageT: json?["last_image_t"],
    lastModifiedBy: json?["last_modified_by"],
    lastModifiedT: json?["last_modified_t"],
    lc: json?["lc"],
    link: json?["link"],
    mainCountriesTags: json?["main_countries_tags"] != null ? List<dynamic>.from(json?["main_countries_tags"].map((x) => x == null ? "" : x)) : [],
    manufacturingPlaces: json?["manufacturing_places"],
    manufacturingPlacesTags: json?["manufacturing_places_tags"] != null ? List<dynamic>.from(json?["manufacturing_places_tags"].map((x) => x == null ? "" : x)) : [],
    maxImgid: json?["max_imgid"],
    mineralsTags: json?["minerals_tags"] != null ? List<dynamic>.from(json?["minerals_tags"].map((x) => x == null ? "" : x)) : [],
    miscTags: json?["misc_tags"] != null ? List<String>.from(json?["misc_tags"].map((x) => x)) : [],
    noNutritionData: json?["no_nutrition_data"],
    novaGroup: json?["nova_group"],
    novaGroupDebug: json?["nova_group_debug"],
    novaGroups: json?["nova_groups"],
    novaGroupsMarkers: NovaGroupsMarkers.fromJson(json?["nova_groups_markers"]),
    novaGroupsTags: json?["nova_groups_tags"] != null ? List<String>.from(json?["nova_groups_tags"].map((x) => x)) : [],
    nucleotidesTags: json?["nucleotides_tags"] != null ? List<dynamic>.from(json?["nucleotides_tags"].map((x) => x == null ? "" : x)) : [],
    nutrientLevels: CategoriesProperties.fromJson(json?["nutrient_levels"]),
    nutrientLevelsTags: json?["nutrient_levels_tags"] != null ? List<dynamic>.from(json?["nutrient_levels_tags"].map((x) => x == null ? "" : x)) : [],
    nutriments: Nutriments.fromJson(json?["nutriments"]),
    nutritionData: json?["nutrition_data"],
    nutritionDataPer: json?["nutrition_data_per"],
    nutritionDataPrepared: json?["nutrition_data_prepared"],
    nutritionDataPreparedPer: json?["nutrition_data_prepared_per"],
    nutritionGradesTags: json?["nutrition_grades_tags"] != null ? List<String>.from(json?["nutrition_grades_tags"].map((x) => x)) : [],
    nutritionScoreBeverage: json?["nutrition_score_beverage"],
    nutritionScoreDebug: json?["nutrition_score_debug"],
    origins: json?["origins"],
    originsHierarchy: json?["origins_hierarchy"] != null ? List<dynamic>.from(json?["origins_hierarchy"].map((x) => x == null ? "" : x)) : [],
    originsLc: json?["origins_lc"],
    originsTags: json?["origins_tags"] != null ? List<dynamic>.from(json?["origins_tags"].map((x) => x == null ? "" : x)) : [],
    otherNutritionalSubstancesTags: json?["other_nutritional_substances_tags"] != null ? List<dynamic>.from(json?["other_nutritional_substances_tags"].map((x) => x == null ? "" : x)) : [],
    packaging: json?["packaging"],
    packagingHierarchy: json?["packaging_hierarchy"] != null ? List<dynamic>.from(json?["packaging_hierarchy"].map((x) => x == null ? "" : x)) : [],
    packagingLc: json?["packaging_lc"],
    packagingOld: json?["packaging_old"],
    packagingTags: json?["packaging_tags"] != null ? List<dynamic>.from(json?["packaging_tags"].map((x) => x == null ? "" : x)) : [],
    packagingText: json?["packaging_text"],
    packagingTextEn: json?["packaging_text_en"],
    packagings: json?["packagings"] != null ? List<dynamic>.from(json?["packagings"].map((x) => x == null ? "" : x)) : [],
    photographersTags: json?["photographers_tags"] != null ? List<String>.from(json?["photographers_tags"].map((x) => x)) : [],
    pnnsGroups1: json?["pnns_groups_1"],
    pnnsGroups1Tags: json?["pnns_groups_1_tags"] != null ? List<String>.from(json?["pnns_groups_1_tags"].map((x) => x)) : [],
    pnnsGroups2: json?["pnns_groups_2"],
    pnnsGroups2Tags: json?["pnns_groups_2_tags"] != null ? List<String>.from(json?["pnns_groups_2_tags"].map((x) => x)) : [],
    popularityKey: json?["popularity_key"],
    popularityTags: json?["popularity_tags"] != null ? List<String>.from(json?["popularity_tags"].map((x) => x)) : [],
    productName: json?["product_name"],
    productNameEn: json?["product_name_en"],
    purchasePlaces: json?["purchase_places"],
    purchasePlacesTags: json?["purchase_places_tags"] != null ? List<dynamic>.from(json?["purchase_places_tags"].map((x) => x == null ? "" : x)) : [],
    quantity: json?["quantity"],
    removedCountriesTags: json?["removed_countries_tags"] != null ? List<dynamic>.from(json?["removed_countries_tags"].map((x) => x == null ? "" : x)) : [],
    rev: json?["rev"],
    scansN: json?["scans_n"],
    selectedImages: SelectedImages.fromJson(json?["selected_images"]),
    servingQuantity: json?["serving_quantity"],
    servingSize: json?["serving_size"],
    sortkey: json?["sortkey"],
    states: json?["states"],
    statesHierarchy: json?["states_hierarchy"] != null ? List<String>.from(json?["states_hierarchy"].map((x) => x)) : [],
    statesTags: json?["states_tags"] != null ? List<String>.from(json?["states_tags"].map((x) => x)) : [],
    stores: json?["stores"],
    storesTags: json?["stores_tags"] != null ? List<dynamic>.from(json?["stores_tags"].map((x) => x == null ? "" : x)) : [],
    traces: json?["traces"],
    tracesFromIngredients: json?["traces_from_ingredients"],
    tracesFromUser: json?["traces_from_user"],
    tracesHierarchy: json?["traces_hierarchy"] != null ? List<dynamic>.from(json?["traces_hierarchy"].map((x) => x == null ? "" : x)) : [],
    tracesLc: json?["traces_lc"],
    tracesTags: json?["traces_tags"] != null ? List<dynamic>.from(json?["traces_tags"].map((x) => x == null ? "" : x)) : [],
    uniqueScansN: json?["unique_scans_n"],
    unknownIngredientsN: json?["unknown_ingredients_n"],
    unknownNutrientsTags: json?["unknown_nutrients_tags"] != null ? List<dynamic>.from(json?["unknown_nutrients_tags"].map((x) => x == null ? "" : x)) : [],
    updateKey: json?["update_key"],
    vitaminsTags: json?["vitamins_tags"] != null ? List<dynamic>.from(json?["vitamins_tags"].map((x) => x == null ? "" : x)) : [],
    withSweeteners: json?["with_sweeteners"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id!,
    "_keywords": List<dynamic>.from(keywords!.map((x) => x)),
    "added_countries_tags": List<dynamic>.from(addedCountriesTags!.map((x) => x)),
    "additives_n": additivesN!,
    "additives_old_n": additivesOldN!,
    "additives_old_tags": List<dynamic>.from(additivesOldTags!.map((x) => x)),
    "additives_original_tags": List<dynamic>.from(additivesOriginalTags!.map((x) => x)),
    "additives_tags": List<dynamic>.from(additivesTags!.map((x) => x)),
    "allergens": allergens!,
    "allergens_from_ingredients": allergensFromIngredients!,
    "allergens_from_user": allergensFromUser!,
    "allergens_hierarchy": List<dynamic>.from(allergensHierarchy!.map((x) => x)),
    "allergens_lc": allergensLc!,
    "allergens_tags": List<dynamic>.from(allergensTags!.map((x) => x)),
    "amino_acids_tags": List<dynamic>.from(aminoAcidsTags!.map((x) => x)),
    "brands": brands!,
    "brands_tags": List<dynamic>.from(brandsTags!.map((x) => x)),
    "categories": categories!,
    "categories_hierarchy": List<dynamic>.from(categoriesHierarchy!.map((x) => x)),
    "categories_lc": categoriesLc!,
    "categories_properties": categoriesProperties!.toJson(),
    "categories_properties_tags": List<dynamic>.from(categoriesPropertiesTags!.map((x) => x)),
    "categories_tags": List<dynamic>.from(categoriesTags!.map((x) => x)),
    "checkers_tags": List<dynamic>.from(checkersTags!.map((x) => x)),
    "cities_tags": List<dynamic>.from(citiesTags!.map((x) => x)),
    "code": code!,
    "codes_tags": List<dynamic>.from(codesTags!.map((x) => x)),
    "complete": complete!,
    "completeness": completeness!,
    "correctors_tags": List<dynamic>.from(correctorsTags!.map((x) => x)),
    "countries": countries!,
    "countries_hierarchy": List<dynamic>.from(countriesHierarchy!.map((x) => x)),
    "countries_lc": countriesLc!,
    "countries_tags": List<dynamic>.from(countriesTags!.map((x) => x)),
    "created_t": createdT!,
    "creator": creator!,
    "data_quality_bugs_tags": List<dynamic>.from(dataQualityBugsTags!.map((x) => x)),
    "data_quality_errors_tags": List<dynamic>.from(dataQualityErrorsTags!.map((x) => x)),
    "data_quality_info_tags": List<dynamic>.from(dataQualityInfoTags!.map((x) => x)),
    "data_quality_tags": List<dynamic>.from(dataQualityTags!.map((x) => x)),
    "data_quality_warnings_tags": List<dynamic>.from(dataQualityWarningsTags!.map((x) => x)),
    "data_sources": dataSources!,
    "data_sources_tags": List<dynamic>.from(dataSourcesTags!.map((x) => x)),
    "debug_param_sorted_langs": List<dynamic>.from(debugParamSortedLangs!.map((x) => x)),
    "ecoscore_data": ecoscoreData!.toJson(),
    "ecoscore_extended_data": ecoscoreExtendedData!.toJson(),
    "ecoscore_extended_data_version": ecoscoreExtendedDataVersion!,
    "ecoscore_grade": ecoscoreGrade!,
    "ecoscore_tags": List<dynamic>.from(ecoscoreTags!.map((x) => x)),
    "editors_tags": List<dynamic>.from(editorsTags!.map((x) => x)),
    "emb_codes": embCodes!,
    "emb_codes_tags": List<dynamic>.from(embCodesTags!.map((x) => x)),
    "entry_dates_tags": List<dynamic>.from(entryDatesTags!.map((x) => x)),
    "expiration_date": expirationDate!,
    "food_groups_tags": List<dynamic>.from(foodGroupsTags!.map((x) => x)),
    "generic_name": genericName!,
    "generic_name_en": genericNameEn!,
    "id": productId!,
    "image_front_small_url": imageFrontSmallUrl!,
    "image_front_thumb_url": imageFrontThumbUrl!,
    "image_front_url": imageFrontUrl!,
    "image_ingredients_small_url": imageIngredientsSmallUrl!,
    "image_ingredients_thumb_url": imageIngredientsThumbUrl!,
    "image_ingredients_url": imageIngredientsUrl!,
    "image_nutrition_small_url": imageNutritionSmallUrl!,
    "image_nutrition_thumb_url": imageNutritionThumbUrl!,
    "image_nutrition_url": imageNutritionUrl!,
    "image_small_url": imageSmallUrl!,
    "image_thumb_url": imageThumbUrl!,
    "image_url": imageUrl!,
    "images": images!.toJson(),
    "informers_tags": List<dynamic>.from(informersTags!.map((x) => x)),
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
    "ingredients_analysis": ingredientsAnalysis!.toJson(),
    "ingredients_analysis_tags": List<dynamic>.from(ingredientsAnalysisTags!.map((x) => x)),
    "ingredients_from_or_that_may_be_from_palm_oil_n": ingredientsFromOrThatMayBeFromPalmOilN,
    "ingredients_from_palm_oil_n": ingredientsFromPalmOilN!,
    "ingredients_from_palm_oil_tags": List<dynamic>.from(ingredientsFromPalmOilTags!.map((x) => x)),
    "ingredients_hierarchy": List<dynamic>.from(ingredientsHierarchy!.map((x) => x)),
    "ingredients_n": ingredientsN!,
    "ingredients_n_tags": List<dynamic>.from(ingredientsNTags!.map((x) => x)),
    "ingredients_original_tags": List<dynamic>.from(ingredientsOriginalTags!.map((x) => x)),
    "ingredients_percent_analysis": ingredientsPercentAnalysis,
    "ingredients_tags": List<dynamic>.from(ingredientsTags!.map((x) => x)),
    "ingredients_text": ingredientsText!,
    "ingredients_text_en": ingredientsTextEn!,
    "ingredients_text_with_allergens": ingredientsTextWithAllergens!,
    "ingredients_text_with_allergens_en": ingredientsTextWithAllergensEn!,
    "ingredients_that_may_be_from_palm_oil_n": ingredientsThatMayBeFromPalmOilN!,
    "ingredients_that_may_be_from_palm_oil_tags": List<dynamic>.from(ingredientsThatMayBeFromPalmOilTags!.map((x) => x)),
    "ingredients_with_specified_percent_n": ingredientsWithSpecifiedPercentN!,
    "ingredients_with_specified_percent_sum": ingredientsWithSpecifiedPercentSum!,
    "ingredients_with_unspecified_percent_n": ingredientsWithUnspecifiedPercentN!,
    "ingredients_with_unspecified_percent_sum": ingredientsWithUnspecifiedPercentSum!,
    "interface_version_created": interfaceVersionCreated!,
    "interface_version_modified": interfaceVersionModified!,
    "known_ingredients_n": knownIngredientsN!,
    "labels": labels!,
    "labels_hierarchy": List<dynamic>.from(labelsHierarchy!.map((x) => x)),
    "labels_lc": labelsLc,
    "labels_tags": List<dynamic>.from(labelsTags!.map((x) => x)),
    "lang": lang,
    "languages": languages!.toJson(),
    "languages_codes": languagesCodes!.toJson(),
    "languages_hierarchy": List<dynamic>.from(languagesHierarchy!.map((x) => x)),
    "languages_tags": List<dynamic>.from(languagesTags!.map((x) => x)),
    "last_edit_dates_tags": List<dynamic>.from(lastEditDatesTags!.map((x) => x)),
    "last_editor": lastEditor!,
    "last_image_dates_tags": List<dynamic>.from(lastImageDatesTags!.map((x) => x)),
    "last_image_t": lastImageT!,
    "last_modified_by": lastModifiedBy!,
    "last_modified_t": lastModifiedT!,
    "lc": lc!,
    "link": link!,
    "main_countries_tags": List<dynamic>.from(mainCountriesTags!.map((x) => x)),
    "manufacturing_places": manufacturingPlaces,
    "manufacturing_places_tags": List<dynamic>.from(manufacturingPlacesTags!.map((x) => x)),
    "max_imgid": maxImgid!,
    "minerals_tags": List<dynamic>.from(mineralsTags!.map((x) => x)),
    "misc_tags": List<dynamic>.from(miscTags!.map((x) => x)),
    "no_nutrition_data": noNutritionData!,
    "nova_group": novaGroup!,
    "nova_group_debug": novaGroupDebug!,
    "nova_groups": novaGroups!,
    "nova_groups_markers": novaGroupsMarkers!.toJson(),
    "nova_groups_tags": List<dynamic>.from(novaGroupsTags!.map((x) => x)),
    "nucleotides_tags": List<dynamic>.from(nucleotidesTags!.map((x) => x)),
    "nutrient_levels": nutrientLevels!.toJson(),
    "nutrient_levels_tags": List<dynamic>.from(nutrientLevelsTags!.map((x) => x)),
    "nutriments": nutriments!.toJson(),
    "nutrition_data": nutritionData!,
    "nutrition_data_per": nutritionDataPer!,
    "nutrition_data_prepared": nutritionDataPrepared!,
    "nutrition_data_prepared_per": nutritionDataPreparedPer!,
    "nutrition_grades_tags": List<dynamic>.from(nutritionGradesTags!.map((x) => x)),
    "nutrition_score_beverage": nutritionScoreBeverage!,
    "nutrition_score_debug": nutritionScoreDebug!,
    "origins": origins!,
    "origins_hierarchy": List<dynamic>.from(originsHierarchy!.map((x) => x)),
    "origins_lc": originsLc!,
    "origins_tags": List<dynamic>.from(originsTags!.map((x) => x)),
    "other_nutritional_substances_tags": List<dynamic>.from(otherNutritionalSubstancesTags!.map((x) => x)),
    "packaging": packaging!,
    "packaging_hierarchy": List<dynamic>.from(packagingHierarchy!.map((x) => x)),
    "packaging_lc": packagingLc!,
    "packaging_old": packagingOld!,
    "packaging_tags": List<dynamic>.from(packagingTags!.map((x) => x)),
    "packaging_text": packagingText!,
    "packaging_text_en": packagingTextEn!,
    "packagings": List<dynamic>.from(packagings!.map((x) => x)),
    "photographers_tags": List<dynamic>.from(photographersTags!.map((x) => x)),
    "pnns_groups_1": pnnsGroups1!,
    "pnns_groups_1_tags": List<dynamic>.from(pnnsGroups1Tags!.map((x) => x)),
    "pnns_groups_2": pnnsGroups2!,
    "pnns_groups_2_tags": List<dynamic>.from(pnnsGroups2Tags!.map((x) => x)),
    "popularity_key": popularityKey!,
    "popularity_tags": List<dynamic>.from(popularityTags!.map((x) => x)),
    "product_name": productName!,
    "product_name_en": productNameEn!,
    "purchase_places": purchasePlaces!,
    "purchase_places_tags": List<dynamic>.from(purchasePlacesTags!.map((x) => x)),
    "quantity": quantity!,
    "removed_countries_tags": List<dynamic>.from(removedCountriesTags!.map((x) => x)),
    "rev": rev!,
    "scans_n": scansN!,
    "selected_images": selectedImages!.toJson(),
    "serving_quantity": servingQuantity!,
    "serving_size": servingSize!,
    "sortkey": sortkey!,
    "states": states!,
    "states_hierarchy": List<dynamic>.from(statesHierarchy!.map((x) => x)),
    "states_tags": List<dynamic>.from(statesTags!.map((x) => x)),
    "stores": stores!,
    "stores_tags": List<dynamic>.from(storesTags!.map((x) => x)),
    "traces": traces!,
    "traces_from_ingredients": tracesFromIngredients!,
    "traces_from_user": tracesFromUser!,
    "traces_hierarchy": List<dynamic>.from(tracesHierarchy!.map((x) => x)),
    "traces_lc": tracesLc!,
    "traces_tags": List<dynamic>.from(tracesTags!.map((x) => x)),
    "unique_scans_n": uniqueScansN!,
    "unknown_ingredients_n": unknownIngredientsN!,
    "unknown_nutrients_tags": List<dynamic>.from(unknownNutrientsTags!.map((x) => x)),
    "update_key": updateKey!,
    "vitamins_tags": List<dynamic>.from(vitaminsTags!.map((x) => x)),
    "with_sweeteners": withSweeteners!,
  };
}

class CategoriesProperties {
  CategoriesProperties();

  factory CategoriesProperties.fromJson(Map<String, dynamic>? json) => CategoriesProperties(
  );

  Map<String, dynamic> toJson() => {
  };
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
    required this.originsOfIngredients,
    required this.packaging,
    required this.productionSystem,
    required this.threatenedSpecies,
  });

  OriginsOfIngredients? originsOfIngredients;
  Packaging? packaging;
  ProductionSystem? productionSystem;
  CategoriesProperties? threatenedSpecies;

  factory Adjustments.fromJson(Map<String, dynamic>? json) => Adjustments(
    originsOfIngredients: OriginsOfIngredients.fromJson(json?["origins_of_ingredients"]),
    packaging: Packaging.fromJson(json?["packaging"]),
    productionSystem: ProductionSystem.fromJson(json?["production_system"]),
    threatenedSpecies: CategoriesProperties.fromJson(json?["threatened_species"]),
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
    aggregatedOrigins: json?["aggregated_origins"] != null ? List<AggregatedOrigin>.from(json?["aggregated_origins"].map((x) => AggregatedOrigin.fromJson(x))) : [],
    epiScore: json?["epi_score"].toDouble(),
    epiValue: json?["epi_value"].toDouble(),
    originsFromOriginsField: json?["origins_from_origins_field"] != null ? List<String>.from(json?["origins_from_origins_field"].map((x) => x)) : [],
    transportationScores: json?["transportation_scores"] != null ? Map.from(json?["transportation_scores"]).map((k, v) => MapEntry<String, int>(k, v)) : Map<String, int>(),
    transportationValues: json?["transportation_values"] != null ? Map.from(json?["transportation_values"]).map((k, v) => MapEntry<String, int>(k, v)) : Map<String, int>(),
    values: json?["values"] != null ? Map.from(json?["values"]).map((k, v) => MapEntry<String, int>(k, v)) : Map<String, int>(),
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
    percent: json["percent"].toDouble(),
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
    value: json?["value"].toDouble(),
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
    value: json?["value"].toDouble(),
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
  String? imgid;
  dynamic normalize;
  String? rev;
  Sizes? sizes;
  dynamic whiteMagic;
  String? x1;
  String? x2;
  String? y1;
  String? y2;

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
    h: json?["h"].toDouble(),
    w: json?["w"].toDouble(),
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
  double? percentEstimate;
  double? percentMax;
  double? percentMin;
  String? text;
  String? vegan;
  String? vegetarian;

  factory Ingredient.fromJson(Map<String, dynamic>? json) => Ingredient(
    id: json?["id"],
    percentEstimate: json?["percent_estimate"]?.toDouble(),
    percentMax: json?["percent_max"]?.toDouble(),
    percentMin: json?["percent_min"]?.toDouble(),
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
    enPalmOilContentUnknown: json?["en:palm-oil-content-unknown"] != null ? List<String>.from(json?["en:palm-oil-content-unknown"].map((x) => x)) : [],
    enVeganStatusUnknown: json?["en:vegan-status-unknown"] != null ? List<String>.from(json?["en:vegan-status-unknown"].map((x) => x)) : [],
    enVegetarianStatusUnknown: json?["en:vegetarian-status-unknown"] != null ? List<String>.from(json?["en:vegetarian-status-unknown"].map((x) => x)) : [],
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
    the4: json?["4"] != null ? List<List<String>>.from(json?["4"].map((x) => List<String>.from(x.map((x) => x)))) : [],
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
    fruitsVegetablesNutsEstimateFromIngredients100G: json?["fruits-vegetables-nuts-estimate-from-ingredients_100g"]?.toDouble(),
    fruitsVegetablesNutsEstimateFromIngredientsServing: json?["fruits-vegetables-nuts-estimate-from-ingredients_serving"]?.toDouble(),
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
    "fruits-vegetables-nuts-estimate-from-ingredients_serving": fruitsVegetablesNutsEstimateFromIngredientsServing!,
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
