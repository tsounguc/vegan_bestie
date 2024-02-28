//
// class SearchProductModel {
//   SearchProductModel({
//     required this.id,
//     required this.keywords,
//     required this.addedCountriesTags,
//     required this.additivesN,
//     required this.additivesOldN,
//     required this.additivesOldTags,
//     required this.additivesOriginalTags,
//     required this.additivesTags,
//     required this.allergens,
//     required this.allergensFromIngredients,
//     required this.allergensFromUser,
//     required this.allergensHierarchy,
//     required this.allergensLc,
//     required this.allergensTags,
//     required this.aminoAcidsTags,
//     required this.brands,
//     required this.brandsTags,
//     required this.categories,
//     required this.categoriesHierarchy,
//     required this.categoriesLc,
//     required this.categoriesProperties,
//     required this.categoriesPropertiesTags,
//     required this.categoriesTags,
//     required this.checkersTags,
//     required this.citiesTags,
//     required this.code,
//     required this.codesTags,
//     required this.complete,
//     required this.completeness,
//     required this.correctorsTags,
//     required this.countries,
//     required this.countriesHierarchy,
//     required this.countriesLc,
//     required this.countriesTags,
//     required this.createdT,
//     required this.creator,
//     required this.dataQualityBugsTags,
//     required this.dataQualityErrorsTags,
//     required this.dataQualityInfoTags,
//     required this.dataQualityTags,
//     required this.dataQualityWarningsTags,
//     required this.dataSources,
//     required this.dataSourcesTags,
//     required this.debugParamSortedLangs,
//     required this.ecoscoreData,
//     required this.ecoscoreExtendedData,
//     required this.ecoscoreExtendedDataVersion,
//     required this.ecoscoreGrade,
//     required this.ecoscoreTags,
//     required this.editorsTags,
//     required this.embCodes,
//     required this.embCodesTags,
//     required this.entryDatesTags,
//     required this.expirationDate,
//     required this.foodGroupsTags,
//     required this.genericName,
//     required this.genericNameEn,
//     required this.productId,
//     required this.imageFrontSmallUrl,
//     required this.imageFrontThumbUrl,
//     required this.imageFrontUrl,
//     required this.imageIngredientsSmallUrl,
//     required this.imageIngredientsThumbUrl,
//     required this.imageIngredientsUrl,
//     required this.imageNutritionSmallUrl,
//     required this.imageNutritionThumbUrl,
//     required this.imageNutritionUrl,
//     required this.imageSmallUrl,
//     required this.imageThumbUrl,
//     required this.imageUrl,
//     required this.images,
//     required this.informersTags,
//     required this.ingredients,
//     required this.ingredientsAnalysis,
//     required this.ingredientsAnalysisTags,
//     required this.ingredientsFromOrThatMayBeFromPalmOilN,
//     required this.ingredientsFromPalmOilN,
//     required this.ingredientsFromPalmOilTags,
//     required this.ingredientsHierarchy,
//     required this.ingredientsN,
//     required this.ingredientsNTags,
//     required this.ingredientsOriginalTags,
//     required this.ingredientsPercentAnalysis,
//     required this.ingredientsTags,
//     required this.ingredientsText,
//     required this.ingredientsTextEn,
//     required this.ingredientsTextWithAllergens,
//     required this.ingredientsTextWithAllergensEn,
//     required this.ingredientsThatMayBeFromPalmOilN,
//     required this.ingredientsThatMayBeFromPalmOilTags,
//     required this.ingredientsWithSpecifiedPercentN,
//     required this.ingredientsWithSpecifiedPercentSum,
//     required this.ingredientsWithUnspecifiedPercentN,
//     required this.ingredientsWithUnspecifiedPercentSum,
//     required this.interfaceVersionCreated,
//     required this.interfaceVersionModified,
//     required this.knownIngredientsN,
//     required this.labels,
//     required this.labelsHierarchy,
//     required this.labelsLc,
//     required this.labelsTags,
//     required this.lang,
//     required this.languages,
//     required this.languagesCodes,
//     required this.languagesHierarchy,
//     required this.languagesTags,
//     required this.lastEditDatesTags,
//     required this.lastEditor,
//     required this.lastImageDatesTags,
//     required this.lastImageT,
//     required this.lastModifiedBy,
//     required this.lastModifiedT,
//     required this.lc,
//     required this.link,
//     required this.mainCountriesTags,
//     required this.manufacturingPlaces,
//     required this.manufacturingPlacesTags,
//     required this.maxImgid,
//     required this.mineralsTags,
//     required this.miscTags,
//     required this.noNutritionData,
//     required this.novaGroup,
//     required this.novaGroupDebug,
//     required this.novaGroups,
//     required this.novaGroupsMarkers,
//     required this.novaGroupsTags,
//     required this.nucleotidesTags,
//     required this.nutrientLevels,
//     required this.nutrientLevelsTags,
//     required this.nutriments,
//     required this.nutritionData,
//     required this.nutritionDataPer,
//     required this.nutritionDataPrepared,
//     required this.nutritionDataPreparedPer,
//     required this.nutritionGradesTags,
//     required this.nutritionScoreBeverage,
//     required this.nutritionScoreDebug,
//     required this.origins,
//     required this.originsHierarchy,
//     required this.originsLc,
//     required this.originsTags,
//     required this.otherNutritionalSubstancesTags,
//     required this.packaging,
//     required this.packagingHierarchy,
//     required this.packagingLc,
//     required this.packagingOld,
//     required this.packagingTags,
//     required this.packagingText,
//     required this.packagingTextEn,
//     required this.packagings,
//     required this.photographersTags,
//     required this.pnnsGroups1,
//     required this.pnnsGroups1Tags,
//     required this.pnnsGroups2,
//     required this.pnnsGroups2Tags,
//     required this.popularityKey,
//     required this.popularityTags,
//     required this.productName,
//     required this.productNameEn,
//     required this.purchasePlaces,
//     required this.purchasePlacesTags,
//     required this.quantity,
//     required this.removedCountriesTags,
//     required this.rev,
//     required this.scansN,
//     required this.selectedImages,
//     required this.servingQuantity,
//     required this.servingSize,
//     required this.sortkey,
//     required this.states,
//     required this.statesHierarchy,
//     required this.statesTags,
//     required this.stores,
//     required this.storesTags,
//     required this.traces,
//     required this.tracesFromIngredients,
//     required this.tracesFromUser,
//     required this.tracesHierarchy,
//     required this.tracesLc,
//     required this.tracesTags,
//     required this.uniqueScansN,
//     required this.unknownIngredientsN,
//     required this.unknownNutrientsTags,
//     required this.updateKey,
//     required this.vitaminsTags,
//     required this.withSweeteners,
//   });
//   String? id;
//   List<String>? keywords;
//   List<dynamic>? addedCountriesTags;
//   int? additivesN;
//   int? additivesOldN;
//   List<String>? additivesOldTags;
//   List<String>? additivesOriginalTags;
//   List<String>? additivesTags;
//   String? allergens;
//   String? allergensFromIngredients;
//   String? allergensFromUser;
//   List<dynamic>? allergensHierarchy;
//   String? allergensLc;
//   List<dynamic>? allergensTags;
//   List<dynamic>? aminoAcidsTags;
//   String? brands;
//   List<dynamic>? brandsTags;
//   String? categories;
//   List<dynamic>? categoriesHierarchy;
//   String? categoriesLc;
//   CategoriesProperties? categoriesProperties;
//   List<String>? categoriesPropertiesTags;
//   List<dynamic>? categoriesTags;
//   List<dynamic>? checkersTags;
//   List<dynamic>? citiesTags;
//   String? code;
//   List<String>? codesTags;
//   int? complete;
//   double? completeness;
//   List<String>? correctorsTags;
//   String? countries;
//   List<String>? countriesHierarchy;
//   String? countriesLc;
//   List<String>? countriesTags;
//   int? createdT;
//   String? creator;
//   List<dynamic>? dataQualityBugsTags;
//   List<dynamic>? dataQualityErrorsTags;
//   List<String>? dataQualityInfoTags;
//   List<String>? dataQualityTags;
//   List<String>? dataQualityWarningsTags;
//   String? dataSources;
//   List<String>? dataSourcesTags;
//   List<String>? debugParamSortedLangs;
//   EcoscoreData? ecoscoreData;
//   EcoscoreExtendedData? ecoscoreExtendedData;
//   String? ecoscoreExtendedDataVersion;
//   String? ecoscoreGrade;
//   List<String>? ecoscoreTags;
//   List<String>? editorsTags;
//   String? embCodes;
//   List<dynamic>? embCodesTags;
//   List<String>? entryDatesTags;
//   String? expirationDate;
//   List<dynamic>? foodGroupsTags;
//   String? genericName;
//   String? genericNameEn;
//   String? productId;
//   String? imageFrontSmallUrl;
//   String? imageFrontThumbUrl;
//   String? imageFrontUrl;
//   String? imageIngredientsSmallUrl;
//   String? imageIngredientsThumbUrl;
//   String? imageIngredientsUrl;
//   String? imageNutritionSmallUrl;
//   String? imageNutritionThumbUrl;
//   String? imageNutritionUrl;
//   String? imageSmallUrl;
//   String? imageThumbUrl;
//   String? imageUrl;
//   Images? images; // images
//   List<String>? informersTags;
//   List<Ingredient>? ingredients;
//   IngredientsAnalysis? ingredientsAnalysis;
//   List<String>? ingredientsAnalysisTags;
//   int? ingredientsFromOrThatMayBeFromPalmOilN;
//   int? ingredientsFromPalmOilN;
//   List<dynamic>? ingredientsFromPalmOilTags;
//   List<String>? ingredientsHierarchy;
//   dynamic ingredientsN;
//   List<String>? ingredientsNTags;
//   List<String>? ingredientsOriginalTags;
//   int? ingredientsPercentAnalysis;
//   List<String>? ingredientsTags;
//   String? ingredientsText;
//   String? ingredientsTextEn;
//   String? ingredientsTextWithAllergens;
//   String? ingredientsTextWithAllergensEn;
//   int? ingredientsThatMayBeFromPalmOilN;
//   List<dynamic>? ingredientsThatMayBeFromPalmOilTags;
//   double? ingredientsWithSpecifiedPercentN;
//   double? ingredientsWithSpecifiedPercentSum;
//   double? ingredientsWithUnspecifiedPercentN;
//   double? ingredientsWithUnspecifiedPercentSum;
//   String? interfaceVersionCreated;
//   String? interfaceVersionModified;
//   int? knownIngredientsN;
//   String? labels;
//   List<dynamic>? labelsHierarchy;
//   String? labelsLc;
//   List<dynamic>? labelsTags;
//   String? lang;
//   Languages? languages;
//   LanguagesCodes? languagesCodes;
//   List<String>? languagesHierarchy;
//   List<String>? languagesTags;
//   List<String>? lastEditDatesTags;
//   String? lastEditor;
//   List<String>? lastImageDatesTags;
//   int? lastImageT;
//   String? lastModifiedBy;
//   int? lastModifiedT;
//   String? lc;
//   String? link;
//   List<dynamic>? mainCountriesTags;
//   String? manufacturingPlaces;
//   List<dynamic>? manufacturingPlacesTags;
//   dynamic maxImgid;
//   List<dynamic>? mineralsTags;
//   List<String>? miscTags;
//   String? noNutritionData;
//   int? novaGroup;
//   String? novaGroupDebug;
//   String? novaGroups;
//   NovaGroupsMarkers? novaGroupsMarkers;
//   List<String>? novaGroupsTags;
//   List<dynamic>? nucleotidesTags;
//   CategoriesProperties? nutrientLevels;
//   List<dynamic>? nutrientLevelsTags;
//   Nutriments? nutriments;
//   String? nutritionData;
//   String? nutritionDataPer;
//   String? nutritionDataPrepared;
//   String? nutritionDataPreparedPer;
//   List<String>? nutritionGradesTags;
//   int? nutritionScoreBeverage;
//   String? nutritionScoreDebug;
//   String? origins;
//   List<dynamic>? originsHierarchy;
//   String? originsLc;
//   List<dynamic>? originsTags;
//   List<dynamic>? otherNutritionalSubstancesTags;
//   String? packaging;
//   List<dynamic>? packagingHierarchy;
//   String? packagingLc;
//   String? packagingOld;
//   List<dynamic>? packagingTags;
//   String? packagingText;
//   String? packagingTextEn;
//   List<dynamic>? packagings;
//   List<String>? photographersTags;
//   String? pnnsGroups1;
//   List<String>? pnnsGroups1Tags;
//   String? pnnsGroups2;
//   List<String>? pnnsGroups2Tags;
//   int? popularityKey;
//   List<String>? popularityTags;
//   String? productName;
//   String? productNameEn;
//   String? purchasePlaces;
//   List<dynamic>? purchasePlacesTags;
//   String? quantity;
//   List<dynamic>? removedCountriesTags;
//   int? rev;
//   int? scansN;
//   SelectedImages? selectedImages;
//   dynamic servingQuantity;
//   String? servingSize;
//   int? sortkey;
//   String? states;
//   List<String>? statesHierarchy;
//   List<String>? statesTags;
//   String? stores;
//   List<dynamic>? storesTags;
//   String? traces;
//   String? tracesFromIngredients;
//   String? tracesFromUser;
//   List<dynamic>? tracesHierarchy;
//   String? tracesLc;
//   List<dynamic>? tracesTags;
//   dynamic uniqueScansN;
//   dynamic unknownIngredientsN;
//   List<dynamic>? unknownNutrientsTags;
//   String? updateKey;
//   List<dynamic>? vitaminsTags;
//   dynamic withSweeteners;
//
//   factory SearchProductModel.fromJson(Map<String, dynamic>? json) => SearchProductModel(
//         id: json?["_id"],
//         keywords: json?["_keywords"] != null ? List<String>.from(json?["_keywords"].map((x) => x)) : [],
//         addedCountriesTags: json?["added_countries_tags"] != null
//             ? List<dynamic>.from(json?["added_countries_tags"].map((x) => x == null ? "" : x))
//             : [],
//         additivesN: json?["additives_n"],
//         additivesOldN: json?["additives_old_n"],
//         additivesOldTags: json?["additives_old_tags"] != null
//             ? List<String>.from(json?["additives_old_tags"].map((x) => x))
//             : [],
//         additivesOriginalTags: json?["additives_original_tags"] != null
//             ? List<String>.from(json?["additives_original_tags"].map((x) => x))
//             : [],
//         additivesTags:
//             json?["additives_tags"] != null ? List<String>.from(json?["additives_tags"].map((x) => x)) : [],
//         allergens: json?["allergens"],
//         allergensFromIngredients: json?["allergens_from_ingredients"],
//         allergensFromUser: json?["allergens_from_user"],
//         allergensHierarchy: json?["allergens_hierarchy"] != null
//             ? List<dynamic>.from(json?["allergens_hierarchy"].map((x) => x == null ? "" : x))
//             : [],
//         allergensLc: json?["allergens_lc"],
//         allergensTags: json?["allergens_tags"] != null
//             ? List<dynamic>.from(json?["allergens_tags"].map((x) => x == null ? "" : x))
//             : [],
//         aminoAcidsTags: json?["amino_acids_tags"] != null
//             ? List<dynamic>.from(json?["amino_acids_tags"].map((x) => x == null ? "" : x))
//             : [],
//         brands: json?["brands"],
//         brandsTags: json?["brands_tags"] != null
//             ? List<dynamic>.from(json?["brands_tags"].map((x) => x == null ? "" : x))
//             : [],
//         categories: json?["categories"],
//         categoriesHierarchy: json?["categories_hierarchy"] != null
//             ? List<dynamic>.from(json?["categories_hierarchy"].map((x) => x == null ? "" : x))
//             : [],
//         categoriesLc: json?["categories_lc"],
//         categoriesProperties: CategoriesProperties.fromJson(json?["categories_properties"]),
//         categoriesPropertiesTags: json?["categories_properties_tags"] != null
//             ? List<String>.from(json?["categories_properties_tags"].map((x) => x))
//             : [],
//         categoriesTags: json?["categories_tags"] != null
//             ? List<dynamic>.from(json?["categories_tags"].map((x) => x == null ? "" : x))
//             : [],
//         checkersTags: json?["checkers_tags"] != null
//             ? List<dynamic>.from(json?["checkers_tags"].map((x) => x == null ? "" : x))
//             : [],
//         citiesTags: json?["cities_tags"] != null
//             ? List<dynamic>.from(json?["cities_tags"].map((x) => x == null ? "" : x))
//             : [],
//         code: json?["code"],
//         codesTags: json?["codes_tags"] != null ? List<String>.from(json?["codes_tags"].map((x) => x)) : [],
//         complete: json?["complete"],
//         completeness: json?["completeness"]?.toDouble(),
//         correctorsTags:
//             json?["correctors_tags"] != null ? List<String>.from(json?["correctors_tags"].map((x) => x)) : [],
//         countries: json?["countries"],
//         countriesHierarchy: json?["countries_hierarchy"] != null
//             ? List<String>.from(json?["countries_hierarchy"].map((x) => x))
//             : [],
//         countriesLc: json?["countries_lc"],
//         countriesTags:
//             json?["countries_tags"] != null ? List<String>.from(json?["countries_tags"].map((x) => x)) : [],
//         createdT: json?["created_t"],
//         creator: json?["creator"],
//         dataQualityBugsTags: json?["data_quality_bugs_tags"] != null
//             ? List<dynamic>.from(json?["data_quality_bugs_tags"].map((x) => x == null ? "" : x))
//             : [],
//         dataQualityErrorsTags: json?["data_quality_errors_tags"] != null
//             ? List<dynamic>.from(json?["data_quality_errors_tags"].map((x) => x == null ? "" : x))
//             : [],
//         dataQualityInfoTags: json?["data_quality_info_tags"] != null
//             ? List<String>.from(json?["data_quality_info_tags"].map((x) => x))
//             : [],
//         dataQualityTags:
//             json?["data_quality_tags"] != null ? List<String>.from(json?["data_quality_tags"].map((x) => x)) : [],
//         dataQualityWarningsTags: json?["data_quality_warnings_tags"] != null
//             ? List<String>.from(json?["data_quality_warnings_tags"].map((x) => x))
//             : [],
//         dataSources: json?["data_sources"],
//         dataSourcesTags:
//             json?["data_sources_tags"] != null ? List<String>.from(json?["data_sources_tags"].map((x) => x)) : [],
//         debugParamSortedLangs: json?["debug_param_sorted_langs"] != null
//             ? List<String>.from(json?["debug_param_sorted_langs"].map((x) => x))
//             : [],
//         ecoscoreData: EcoscoreData.fromJson(json?["ecoscore_data"]),
//         ecoscoreExtendedData: EcoscoreExtendedData.fromJson(json?["ecoscore_extended_data"]),
//         ecoscoreExtendedDataVersion: json?["ecoscore_extended_data_version"],
//         ecoscoreGrade: json?["ecoscore_grade"],
//         ecoscoreTags:
//             json?["ecoscore_tags"] != null ? List<String>.from(json?["ecoscore_tags"].map((x) => x)) : [],
//         editorsTags: json?["editors_tags"] != null ? List<String>.from(json?["editors_tags"].map((x) => x)) : [],
//         embCodes: json?["emb_codes"],
//         embCodesTags: json?["emb_codes_tags"] != null
//             ? List<dynamic>.from(json?["emb_codes_tags"].map((x) => x == null ? "" : x))
//             : [],
//         entryDatesTags:
//             json?["entry_dates_tags"] != null ? List<String>.from(json?["entry_dates_tags"].map((x) => x)) : [],
//         expirationDate: json?["expiration_date"],
//         foodGroupsTags: json?["food_groups_tags"] != null
//             ? List<dynamic>.from(json?["food_groups_tags"].map((x) => x == null ? "" : x))
//             : [],
//         genericName: json?["generic_name"],
//         genericNameEn: json?["generic_name_en"],
//         productId: json?["id"],
//         imageFrontSmallUrl: json?["image_front_small_url"],
//         imageFrontThumbUrl: json?["image_front_thumb_url"],
//         imageFrontUrl: json?["image_front_url"],
//         imageIngredientsSmallUrl: json?["image_ingredients_small_url"],
//         imageIngredientsThumbUrl: json?["image_ingredients_thumb_url"],
//         imageIngredientsUrl: json?["image_ingredients_url"],
//         imageNutritionSmallUrl: json?["image_nutrition_small_url"],
//         imageNutritionThumbUrl: json?["image_nutrition_thumb_url"],
//         imageNutritionUrl: json?["image_nutrition_url"],
//         imageSmallUrl: json?["image_small_url"],
//         imageThumbUrl: json?["image_thumb_url"],
//         imageUrl: json?["image_url"],
//         images: Images.fromJson(json?["images"]),
//         informersTags:
//             json?["informers_tags"] != null ? List<String>.from(json?["informers_tags"].map((x) => x)) : [],
//         ingredients: json?["ingredients"] != null
//             ? List<Ingredient>.from(json?["ingredients"].map((x) => Ingredient.fromJson(x)))
//             : [],
//         ingredientsAnalysis: IngredientsAnalysis.fromJson(json?["ingredients_analysis"]),
//         ingredientsAnalysisTags: json?["ingredients_analysis_tags"] != null
//             ? List<String>.from(json?["ingredients_analysis_tags"].map((x) => x))
//             : [],
//         ingredientsFromOrThatMayBeFromPalmOilN: json?["ingredients_from_or_that_may_be_from_palm_oil_n"],
//         ingredientsFromPalmOilN: json?["ingredients_from_palm_oil_n"],
//         ingredientsFromPalmOilTags: json?["ingredients_from_palm_oil_tags"] != null
//             ? List<dynamic>.from(json?["ingredients_from_palm_oil_tags"].map((x) => x == null ? "" : x))
//             : [],
//         ingredientsHierarchy: json?["ingredients_hierarchy"] != null
//             ? List<String>.from(json?["ingredients_hierarchy"].map((x) => x))
//             : [],
//         ingredientsN: json?["ingredients_n"],
//         ingredientsNTags: json?["ingredients_n_tags"] != null
//             ? List<String>.from(json?["ingredients_n_tags"].map((x) => x))
//             : [],
//         ingredientsOriginalTags: json?["ingredients_original_tags"] != null
//             ? List<String>.from(json?["ingredients_original_tags"].map((x) => x))
//             : [],
//         ingredientsPercentAnalysis: json?["ingredients_percent_analysis"],
//         ingredientsTags:
//             json?["ingredients_tags"] != null ? List<String>.from(json?["ingredients_tags"].map((x) => x)) : [],
//         ingredientsText: json?["ingredients_text"],
//         ingredientsTextEn: json?["ingredients_text_en"],
//         ingredientsTextWithAllergens: json?["ingredients_text_with_allergens"],
//         ingredientsTextWithAllergensEn: json?["ingredients_text_with_allergens_en"],
//         ingredientsThatMayBeFromPalmOilN: json?["ingredients_that_may_be_from_palm_oil_n"],
//         ingredientsThatMayBeFromPalmOilTags: json?["ingredients_that_may_be_from_palm_oil_tags"] != null
//             ? List<dynamic>.from(
//                 json?["ingredients_that_may_be_from_palm_oil_tags"].map((x) => x == null ? "" : x))
//             : [],
//         ingredientsWithSpecifiedPercentN: json?["ingredients_with_specified_percent_n"]?.toDouble(),
//         ingredientsWithSpecifiedPercentSum: json?["ingredients_with_specified_percent_sum"]?.toDouble(),
//         ingredientsWithUnspecifiedPercentN: json?["ingredients_with_unspecified_percent_n"]?.toDouble(),
//         ingredientsWithUnspecifiedPercentSum: json?["ingredients_with_unspecified_percent_sum"]?.toDouble(),
//         interfaceVersionCreated: json?["interface_version_created"],
//         interfaceVersionModified: json?["interface_version_modified"],
//         knownIngredientsN: json?["known_ingredients_n"],
//         labels: json?["labels"],
//         labelsHierarchy: json?["labels_hierarchy"] != null
//             ? List<dynamic>.from(json?["labels_hierarchy"].map((x) => x == null ? "" : x))
//             : [],
//         labelsLc: json?["labels_lc"],
//         labelsTags: json?["labels_tags"] != null
//             ? List<dynamic>.from(json?["labels_tags"].map((x) => x == null ? "" : x))
//             : [],
//         lang: json?["lang"],
//         languages: Languages.fromJson(json?["languages"]),
//         languagesCodes: LanguagesCodes.fromJson(json?["languages_codes"]),
//         languagesHierarchy: json?["languages_hierarchy"] != null
//             ? List<String>.from(json?["languages_hierarchy"].map((x) => x))
//             : [],
//         languagesTags:
//             json?["languages_tags"] != null ? List<String>.from(json?["languages_tags"].map((x) => x)) : [],
//         lastEditDatesTags: json?["last_edit_dates_tags"] != null
//             ? List<String>.from(json?["last_edit_dates_tags"].map((x) => x))
//             : [],
//         lastEditor: json?["last_editor"],
//         lastImageDatesTags: json?["last_image_dates_tags"] != null
//             ? List<String>.from(json?["last_image_dates_tags"].map((x) => x))
//             : [],
//         lastImageT: json?["last_image_t"],
//         lastModifiedBy: json?["last_modified_by"],
//         lastModifiedT: json?["last_modified_t"],
//         lc: json?["lc"],
//         link: json?["link"],
//         mainCountriesTags: json?["main_countries_tags"] != null
//             ? List<dynamic>.from(json?["main_countries_tags"].map((x) => x == null ? "" : x))
//             : [],
//         manufacturingPlaces: json?["manufacturing_places"],
//         manufacturingPlacesTags: json?["manufacturing_places_tags"] != null
//             ? List<dynamic>.from(json?["manufacturing_places_tags"].map((x) => x == null ? "" : x))
//             : [],
//         maxImgid: json?["max_imgid"],
//         mineralsTags: json?["minerals_tags"] != null
//             ? List<dynamic>.from(json?["minerals_tags"].map((x) => x == null ? "" : x))
//             : [],
//         miscTags: json?["misc_tags"] != null ? List<String>.from(json?["misc_tags"].map((x) => x)) : [],
//         noNutritionData: json?["no_nutrition_data"],
//         novaGroup: json?["nova_group"],
//         novaGroupDebug: json?["nova_group_debug"],
//         novaGroups: json?["nova_groups"],
//         novaGroupsMarkers: NovaGroupsMarkers.fromJson(json?["nova_groups_markers"]),
//         novaGroupsTags:
//             json?["nova_groups_tags"] != null ? List<String>.from(json?["nova_groups_tags"].map((x) => x)) : [],
//         nucleotidesTags: json?["nucleotides_tags"] != null
//             ? List<dynamic>.from(json?["nucleotides_tags"].map((x) => x == null ? "" : x))
//             : [],
//         nutrientLevels: CategoriesProperties.fromJson(json?["nutrient_levels"]),
//         nutrientLevelsTags: json?["nutrient_levels_tags"] != null
//             ? List<dynamic>.from(json?["nutrient_levels_tags"].map((x) => x == null ? "" : x))
//             : [],
//         nutriments: Nutriments.fromJson(json?["nutriments"]),
//         nutritionData: json?["nutrition_data"],
//         nutritionDataPer: json?["nutrition_data_per"],
//         nutritionDataPrepared: json?["nutrition_data_prepared"],
//         nutritionDataPreparedPer: json?["nutrition_data_prepared_per"],
//         nutritionGradesTags: json?["nutrition_grades_tags"] != null
//             ? List<String>.from(json?["nutrition_grades_tags"].map((x) => x))
//             : [],
//         nutritionScoreBeverage: json?["nutrition_score_beverage"],
//         nutritionScoreDebug: json?["nutrition_score_debug"],
//         origins: json?["origins"],
//         originsHierarchy: json?["origins_hierarchy"] != null
//             ? List<dynamic>.from(json?["origins_hierarchy"].map((x) => x == null ? "" : x))
//             : [],
//         originsLc: json?["origins_lc"],
//         originsTags: json?["origins_tags"] != null
//             ? List<dynamic>.from(json?["origins_tags"].map((x) => x == null ? "" : x))
//             : [],
//         otherNutritionalSubstancesTags: json?["other_nutritional_substances_tags"] != null
//             ? List<dynamic>.from(json?["other_nutritional_substances_tags"].map((x) => x == null ? "" : x))
//             : [],
//         packaging: json?["packaging"],
//         packagingHierarchy: json?["packaging_hierarchy"] != null
//             ? List<dynamic>.from(json?["packaging_hierarchy"].map((x) => x == null ? "" : x))
//             : [],
//         packagingLc: json?["packaging_lc"],
//         packagingOld: json?["packaging_old"],
//         packagingTags: json?["packaging_tags"] != null
//             ? List<dynamic>.from(json?["packaging_tags"].map((x) => x == null ? "" : x))
//             : [],
//         packagingText: json?["packaging_text"],
//         packagingTextEn: json?["packaging_text_en"],
//         packagings: json?["packagings"] != null
//             ? List<dynamic>.from(json?["packagings"].map((x) => x == null ? "" : x))
//             : [],
//         photographersTags: json?["photographers_tags"] != null
//             ? List<String>.from(json?["photographers_tags"].map((x) => x))
//             : [],
//         pnnsGroups1: json?["pnns_groups_1"],
//         pnnsGroups1Tags: json?["pnns_groups_1_tags"] != null
//             ? List<String>.from(json?["pnns_groups_1_tags"].map((x) => x))
//             : [],
//         pnnsGroups2: json?["pnns_groups_2"],
//         pnnsGroups2Tags: json?["pnns_groups_2_tags"] != null
//             ? List<String>.from(json?["pnns_groups_2_tags"].map((x) => x))
//             : [],
//         popularityKey: json?["popularity_key"],
//         popularityTags:
//             json?["popularity_tags"] != null ? List<String>.from(json?["popularity_tags"].map((x) => x)) : [],
//         productName: json?["product_name"],
//         productNameEn: json?["product_name_en"],
//         purchasePlaces: json?["purchase_places"],
//         purchasePlacesTags: json?["purchase_places_tags"] != null
//             ? List<dynamic>.from(json?["purchase_places_tags"].map((x) => x == null ? "" : x))
//             : [],
//         quantity: json?["quantity"],
//         removedCountriesTags: json?["removed_countries_tags"] != null
//             ? List<dynamic>.from(json?["removed_countries_tags"].map((x) => x == null ? "" : x))
//             : [],
//         rev: json?["rev"],
//         scansN: json?["scans_n"],
//         selectedImages: SelectedImages.fromJson(json?["selected_images"]),
//         servingQuantity: json?["serving_quantity"],
//         servingSize: json?["serving_size"],
//         sortkey: json?["sortkey"],
//         states: json?["states"],
//         statesHierarchy:
//             json?["states_hierarchy"] != null ? List<String>.from(json?["states_hierarchy"].map((x) => x)) : [],
//         statesTags: json?["states_tags"] != null ? List<String>.from(json?["states_tags"].map((x) => x)) : [],
//         stores: json?["stores"],
//         storesTags: json?["stores_tags"] != null
//             ? List<dynamic>.from(json?["stores_tags"].map((x) => x == null ? "" : x))
//             : [],
//         traces: json?["traces"],
//         tracesFromIngredients: json?["traces_from_ingredients"],
//         tracesFromUser: json?["traces_from_user"],
//         tracesHierarchy: json?["traces_hierarchy"] != null
//             ? List<dynamic>.from(json?["traces_hierarchy"].map((x) => x == null ? "" : x))
//             : [],
//         tracesLc: json?["traces_lc"],
//         tracesTags: json?["traces_tags"] != null
//             ? List<dynamic>.from(json?["traces_tags"].map((x) => x == null ? "" : x))
//             : [],
//         uniqueScansN: json?["unique_scans_n"],
//         unknownIngredientsN: json?["unknown_ingredients_n"],
//         unknownNutrientsTags: json?["unknown_nutrients_tags"] != null
//             ? List<dynamic>.from(json?["unknown_nutrients_tags"].map((x) => x == null ? "" : x))
//             : [],
//         updateKey: json?["update_key"],
//         vitaminsTags: json?["vitamins_tags"] != null
//             ? List<dynamic>.from(json?["vitamins_tags"].map((x) => x == null ? "" : x))
//             : [],
//         withSweeteners: json?["with_sweeteners"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id!,
//         "_keywords": List<dynamic>.from(keywords!.map((x) => x)),
//         "added_countries_tags": List<dynamic>.from(addedCountriesTags!.map((x) => x)),
//         "additives_n": additivesN!,
//         "additives_old_n": additivesOldN!,
//         "additives_old_tags": List<dynamic>.from(additivesOldTags!.map((x) => x)),
//         "additives_original_tags": List<dynamic>.from(additivesOriginalTags!.map((x) => x)),
//         "additives_tags": List<dynamic>.from(additivesTags!.map((x) => x)),
//         "allergens": allergens!,
//         "allergens_from_ingredients": allergensFromIngredients!,
//         "allergens_from_user": allergensFromUser!,
//         "allergens_hierarchy": List<dynamic>.from(allergensHierarchy!.map((x) => x)),
//         "allergens_lc": allergensLc!,
//         "allergens_tags": List<dynamic>.from(allergensTags!.map((x) => x)),
//         "amino_acids_tags": List<dynamic>.from(aminoAcidsTags!.map((x) => x)),
//         "brands": brands!,
//         "brands_tags": List<dynamic>.from(brandsTags!.map((x) => x)),
//         "categories": categories!,
//         "categories_hierarchy": List<dynamic>.from(categoriesHierarchy!.map((x) => x)),
//         "categories_lc": categoriesLc!,
//         "categories_properties": categoriesProperties!.toJson(),
//         "categories_properties_tags": List<dynamic>.from(categoriesPropertiesTags!.map((x) => x)),
//         "categories_tags": List<dynamic>.from(categoriesTags!.map((x) => x)),
//         "checkers_tags": List<dynamic>.from(checkersTags!.map((x) => x)),
//         "cities_tags": List<dynamic>.from(citiesTags!.map((x) => x)),
//         "code": code!,
//         "codes_tags": List<dynamic>.from(codesTags!.map((x) => x)),
//         "complete": complete!,
//         "completeness": completeness!,
//         "correctors_tags": List<dynamic>.from(correctorsTags!.map((x) => x)),
//         "countries": countries!,
//         "countries_hierarchy": List<dynamic>.from(countriesHierarchy!.map((x) => x)),
//         "countries_lc": countriesLc!,
//         "countries_tags": List<dynamic>.from(countriesTags!.map((x) => x)),
//         "created_t": createdT!,
//         "creator": creator!,
//         "data_quality_bugs_tags": List<dynamic>.from(dataQualityBugsTags!.map((x) => x)),
//         "data_quality_errors_tags": List<dynamic>.from(dataQualityErrorsTags!.map((x) => x)),
//         "data_quality_info_tags": List<dynamic>.from(dataQualityInfoTags!.map((x) => x)),
//         "data_quality_tags": List<dynamic>.from(dataQualityTags!.map((x) => x)),
//         "data_quality_warnings_tags": List<dynamic>.from(dataQualityWarningsTags!.map((x) => x)),
//         "data_sources": dataSources!,
//         "data_sources_tags": List<dynamic>.from(dataSourcesTags!.map((x) => x)),
//         "debug_param_sorted_langs": List<dynamic>.from(debugParamSortedLangs!.map((x) => x)),
//         "ecoscore_data": ecoscoreData!.toJson(),
//         "ecoscore_extended_data": ecoscoreExtendedData!.toJson(),
//         "ecoscore_extended_data_version": ecoscoreExtendedDataVersion!,
//         "ecoscore_grade": ecoscoreGrade!,
//         "ecoscore_tags": List<dynamic>.from(ecoscoreTags!.map((x) => x)),
//         "editors_tags": List<dynamic>.from(editorsTags!.map((x) => x)),
//         "emb_codes": embCodes!,
//         "emb_codes_tags": List<dynamic>.from(embCodesTags!.map((x) => x)),
//         "entry_dates_tags": List<dynamic>.from(entryDatesTags!.map((x) => x)),
//         "expiration_date": expirationDate!,
//         "food_groups_tags": List<dynamic>.from(foodGroupsTags!.map((x) => x)),
//         "generic_name": genericName!,
//         "generic_name_en": genericNameEn!,
//         "id": productId!,
//         "image_front_small_url": imageFrontSmallUrl!,
//         "image_front_thumb_url": imageFrontThumbUrl!,
//         "image_front_url": imageFrontUrl!,
//         "image_ingredients_small_url": imageIngredientsSmallUrl!,
//         "image_ingredients_thumb_url": imageIngredientsThumbUrl!,
//         "image_ingredients_url": imageIngredientsUrl!,
//         "image_nutrition_small_url": imageNutritionSmallUrl!,
//         "image_nutrition_thumb_url": imageNutritionThumbUrl!,
//         "image_nutrition_url": imageNutritionUrl!,
//         "image_small_url": imageSmallUrl!,
//         "image_thumb_url": imageThumbUrl!,
//         "image_url": imageUrl!,
//         "images": images!.toJson(),
//         "informers_tags": List<dynamic>.from(informersTags!.map((x) => x)),
//         "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
//         "ingredients_analysis": ingredientsAnalysis!.toJson(),
//         "ingredients_analysis_tags": List<dynamic>.from(ingredientsAnalysisTags!.map((x) => x)),
//         "ingredients_from_or_that_may_be_from_palm_oil_n": ingredientsFromOrThatMayBeFromPalmOilN,
//         "ingredients_from_palm_oil_n": ingredientsFromPalmOilN!,
//         "ingredients_from_palm_oil_tags": List<dynamic>.from(ingredientsFromPalmOilTags!.map((x) => x)),
//         "ingredients_hierarchy": List<dynamic>.from(ingredientsHierarchy!.map((x) => x)),
//         "ingredients_n": ingredientsN!,
//         "ingredients_n_tags": List<dynamic>.from(ingredientsNTags!.map((x) => x)),
//         "ingredients_original_tags": List<dynamic>.from(ingredientsOriginalTags!.map((x) => x)),
//         "ingredients_percent_analysis": ingredientsPercentAnalysis,
//         "ingredients_tags": List<dynamic>.from(ingredientsTags!.map((x) => x)),
//         "ingredients_text": ingredientsText!,
//         "ingredients_text_en": ingredientsTextEn!,
//         "ingredients_text_with_allergens": ingredientsTextWithAllergens!,
//         "ingredients_text_with_allergens_en": ingredientsTextWithAllergensEn!,
//         "ingredients_that_may_be_from_palm_oil_n": ingredientsThatMayBeFromPalmOilN!,
//         "ingredients_that_may_be_from_palm_oil_tags":
//             List<dynamic>.from(ingredientsThatMayBeFromPalmOilTags!.map((x) => x)),
//         "ingredients_with_specified_percent_n": ingredientsWithSpecifiedPercentN!,
//         "ingredients_with_specified_percent_sum": ingredientsWithSpecifiedPercentSum!,
//         "ingredients_with_unspecified_percent_n": ingredientsWithUnspecifiedPercentN!,
//         "ingredients_with_unspecified_percent_sum": ingredientsWithUnspecifiedPercentSum!,
//         "interface_version_created": interfaceVersionCreated!,
//         "interface_version_modified": interfaceVersionModified!,
//         "known_ingredients_n": knownIngredientsN!,
//         "labels": labels!,
//         "labels_hierarchy": List<dynamic>.from(labelsHierarchy!.map((x) => x)),
//         "labels_lc": labelsLc,
//         "labels_tags": List<dynamic>.from(labelsTags!.map((x) => x)),
//         "lang": lang,
//         "languages": languages!.toJson(),
//         "languages_codes": languagesCodes!.toJson(),
//         "languages_hierarchy": List<dynamic>.from(languagesHierarchy!.map((x) => x)),
//         "languages_tags": List<dynamic>.from(languagesTags!.map((x) => x)),
//         "last_edit_dates_tags": List<dynamic>.from(lastEditDatesTags!.map((x) => x)),
//         "last_editor": lastEditor!,
//         "last_image_dates_tags": List<dynamic>.from(lastImageDatesTags!.map((x) => x)),
//         "last_image_t": lastImageT!,
//         "last_modified_by": lastModifiedBy!,
//         "last_modified_t": lastModifiedT!,
//         "lc": lc!,
//         "link": link!,
//         "main_countries_tags": List<dynamic>.from(mainCountriesTags!.map((x) => x)),
//         "manufacturing_places": manufacturingPlaces,
//         "manufacturing_places_tags": List<dynamic>.from(manufacturingPlacesTags!.map((x) => x)),
//         "max_imgid": maxImgid,
//         "minerals_tags": List<dynamic>.from(mineralsTags!.map((x) => x)),
//         "misc_tags": List<dynamic>.from(miscTags!.map((x) => x)),
//         "no_nutrition_data": noNutritionData!,
//         "nova_group": novaGroup!,
//         "nova_group_debug": novaGroupDebug!,
//         "nova_groups": novaGroups!,
//         "nova_groups_markers": novaGroupsMarkers!.toJson(),
//         "nova_groups_tags": List<dynamic>.from(novaGroupsTags!.map((x) => x)),
//         "nucleotides_tags": List<dynamic>.from(nucleotidesTags!.map((x) => x)),
//         "nutrient_levels": nutrientLevels!.toJson(),
//         "nutrient_levels_tags": List<dynamic>.from(nutrientLevelsTags!.map((x) => x)),
//         "nutriments": nutriments!.toJson(),
//         "nutrition_data": nutritionData!,
//         "nutrition_data_per": nutritionDataPer!,
//         "nutrition_data_prepared": nutritionDataPrepared!,
//         "nutrition_data_prepared_per": nutritionDataPreparedPer!,
//         "nutrition_grades_tags": List<dynamic>.from(nutritionGradesTags!.map((x) => x)),
//         "nutrition_score_beverage": nutritionScoreBeverage!,
//         "nutrition_score_debug": nutritionScoreDebug!,
//         "origins": origins!,
//         "origins_hierarchy": List<dynamic>.from(originsHierarchy!.map((x) => x)),
//         "origins_lc": originsLc!,
//         "origins_tags": List<dynamic>.from(originsTags!.map((x) => x)),
//         "other_nutritional_substances_tags": List<dynamic>.from(otherNutritionalSubstancesTags!.map((x) => x)),
//         "packaging": packaging!,
//         "packaging_hierarchy": List<dynamic>.from(packagingHierarchy!.map((x) => x)),
//         "packaging_lc": packagingLc!,
//         "packaging_old": packagingOld!,
//         "packaging_tags": List<dynamic>.from(packagingTags!.map((x) => x)),
//         "packaging_text": packagingText!,
//         "packaging_text_en": packagingTextEn!,
//         "packagings": List<dynamic>.from(packagings!.map((x) => x)),
//         "photographers_tags": List<dynamic>.from(photographersTags!.map((x) => x)),
//         "pnns_groups_1": pnnsGroups1!,
//         "pnns_groups_1_tags": List<dynamic>.from(pnnsGroups1Tags!.map((x) => x)),
//         "pnns_groups_2": pnnsGroups2!,
//         "pnns_groups_2_tags": List<dynamic>.from(pnnsGroups2Tags!.map((x) => x)),
//         "popularity_key": popularityKey!,
//         "popularity_tags": List<dynamic>.from(popularityTags!.map((x) => x)),
//         "product_name": productName!,
//         "product_name_en": productNameEn!,
//         "purchase_places": purchasePlaces!,
//         "purchase_places_tags": List<dynamic>.from(purchasePlacesTags!.map((x) => x)),
//         "quantity": quantity!,
//         "removed_countries_tags": List<dynamic>.from(removedCountriesTags!.map((x) => x)),
//         "rev": rev!,
//         "scans_n": scansN!,
//         "selected_images": selectedImages!.toJson(),
//         "serving_quantity": servingQuantity!,
//         "serving_size": servingSize!,
//         "sortkey": sortkey!,
//         "states": states!,
//         "states_hierarchy": List<dynamic>.from(statesHierarchy!.map((x) => x)),
//         "states_tags": List<dynamic>.from(statesTags!.map((x) => x)),
//         "stores": stores!,
//         "stores_tags": List<dynamic>.from(storesTags!.map((x) => x)),
//         "traces": traces!,
//         "traces_from_ingredients": tracesFromIngredients!,
//         "traces_from_user": tracesFromUser!,
//         "traces_hierarchy": List<dynamic>.from(tracesHierarchy!.map((x) => x)),
//         "traces_lc": tracesLc!,
//         "traces_tags": List<dynamic>.from(tracesTags!.map((x) => x)),
//         "unique_scans_n": uniqueScansN!,
//         "unknown_ingredients_n": unknownIngredientsN!,
//         "unknown_nutrients_tags": List<dynamic>.from(unknownNutrientsTags!.map((x) => x)),
//         "update_key": updateKey!,
//         "vitamins_tags": List<dynamic>.from(vitaminsTags!.map((x) => x)),
//         "with_sweeteners": withSweeteners!,
//       };
// }
