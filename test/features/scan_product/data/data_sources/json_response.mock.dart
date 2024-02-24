const jsonResponse = '''
{
  "code": "0025293600232",
  "product": {
  "_id": "0025293600232",
  "_keywords": [],
  "added_countries_tags": [],
  "additives_debug_tags": [
  "en-e170-removed"
  ],
  "additives_n": 1,
  "additives_old_n": 1,
  "additives_old_tags": [
  "en:e418"
  ],
  "additives_original_tags": [
  "en:e418"
  ],
  "additives_prev_original_tags": [
  "en:e170",
  "en:e418"
  ],
  "additives_tags": [
  "en:e418"
  ],
  "allergens": "en:soybeans",
  "allergens_from_ingredients": "en:soybeans",
  "allergens_from_user": "(en) en:soybeans",
  "allergens_hierarchy": [
  "en:soybeans"
  ],
  "allergens_lc": "en",
  "allergens_tags": [
  "en:soybeans"
  ],
  "amino_acids_prev_tags": [],
  "amino_acids_tags": [],
  "brand_owner": "WWF Operating Company",
  "brand_owner_imported": "WWF Operating Company",
  "brands": "Silk",
  "brands_tags": [
  "silk"
  ],
  "categories": "Plant-based foods and beverages, Beverages, Plant-based foods, Legumes and their products, Dairy substitutes, Milk substitutes, Plant-based beverages, Plant-based milk alternatives, Legume-based drinks, Soy-based drinks, Unsweetened plain soy-based drinks",
  "categories_hierarchy": [
  "en:plant-based-foods-and-beverages",
  "en:beverages",
  "en:plant-based-foods",
  "en:legumes-and-their-products",
  "en:dairy-substitutes",
  "en:milk-substitutes",
  "en:plant-based-beverages",
  "en:plant-based-milk-alternatives",
  "en:legume-based-drinks",
  "en:soy-based-drinks",
  "en:unsweetened-plain-soy-based-drinks"
  ],
  "categories_imported": "Plant-based foods and beverages, Beverages, Plant-based beverages, Milk substitute, Plant milks",
  "categories_lc": "en",
  "categories_old": "Plant-based foods and beverages, Beverages, Plant-based foods, Legumes and their products, Dairy substitutes, Milk substitutes, Plant-based beverages, Plant-based milk alternatives, Legume-based drinks, Soy-based drinks, Unsweetened plain soy-based drinks",
  "categories_properties": {
  "agribalyse_food_code:en": "18900",
  "ciqual_food_code:en": "18900"
  },
  "categories_properties_tags": [
  "all-products",
  "categories-known",
  "agribalyse-food-code-18900",
  "agribalyse-food-code-known",
  "agribalyse-proxy-food-code-unknown",
  "ciqual-food-code-18900",
  "ciqual-food-code-known",
  "agribalyse-known",
  "agribalyse-18900"
  ],
  "categories_tags": [
  "en:plant-based-foods-and-beverages",
  "en:beverages",
  "en:plant-based-foods",
  "en:legumes-and-their-products",
  "en:dairy-substitutes",
  "en:milk-substitutes",
  "en:plant-based-beverages",
  "en:plant-based-milk-alternatives",
  "en:legume-based-drinks",
  "en:soy-based-drinks",
  "en:unsweetened-plain-soy-based-drinks"
  ],
  "category_properties": {
  "ciqual_food_name:en": "Soy drink, plain",
  "ciqual_food_name:fr": "Boisson au soja, nature"
  },
  "checkers_tags": [],
  "ciqual_food_name_tags": [
  "soy-drink-plain"
  ],
  "cities_tags": [],
  "code": "0025293600232",
  "codes_tags": [
  "code-13",
  "0025293600xxx",
  "002529360xxxx",
  "00252936xxxxx",
  "0025293xxxxxx",
  "002529xxxxxxx",
  "00252xxxxxxxx",
  "0025xxxxxxxxx",
  "002xxxxxxxxxx",
  "00xxxxxxxxxxx",
  "0xxxxxxxxxxxx"
  ],
  "compared_to_category": "en:unsweetened-plain-soy-based-drinks",
  "complete": 0,
  "completeness": 0.775,
  "correctors_tags": [
  "moon-rabbit",
  "inf",
  "org-database-usda",
  "swipe-studio",
  "waistline-app",
  "teolemon",
  "tmbe7",
  "mariacastiel"
  ],
  "countries": "United States",
  "countries_hierarchy": [
  "en:united-states"
  ],
  "countries_imported": "United States",
  "countries_lc": "en",
  "countries_tags": [
  "en:united-states"
  ],
  "created_t": 1489079755,
  "creator": "usda-ndb-import",
  "data_quality_bugs_tags": [],
  "data_quality_errors_tags": [],
  "data_quality_info_tags": [
  "en:no-packaging-data",
  "en:ingredients-percent-analysis-ok",
  "en:ecoscore-extended-data-not-computed",
  "en:food-groups-1-known",
  "en:food-groups-2-known",
  "en:food-groups-3-unknown"
  ],
  "data_quality_tags": [
  "en:no-packaging-data",
  "en:ingredients-percent-analysis-ok",
  "en:ecoscore-extended-data-not-computed",
  "en:food-groups-1-known",
  "en:food-groups-2-known",
  "en:food-groups-3-unknown",
  "en:ecoscore-origins-of-ingredients-origins-are-100-percent-unknown",
  "en:ecoscore-packaging-packaging-data-missing",
  "en:ecoscore-production-system-no-label"
  ],
  "data_quality_warnings_tags": [
  "en:ecoscore-origins-of-ingredients-origins-are-100-percent-unknown",
  "en:ecoscore-packaging-packaging-data-missing",
  "en:ecoscore-production-system-no-label"
  ],
  "data_sources": "Databases, database-usda, App - Horizon, App - InFood, Apps, Database - USDA NDB, App - Waistline",
  "data_sources_imported": "Databases, database-usda",
  "data_sources_tags": [
  "databases",
  "database-usda",
  "app-horizon",
  "app-infood",
  "apps",
  "database-usda-ndb",
  "app-waistline"
  ],
  "debug_param_sorted_langs": [
  "en"
  ],
  "ecoscore_data": {
  "adjustments": {
  "origins_of_ingredients": {
  "aggregated_origins": [
  {
  "epi_score": "0",
  "origin": "en:unknown",
  "percent": 100,
  "transportation_score": null
  }
  ],
  "epi_score": 0,
  "epi_value": -5,
  "origins_from_categories": [
  "en:unknown"
  ],
  "origins_from_origins_field": [
  "en:unknown"
  ],
  "transportation_score": 0,
  "transportation_scores": {
  "ad": 0,
  "al": 0,
  "at": 0,
  "ax": 0,
  "ba": 0,
  "be": 0,
  "bg": 0,
  "ch": 0,
  "cy": 0,
  "cz": 0,
  "de": 0,
  "dk": 0,
  "dz": 0,
  "ee": 0,
  "eg": 0,
  "es": 0,
  "fi": 0,
  "fo": 0,
  "fr": 0,
  "gg": 0,
  "gi": 0,
  "gr": 0,
  "hr": 0,
  "hu": 0,
  "ie": 0,
  "il": 0,
  "im": 0,
  "is": 0,
  "it": 0,
  "je": 0,
  "lb": 0,
  "li": 0,
  "lt": 0,
  "lu": 0,
  "lv": 0,
  "ly": 0,
  "ma": 0,
  "mc": 0,
  "md": 0,
  "me": 0,
  "mk": 0,
  "mt": 0,
  "nl": 0,
  "no": 0,
  "pl": 0,
  "ps": 0,
  "pt": 0,
  "ro": 0,
  "rs": 0,
  "se": 0,
  "si": 0,
  "sj": 0,
  "sk": 0,
  "sm": 0,
  "sy": 0,
  "tn": 0,
  "tr": 0,
  "ua": 0,
  "uk": 0,
  "us": 0,
  "va": 0,
  "world": 0,
  "xk": 0
  },
  "transportation_value": 0,
  "transportation_values": {
  "ad": 0,
  "al": 0,
  "at": 0,
  "ax": 0,
  "ba": 0,
  "be": 0,
  "bg": 0,
  "ch": 0,
  "cy": 0,
  "cz": 0,
  "de": 0,
  "dk": 0,
  "dz": 0,
  "ee": 0,
  "eg": 0,
  "es": 0,
  "fi": 0,
  "fo": 0,
  "fr": 0,
  "gg": 0,
  "gi": 0,
  "gr": 0,
  "hr": 0,
  "hu": 0,
  "ie": 0,
  "il": 0,
  "im": 0,
  "is": 0,
  "it": 0,
  "je": 0,
  "lb": 0,
  "li": 0,
  "lt": 0,
  "lu": 0,
  "lv": 0,
  "ly": 0,
  "ma": 0,
  "mc": 0,
  "md": 0,
  "me": 0,
  "mk": 0,
  "mt": 0,
  "nl": 0,
  "no": 0,
  "pl": 0,
  "ps": 0,
  "pt": 0,
  "ro": 0,
  "rs": 0,
  "se": 0,
  "si": 0,
  "sj": 0,
  "sk": 0,
  "sm": 0,
  "sy": 0,
  "tn": 0,
  "tr": 0,
  "ua": 0,
  "uk": 0,
  "us": 0,
  "va": 0,
  "world": 0,
  "xk": 0
  },
  "value": -5,
  "values": {
  "ad": -5,
  "al": -5,
  "at": -5,
  "ax": -5,
  "ba": -5,
  "be": -5,
  "bg": -5,
  "ch": -5,
  "cy": -5,
  "cz": -5,
  "de": -5,
  "dk": -5,
  "dz": -5,
  "ee": -5,
  "eg": -5,
  "es": -5,
  "fi": -5,
  "fo": -5,
  "fr": -5,
  "gg": -5,
  "gi": -5,
  "gr": -5,
  "hr": -5,
  "hu": -5,
  "ie": -5,
  "il": -5,
  "im": -5,
  "is": -5,
  "it": -5,
  "je": -5,
  "lb": -5,
  "li": -5,
  "lt": -5,
  "lu": -5,
  "lv": -5,
  "ly": -5,
  "ma": -5,
  "mc": -5,
  "md": -5,
  "me": -5,
  "mk": -5,
  "mt": -5,
  "nl": -5,
  "no": -5,
  "pl": -5,
  "ps": -5,
  "pt": -5,
  "ro": -5,
  "rs": -5,
  "se": -5,
  "si": -5,
  "sj": -5,
  "sk": -5,
  "sm": -5,
  "sy": -5,
  "tn": -5,
  "tr": -5,
  "ua": -5,
  "uk": -5,
  "us": -5,
  "va": -5,
  "world": -5,
  "xk": -5
  },
  "warning": "origins_are_100_percent_unknown"
  },
  "packaging": {
  "non_recyclable_and_non_biodegradable_materials": 1,
  "value": -15,
  "warning": "packaging_data_missing"
  },
  "production_system": {
  "labels": [],
  "value": 0,
  "warning": "no_label"
  },
  "threatened_species": {}
  },
  "agribalyse": {
  "agribalyse_food_code": "18900",
  "co2_agriculture": 0.10763457,
  "co2_consumption": 0,
  "co2_distribution": 0.014644818,
  "co2_packaging": 0.10010411,
  "co2_processing": 0.0881966,
  "co2_total": 0.435562618,
  "co2_transportation": 0.12498252,
  "code": "18900",
  "dqr": "2.18",
  "ef_agriculture": 0.012449165,
  "ef_consumption": 0,
  "ef_distribution": 0.0042592639,
  "ef_packaging": 0.0099703815,
  "ef_processing": 0.0063742524,
  "ef_total": 0.0436240208,
  "ef_transportation": 0.010570958,
  "is_beverage": 1,
  "name_en": "Soy drink, plain, prepacked",
  "name_fr": "Boisson au soja, nature",
  "score": 90,
  "version": "3.1"
  },
  "grade": "b",
  "grades": {
  "ad": "b",
  "al": "b",
  "at": "b",
  "ax": "b",
  "ba": "b",
  "be": "b",
  "bg": "b",
  "ch": "b",
  "cy": "b",
  "cz": "b",
  "de": "b",
  "dk": "b",
  "dz": "b",
  "ee": "b",
  "eg": "b",
  "es": "b",
  "fi": "b",
  "fo": "b",
  "fr": "b",
  "gg": "b",
  "gi": "b",
  "gr": "b",
  "hr": "b",
  "hu": "b",
  "ie": "b",
  "il": "b",
  "im": "b",
  "is": "b",
  "it": "b",
  "je": "b",
  "lb": "b",
  "li": "b",
  "lt": "b",
  "lu": "b",
  "lv": "b",
  "ly": "b",
  "ma": "b",
  "mc": "b",
  "md": "b",
  "me": "b",
  "mk": "b",
  "mt": "b",
  "nl": "b",
  "no": "b",
  "pl": "b",
  "ps": "b",
  "pt": "b",
  "ro": "b",
  "rs": "b",
  "se": "b",
  "si": "b",
  "sj": "b",
  "sk": "b",
  "sm": "b",
  "sy": "b",
  "tn": "b",
  "tr": "b",
  "ua": "b",
  "uk": "b",
  "us": "b",
  "va": "b",
  "world": "b",
  "xk": "b"
  },
  "missing": {
  "labels": 1,
  "origins": 1,
  "packagings": 1
  },
  "missing_data_warning": 1,
  "missing_key_data": 1,
  "previous_data": {
  "agribalyse": {
  "agribalyse_food_code": "18900",
  "co2_agriculture": 0.090024208,
  "co2_consumption": 0.0047993021,
  "co2_distribution": 0.028932423,
  "co2_packaging": 0.098786634,
  "co2_processing": 0.00033979179,
  "co2_total": 0.41691542,
  "co2_transportation": 0.19403306,
  "code": "18900",
  "dqr": "2.95",
  "ef_agriculture": 0.014107424,
  "ef_consumption": 0.0024293397,
  "ef_distribution": 0.0088128735,
  "ef_packaging": 0.014974093,
  "ef_processing": 0.00034049978,
  "ef_total": 0.055473705,
  "ef_transportation": 0.014809476,
  "is_beverage": 1,
  "name_en": "Soy drink, plain",
  "name_fr": "Boisson au soja, nature",
  "score": 82
  },
  "grade": "b",
  "score": 67
  },
  "score": 70,
  "scores": {
  "ad": 70,
  "al": 70,
  "at": 70,
  "ax": 70,
  "ba": 70,
  "be": 70,
  "bg": 70,
  "ch": 70,
  "cy": 70,
  "cz": 70,
  "de": 70,
  "dk": 70,
  "dz": 70,
  "ee": 70,
  "eg": 70,
  "es": 70,
  "fi": 70,
  "fo": 70,
  "fr": 70,
  "gg": 70,
  "gi": 70,
  "gr": 70,
  "hr": 70,
  "hu": 70,
  "ie": 70,
  "il": 70,
  "im": 70,
  "is": 70,
  "it": 70,
  "je": 70,
  "lb": 70,
  "li": 70,
  "lt": 70,
  "lu": 70,
  "lv": 70,
  "ly": 70,
  "ma": 70,
  "mc": 70,
  "md": 70,
  "me": 70,
  "mk": 70,
  "mt": 70,
  "nl": 70,
  "no": 70,
  "pl": 70,
  "ps": 70,
  "pt": 70,
  "ro": 70,
  "rs": 70,
  "se": 70,
  "si": 70,
  "sj": 70,
  "sk": 70,
  "sm": 70,
  "sy": 70,
  "tn": 70,
  "tr": 70,
  "ua": 70,
  "uk": 70,
  "us": 70,
  "va": 70,
  "world": 70,
  "xk": 70
  },
  "status": "known"
  },
  "ecoscore_grade": "b",
  "ecoscore_score": 70,
  "ecoscore_tags": [
  "b"
  ],
  "editors_tags": [
  "inf",
  "mariacastiel",
  "moon-rabbit",
  "openfoodfacts-contributors",
  "org-database-usda",
  "pbl1969",
  "swipe-studio",
  "teolemon",
  "tmbe7",
  "usda-ndb-import",
  "waistline-app"
  ],
  "emb_codes": "",
  "emb_codes_orig": "",
  "emb_codes_tags": [],
  "entry_dates_tags": [
  "2017-03-09",
  "2017-03",
  "2017"
  ],
  "environment_impact_level": "",
  "environment_impact_level_tags": [],
  "expiration_date": "",
  "food_groups": "en:plant-based-milk-substitutes",
  "food_groups_tags": [
  "en:beverages",
  "en:plant-based-milk-substitutes"
  ],
  "fruits-vegetables-nuts_100g_estimate": 0,
  "generic_name": "",
  "generic_name_en": "",
  "id": "0025293600232",
  "image_front_small_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.200.jpg",
  "image_front_thumb_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.100.jpg",
  "image_front_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.400.jpg",
  "image_ingredients_small_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/ingredients_en.5.200.jpg",
  "image_ingredients_thumb_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/ingredients_en.5.100.jpg",
  "image_ingredients_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/ingredients_en.5.400.jpg",
  "image_small_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.200.jpg",
  "image_thumb_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.100.jpg",
  "image_url": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.400.jpg",
  "images": {
  "1": {
  "sizes": {
  "100": {
  "h": 100,
  "w": 74
  },
  "400": {
  "h": 400,
  "w": 294
  },
  "full": {
  "h": 3357,
  "w": 2471
  }
  },
  "uploaded_t": 1555946130,
  "uploader": "openfoodfacts-contributors"
  },
  "2": {
  "sizes": {
  "100": {
  "h": 61,
  "w": 100
  },
  "400": {
  "h": 242,
  "w": 400
  },
  "full": {
  "h": 1330,
  "w": 2197
  }
  },
  "uploaded_t": 1555946175,
  "uploader": "openfoodfacts-contributors"
  },
  "3": {
  "sizes": {
  "100": {
  "h": 75,
  "w": 100
  },
  "400": {
  "h": 301,
  "w": 400
  },
  "full": {
  "h": 3072,
  "w": 4080
  }
  },
  "uploaded_t": 1686339904,
  "uploader": "waistline-app"
  },
  "front_en": {
  "angle": "90",
  "coordinates_image_size": "full",
  "geometry": "2297x4054-246-26",
  "imgid": "3",
  "normalize": "false",
  "rev": "15",
  "sizes": {
  "100": {
  "h": 100,
  "w": 57
  },
  "200": {
  "h": 200,
  "w": 113
  },
  "400": {
  "h": 400,
  "w": 227
  },
  "full": {
  "h": 4054,
  "w": 2297
  }
  },
  "white_magic": "false",
  "x1": "246.67854186934153",
  "x2": "2543.2986181082238",
  "y1": "26.61260001389801",
  "y2": "4080.0000000000005"
  },
  "ingredients_en": {
  "angle": 0,
  "geometry": "0x0--5--5",
  "imgid": "2",
  "normalize": null,
  "rev": "5",
  "sizes": {
  "100": {
  "h": 61,
  "w": 100
  },
  "200": {
  "h": 121,
  "w": 200
  },
  "400": {
  "h": 242,
  "w": 400
  },
  "full": {
  "h": 1330,
  "w": 2197
  }
  },
  "white_magic": null,
  "x1": "-1",
  "x2": "-1",
  "y1": "-1",
  "y2": "-1"
  }
  },
  "informers_tags": [
  "usda-ndb-import",
  "openfoodfacts-contributors",
  "moon-rabbit",
  "org-database-usda",
  "swipe-studio",
  "tmbe7"
  ],
  "ingredients": [
  {
  "id": "en:soymilk",
  "ingredients": [
  {
  "ciqual_food_code": "18066",
  "id": "en:filtered-water",
  "percent_estimate": 49.95005,
  "percent_max": 100,
  "percent_min": 24.95005,
  "text": "filtered water",
  "vegan": "yes",
  "vegetarian": "yes"
  },
  {
  "ciqual_food_code": "20901",
  "id": "en:soya-bean",
  "labels": "en:organic",
  "percent_estimate": 25,
  "percent_max": 50,
  "percent_min": 0,
  "text": "soybeans",
  "vegan": "yes",
  "vegetarian": "yes"
  }
  ],
  "labels": "en:organic",
  "percent_estimate": 74.95005,
  "percent_max": 100,
  "percent_min": 49.9001,
  "text": "soymilk"
  },
  {},
  {},
  {
  "id": "en:natural-flavouring",
  "percent_estimate": 0.01665,
  "percent_max": 0.0333,
  "percent_min": 0,
  "text": "natural flavor",
  "vegan": "maybe",
  "vegetarian": "maybe"
  },
  {
  "id": "en:e418",
  "percent_estimate": 12.491675,
  "percent_max": 0.0333,
  "percent_min": 0,
  "text": "gellan gum",
  "vegan": "yes",
  "vegetarian": "yes"
  }
  ],
  "ingredients_analysis": {
  "en:palm-oil-content-unknown": [
  "en:soymilk"
  ],
  "en:vegan-status-unknown": [
  "en:soymilk",
  "en:vitamin-b12"
  ],
  "en:vegetarian-status-unknown": [
  "en:soymilk",
  "en:vitamin-b12"
  ]
  },
  "ingredients_analysis_tags": [
  "en:palm-oil-free",
  "en:vegan-status-unknown",
  "en:vegetarian-status-unknown"
  ],
  "ingredients_from_or_that_may_be_from_palm_oil_n": 0,
  "ingredients_from_palm_oil_n": 0,
  "ingredients_from_palm_oil_tags": [],
  "ingredients_hierarchy": [
  "en:soymilk",
  "en:vitamin-and-mineral-blend",
  "en:minerals",
  "en:vitamins",
  "en:sea-salt",
  "en:salt",
  "en:natural-flavouring",
  "en:flavouring",
  "en:e418",
  "en:filtered-water",
  "en:water",
  "en:soya-bean",
  "en:vegetable",
  "en:legume",
  "en:pulse",
  "en:soya",
  "en:e170i",
  "en:e170",
  "en:retinyl-palmitate",
  "en:vitamin-a",
  "en:ergocalciferol",
  "en:vitamin-d",
  "en:e101",
  "en:vitamin-b12"
  ],
  "ingredients_lc": "en",
  "ingredients_n": 14,
  "ingredients_n_tags": [
  "14",
  "11-20"
  ],
  "ingredients_original_tags": [
  "en:soymilk",
  "en:vitamin-and-mineral-blend",
  "en:sea-salt",
  "en:natural-flavouring",
  "en:e418",
  "en:filtered-water",
  "en:soya-bean",
  "en:e170i",
  "en:retinyl-palmitate",
  "en:vitamins",
  "en:ergocalciferol",
  "en:e101",
  "en:vitamin-b12",
  "en:e101"
  ],
  "ingredients_percent_analysis": 1,
  "ingredients_tags": [
  "en:soymilk",
  "en:vitamin-and-mineral-blend",
  "en:minerals",
  "en:vitamins",
  "en:sea-salt",
  "en:salt",
  "en:natural-flavouring",
  "en:flavouring",
  "en:e418",
  "en:filtered-water",
  "en:water",
  "en:soya-bean",
  "en:vegetable",
  "en:legume",
  "en:pulse",
  "en:soya",
  "en:e170i",
  "en:e170",
  "en:retinyl-palmitate",
  "en:vitamin-a",
  "en:ergocalciferol",
  "en:vitamin-d",
  "en:e101",
  "en:vitamin-b12"
  ],
  "ingredients_text": "Organic soymilk (filtered water, organic soybeans), vitamin and mineral blend (calcium carbonate, vitamin a palmitate, vitamin d2, riboflavin [b2], vitamin b12), sea salt, natural flavor, gellan gum.",
  "ingredients_text_debug": "Organic soymilk (filtered water, organic soybeans), contains 2% or less of: vitamin & mineral blend (calcium carbonate, vitamin a palmitate, vitamin d2, riboflavin [b2], vitamin b12), sea salt, : natural flavor : , gellan gum.",
  "ingredients_text_en": "Organic soymilk (filtered water, organic soybeans), vitamin and mineral blend (calcium carbonate, vitamin a palmitate, vitamin d2, riboflavin [b2], vitamin b12), sea salt, natural flavor, gellan gum.",
  "ingredients_text_en_imported": "Organic soymilk (filtered water, organic soybeans), contains 2% or less of: vitamin and mineral blend (calcium carbonate, vitamin a palmitate, vitamin d2, riboflavin [b2], vitamin b12), sea salt, natural flavor, gellan gum.",
  "ingredients_text_with_allergens": "Organic soymilk (filtered water, organic soybeans), vitamin and mineral blend (calcium carbonate, vitamin a palmitate, vitamin d2, riboflavin [b2], vitamin b12), sea salt, natural flavor, gellan gum.",
  "ingredients_text_with_allergens_en": "Organic soymilk (filtered water, organic soybeans), vitamin and mineral blend (calcium carbonate, vitamin a palmitate, vitamin d2, riboflavin [b2], vitamin b12), sea salt, natural flavor, gellan gum.",
  "ingredients_that_may_be_from_palm_oil_n": 0,
  "ingredients_that_may_be_from_palm_oil_tags": [],
  "ingredients_with_specified_percent_n": 0,
  "ingredients_with_specified_percent_sum": 0,
  "ingredients_with_unspecified_percent_n": 11,
  "ingredients_with_unspecified_percent_sum": 100,
  "ingredients_without_ciqual_codes": [
  "en:e101",
  "en:e170i",
  "en:e418",
  "en:ergocalciferol",
  "en:natural-flavouring",
  "en:retinyl-palmitate",
  "en:soymilk",
  "en:vitamin-and-mineral-blend",
  "en:vitamin-b12",
  "en:vitamins"
  ],
  "ingredients_without_ciqual_codes_n": 10,
  "interface_version_created": "import_us_ndb.pl - version 2017/03/04",
  "interface_version_modified": "20150316.jqm2",
  "known_ingredients_n": 23,
  "labels": "Organic, No GMOs, Certified B Corporation, Non GMO project",
  "labels_hierarchy": [
  "en:organic",
  "en:no-gmos",
  "en:certified-b-corporation",
  "en:non-gmo-project"
  ],
  "labels_imported": "Organic, en:organic",
  "labels_lc": "en",
  "labels_old": "Organic, No GMOs, Non GMO project, en:certified-b-corporation",
  "labels_tags": [
  "en:organic",
  "en:no-gmos",
  "en:certified-b-corporation",
  "en:non-gmo-project"
  ],
  "lang": "en",
  "languages": {
  "en:english": 4
  },
  "languages_codes": {
  "en": 4
  },
  "languages_hierarchy": [
  "en:english"
  ],
  "languages_tags": [
  "en:english",
  "en:1"
  ],
  "last_edit_dates_tags": [
  "2024-02-12",
  "2024-02",
  "2024"
  ],
  "last_editor": "pbl1969",
  "last_image_dates_tags": [
  "2023-06-09",
  "2023-06",
  "2023"
  ],
  "last_image_t": 1686339905,
  "last_modified_by": "pbl1969",
  "last_modified_t": 1707701394,
  "last_updated_t": 1707701394,
  "lc": "en",
  "lc_imported": "en",
  "link": "",
  "main_countries_tags": [],
  "manufacturing_places": "",
  "manufacturing_places_tags": [],
  "max_imgid": "3",
  "minerals_prev_tags": [],
  "minerals_tags": [
  "en:calcium-carbonate"
  ],
  "misc_tags": [
  "en:nutriscore-computed",
  "en:nutrition-fruits-vegetables-nuts-estimate-from-ingredients",
  "en:nutrition-all-nutriscore-values-known",
  "en:nutrition-fruits-vegetables-legumes-estimate-from-ingredients",
  "en:nutriscore-2021-different-from-2023",
  "en:nutriscore-2021-better-than-2023",
  "en:nutriscore-2021-a-2023-b",
  "en:packagings-number-of-components-0",
  "en:packagings-not-complete",
  "en:packagings-empty",
  "en:ecoscore-extended-data-not-computed",
  "en:ecoscore-missing-data-warning",
  "en:ecoscore-missing-data-labels",
  "en:ecoscore-missing-data-origins",
  "en:ecoscore-missing-data-packagings",
  "en:ecoscore-missing-data-no-packagings",
  "en:ecoscore-computed",
  "en:ecoscore-changed"
  ],
  "no_nutrition_data": "",
  "nova_group": 4,
  "nova_group_debug": "",
  "nova_groups": "4",
  "nova_groups_markers": {
  "3": [
  [
  "ingredients",
  "en:salt"
  ]
  ],
  "4": [
  [
  "additives",
  "en:e418"
  ],
  [
  "ingredients",
  "en:flavouring"
  ]
  ]
  },
  "nova_groups_tags": [
  "en:4-ultra-processed-food-and-drink-products"
  ],
  "nucleotides_prev_tags": [],
  "nucleotides_tags": [],
  "nutrient_levels": {
  "fat": "moderate",
  "salt": "low",
  "saturated-fat": "low",
  "sugars": "low"
  },
  "nutrient_levels_tags": [
  "en:fat-in-moderate-quantity",
  "en:saturated-fat-in-low-quantity",
  "en:sugars-in-low-quantity",
  "en:salt-in-low-quantity"
  ],
  "nutriments": {
  "calcium": 0.125,
  "calcium_100g": 0.0521,
  "calcium_serving": 0.125,
  "calcium_unit": "mg",
  "calcium_value": 125,
  "carbohydrates": 4,
  "carbohydrates_100g": 1.67,
  "carbohydrates_serving": 4,
  "carbohydrates_unit": "g",
  "carbohydrates_value": 4,
  "cholesterol": 0,
  "cholesterol_100g": 0,
  "cholesterol_serving": 0,
  "cholesterol_unit": "mg",
  "cholesterol_value": 0,
  "energy": 335,
  "energy-kcal": 80,
  "energy-kcal_100g": 33.3,
  "energy-kcal_serving": 80,
  "energy-kcal_unit": "kcal",
  "energy-kcal_value": 80,
  "energy-kcal_value_computed": 86.1,
  "energy_100g": 140,
  "energy_serving": 335,
  "energy_unit": "kcal",
  "energy_value": 80,
  "fat": 4.5,
  "fat_100g": 1.88,
  "fat_serving": 4.5,
  "fat_unit": "g",
  "fat_value": 4.5,
  "fiber": 0.8,
  "fiber_100g": 0.333,
  "fiber_serving": 0.8,
  "fiber_unit": "g",
  "fiber_value": 0.8,
  "folates": 0.000025,
  "folates_100g": 0.0000104,
  "folates_serving": 0.000025,
  "folates_unit": "µg",
  "folates_value": 25,
  "fruits-vegetables-legumes-estimate-from-ingredients_100g": 25,
  "fruits-vegetables-legumes-estimate-from-ingredients_serving": 25,
  "fruits-vegetables-nuts-estimate-from-ingredients_100g": 25,
  "fruits-vegetables-nuts-estimate-from-ingredients_serving": 25,
  "iron": 0.00045,
  "iron_100g": 0.000188,
  "iron_serving": 0.00045,
  "iron_unit": "mg",
  "iron_value": 0.45,
  "magnesium": 0.017,
  "magnesium_100g": 0.00708,
  "magnesium_serving": 0.017,
  "magnesium_unit": "mg",
  "magnesium_value": 17,
  "monounsaturated-fat": 0.42,
  "monounsaturated-fat_100g": 0.175,
  "monounsaturated-fat_serving": 0.42,
  "monounsaturated-fat_unit": "g",
  "monounsaturated-fat_value": 0.42,
  "nova-group": 4,
  "nova-group_100g": 4,
  "nova-group_serving": 4,
  "nutrition-score-fr": -1,
  "nutrition-score-fr_100g": -1,
  "phosphorus": 0.033,
  "phosphorus_100g": 0.0138,
  "phosphorus_serving": 0.033,
  "phosphorus_unit": "mg",
  "phosphorus_value": 33,
  "polyunsaturated-fat": 1.04,
  "polyunsaturated-fat_100g": 0.433,
  "polyunsaturated-fat_serving": 1.04,
  "polyunsaturated-fat_unit": "g",
  "polyunsaturated-fat_value": 1.04,
  "potassium": 0.146,
  "potassium_100g": 0.0608,
  "potassium_serving": 0.146,
  "potassium_unit": "mg",
  "potassium_value": 146,
  "proteins": 7,
  "proteins_100g": 2.92,
  "proteins_serving": 7,
  "proteins_unit": "g",
  "proteins_value": 7,
  "salt": 0.08,
  "salt_100g": 0.0333,
  "salt_serving": 0.08,
  "salt_unit": "g",
  "salt_value": 0.08,
  "saturated-fat": 0.5,
  "saturated-fat_100g": 0.208,
  "saturated-fat_serving": 0.5,
  "saturated-fat_unit": "g",
  "saturated-fat_value": 0.5,
  "sodium": 0.032,
  "sodium_100g": 0.0133,
  "sodium_serving": 0.032,
  "sodium_unit": "g",
  "sodium_value": 0.032,
  "sugars": 0,
  "sugars_100g": 0,
  "sugars_serving": 0,
  "sugars_unit": "g",
  "sugars_value": 0,
  "trans-fat": 0,
  "trans-fat_100g": 0,
  "trans-fat_serving": 0,
  "trans-fat_unit": "g",
  "trans-fat_value": 0,
  "vitamin-a": 0.0000624,
  "vitamin-a_100g": 0.000026,
  "vitamin-a_serving": 0.0000624,
  "vitamin-a_unit": "IU",
  "vitamin-a_value": 208,
  "vitamin-b12": 0.00000125,
  "vitamin-b12_100g": 5.21e-7,
  "vitamin-b12_serving": 0.00000125,
  "vitamin-b12_unit": "µg",
  "vitamin-b12_value": 1.25,
  "vitamin-b2": 0.000212,
  "vitamin-b2_100g": 0.0000883,
  "vitamin-b2_serving": 0.000212,
  "vitamin-b2_unit": "mg",
  "vitamin-b2_value": 0.212,
  "vitamin-c": 0,
  "vitamin-c_100g": 0,
  "vitamin-c_serving": 0,
  "vitamin-c_unit": "mg",
  "vitamin-c_value": 0,
  "vitamin-d": 0.00000125,
  "vitamin-d_100g": 5.21e-7,
  "vitamin-d_serving": 0.00000125,
  "vitamin-d_unit": "IU",
  "vitamin-d_value": 50
  },
  "nutriscore": {
  "2021": {
  "category_available": 1,
  "data": {
  "energy": 140,
  "energy_points": 0,
  "energy_value": 140,
  "fiber": 0.333,
  "fiber_points": 0,
  "fiber_value": 0.33,
  "fruits_vegetables_nuts_colza_walnut_olive_oils": 25,
  "fruits_vegetables_nuts_colza_walnut_olive_oils_points": 0,
  "fruits_vegetables_nuts_colza_walnut_olive_oils_value": 25,
  "is_beverage": 0,
  "is_cheese": 0,
  "is_fat": 0,
  "is_water": 0,
  "negative_points": 0,
  "positive_points": 1,
  "proteins": 2.92,
  "proteins_points": 1,
  "proteins_value": 2.92,
  "saturated_fat": 0.208,
  "saturated_fat_points": 0,
  "saturated_fat_value": 0.2,
  "sodium": 13.3,
  "sodium_points": 0,
  "sodium_value": 13.3,
  "sugars": 0,
  "sugars_points": 0,
  "sugars_value": 0
  },
  "grade": "a",
  "nutrients_available": 1,
  "nutriscore_applicable": 1,
  "nutriscore_computed": 1,
  "score": -1
  },
  "2023": {
  "category_available": 1,
  "data": {
  "components": {
  "negative": [
  {
  "id": "energy",
  "points": 2,
  "points_max": 10,
  "unit": "kJ",
  "value": 140
  },
  {
  "id": "sugars",
  "points": 0,
  "points_max": 10,
  "unit": "g",
  "value": 0
  },
  {
  "id": "saturated_fat",
  "points": 0,
  "points_max": 10,
  "unit": "g",
  "value": 0.21
  },
  {
  "id": "salt",
  "points": 0,
  "points_max": 20,
  "unit": "g",
  "value": 0.03
  },
  {
  "id": "non_nutritive_sweeteners",
  "points": 0,
  "points_max": null,
  "unit": null,
  "value": 0
  }
  ],
  "positive": [
  {
  "id": "proteins",
  "points": 6,
  "points_max": 7,
  "unit": "g",
  "value": 2.92
  },
  {
  "id": "fiber",
  "points": 0,
  "points_max": 5,
  "unit": "g",
  "value": 0.33
  },
  {
  "id": "fruits_vegetables_legumes",
  "points": 0,
  "points_max": 6,
  "unit": "%",
  "value": 25
  }
  ]
  },
  "count_proteins": 1,
  "count_proteins_reason": "beverage",
  "is_beverage": 1,
  "is_cheese": 0,
  "is_fat_oil_nuts_seeds": 0,
  "is_red_meat_product": 0,
  "is_water": 0,
  "negative_points": 2,
  "negative_points_max": 50,
  "non_nutritive_sweeteners_max": 4,
  "positive_nutrients": [
  "proteins",
  "fiber",
  "fruits_vegetables_legumes"
  ],
  "positive_points": 6,
  "positive_points_max": 18
  },
  "grade": "b",
  "nutrients_available": 1,
  "nutriscore_applicable": 1,
  "nutriscore_computed": 1,
  "score": -4
  }
  },
  "nutriscore_2021_tags": [
  "a"
  ],
  "nutriscore_2023_tags": [
  "b"
  ],
  "nutriscore_data": {
  "energy": 140,
  "energy_points": 0,
  "energy_value": 140,
  "fiber": 0.333,
  "fiber_points": 0,
  "fiber_value": 0.33,
  "fruits_vegetables_nuts_colza_walnut_olive_oils": 25,
  "fruits_vegetables_nuts_colza_walnut_olive_oils_points": 0,
  "fruits_vegetables_nuts_colza_walnut_olive_oils_value": 25,
  "grade": "a",
  "is_beverage": 0,
  "is_cheese": 0,
  "is_fat": 0,
  "is_water": 0,
  "negative_points": 0,
  "positive_points": 1,
  "proteins": 2.92,
  "proteins_points": 1,
  "proteins_value": 2.92,
  "saturated_fat": 0.208,
  "saturated_fat_points": 0,
  "saturated_fat_value": 0.2,
  "score": -1,
  "sodium": 13.3,
  "sodium_points": 0,
  "sodium_value": 13.3,
  "sugars": 0,
  "sugars_points": 0,
  "sugars_value": 0
  },
  "nutriscore_grade": "a",
  "nutriscore_score": -1,
  "nutriscore_score_opposite": 1,
  "nutriscore_tags": [
  "a"
  ],
  "nutriscore_version": "2021",
  "nutrition_data": "on",
  "nutrition_data_per": "serving",
  "nutrition_data_per_imported": "100g",
  "nutrition_data_prepared": "",
  "nutrition_data_prepared_per": "100g",
  "nutrition_data_prepared_per_imported": "100g",
  "nutrition_grade_fr": "a",
  "nutrition_grades": "a",
  "nutrition_grades_tags": [
  "a"
  ],
  "nutrition_score_beverage": 0,
  "nutrition_score_debug": "",
  "nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients": 1,
  "nutrition_score_warning_fruits_vegetables_legumes_estimate_from_ingredients_value": 25,
  "nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients": 1,
  "nutrition_score_warning_fruits_vegetables_nuts_estimate_from_ingredients_value": 25,
  "obsolete": "",
  "obsolete_since_date": "",
  "origin": "",
  "origin_en": "",
  "origins": "",
  "origins_hierarchy": [],
  "origins_lc": "en",
  "origins_old": "",
  "origins_tags": [],
  "other_nutritional_substances_tags": [],
  "packaging": "Composite-carton",
  "packaging_hierarchy": [
  "en:Composite-carton"
  ],
  "packaging_lc": "en",
  "packaging_materials_tags": [],
  "packaging_old": "en:composite-carton",
  "packaging_recycling_tags": [],
  "packaging_shapes_tags": [],
  "packaging_tags": [
  "en:composite-carton"
  ],
  "packaging_text": "",
  "packaging_text_en": "",
  "packagings": [],
  "packagings_complete": 0,
  "packagings_materials": {},
  "photographers_tags": [
  "openfoodfacts-contributors",
  "waistline-app"
  ],
  "pnns_groups_1": "Beverages",
  "pnns_groups_1_tags": [
  "beverages",
  "known"
  ],
  "pnns_groups_2": "Plant-based milk substitutes",
  "pnns_groups_2_tags": [
  "plant-based-milk-substitutes",
  "known"
  ],
  "popularity_key": 22950000025,
  "popularity_tags": [
  "top-75-percent-scans-2020",
  "top-80-percent-scans-2020",
  "top-85-percent-scans-2020",
  "top-90-percent-scans-2020",
  "top-500-us-scans-2020",
  "top-1000-us-scans-2020",
  "top-5000-us-scans-2020",
  "top-10000-us-scans-2020",
  "top-50000-us-scans-2020",
  "top-100000-us-scans-2020",
  "top-country-us-scans-2020",
  "top-100000-scans-2021",
  "at-least-5-scans-2021",
  "top-75-percent-scans-2021",
  "top-80-percent-scans-2021",
  "top-85-percent-scans-2021",
  "top-90-percent-scans-2021",
  "top-500-us-scans-2021",
  "top-1000-us-scans-2021",
  "top-5000-us-scans-2021",
  "top-10000-us-scans-2021",
  "top-50000-us-scans-2021",
  "top-100000-us-scans-2021",
  "top-country-us-scans-2021",
  "at-least-5-us-scans-2021",
  "top-1000-co-scans-2021",
  "top-5000-co-scans-2021",
  "top-10000-co-scans-2021",
  "top-50000-co-scans-2021",
  "top-100000-co-scans-2021",
  "top-500-ph-scans-2021",
  "top-1000-ph-scans-2021",
  "top-5000-ph-scans-2021",
  "top-10000-ph-scans-2021",
  "top-50000-ph-scans-2021",
  "top-100000-ph-scans-2021",
  "top-100000-scans-2022",
  "top-75-percent-scans-2022",
  "top-80-percent-scans-2022",
  "top-85-percent-scans-2022",
  "top-90-percent-scans-2022",
  "top-5000-us-scans-2022",
  "top-10000-us-scans-2022",
  "top-50000-us-scans-2022",
  "top-100000-us-scans-2022",
  "top-country-us-scans-2022",
  "top-1000-co-scans-2022",
  "top-5000-co-scans-2022",
  "top-10000-co-scans-2022",
  "top-50000-co-scans-2022",
  "top-100000-co-scans-2022",
  "top-5000-se-scans-2022",
  "top-10000-se-scans-2022",
  "top-50000-se-scans-2022",
  "top-100000-se-scans-2022",
  "top-50000-scans-2023",
  "top-100000-scans-2023",
  "at-least-5-scans-2023",
  "at-least-10-scans-2023",
  "top-75-percent-scans-2023",
  "top-80-percent-scans-2023",
  "top-85-percent-scans-2023",
  "top-90-percent-scans-2023",
  "top-50-us-scans-2023",
  "top-100-us-scans-2023",
  "top-500-us-scans-2023",
  "top-1000-us-scans-2023",
  "top-5000-us-scans-2023",
  "top-10000-us-scans-2023",
  "top-50000-us-scans-2023",
  "top-100000-us-scans-2023",
  "top-country-us-scans-2023",
  "at-least-5-us-scans-2023",
  "at-least-10-us-scans-2023",
  "top-5000-mx-scans-2023",
  "top-10000-mx-scans-2023",
  "top-50000-mx-scans-2023",
  "top-100000-mx-scans-2023"
  ],
  "product_name": "Organic Unsweet Soy Milk",
  "product_name_en": "Organic Unsweet Soy Milk",
  "product_name_en_imported": "Organic soymilk",
  "product_quantity": 1892.704,
  "product_quantity_unit": "ml",
  "purchase_places": "",
  "purchase_places_tags": [],
  "quantity": "64 fl oz",
  "removed_countries_tags": [],
  "rev": 18,
  "scans_n": 21,
  "selected_images": {
  "front": {
  "display": {
  "en": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.400.jpg"
  },
  "small": {
  "en": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.200.jpg"
  },
  "thumb": {
  "en": "https://images.openfoodfacts.org/images/products/002/529/360/0232/front_en.15.100.jpg"
  }
  },
  "ingredients": {
  "display": {
  "en": "https://images.openfoodfacts.org/images/products/002/529/360/0232/ingredients_en.5.400.jpg"
  },
  "small": {
  "en": "https://images.openfoodfacts.org/images/products/002/529/360/0232/ingredients_en.5.200.jpg"
  },
  "thumb": {
  "en": "https://images.openfoodfacts.org/images/products/002/529/360/0232/ingredients_en.5.100.jpg"
  }
  }
  },
  "serving_quantity": "240",
  "serving_quantity_unit": "ml",
  "serving_size": "240 ml",
  "serving_size_imported": "1 cup (240 ml)",
  "sources": [
  {
  "fields": [
  "product_name_en",
  "brands",
  "countries",
  "serving_size",
  "ingredients_text_en",
  "nutrients.energy",
  "nutrients.proteins",
  "nutrients.fat",
  "nutrients.carbohydrates",
  "nutrients.fiber",
  "nutrients.sugars",
  "nutrients.calcium",
  "nutrients.iron",
  "nutrients.magnesium",
  "nutrients.phosphorus",
  "nutrients.potassium",
  "nutrients.sodium",
  "nutrients.vitamin-c",
  "nutrients.vitamin-b2",
  "nutrients.vitamin-b12",
  "nutrients.vitamin-a",
  "nutrients.vitamin-d",
  "nutrients.saturated-fat",
  "nutrients.monounsaturated-fat",
  "nutrients.polyunsaturated-fat",
  "nutrients.trans-fat",
  "nutrients.cholesterol"
  ],
  "id": "usda-ndb",
  "images": [],
  "import_t": 1489079756,
  "url": "https://api.nal.usda.gov/ndb/reports/?ndbno=45179319&type=f&format=json&api_key=DEMO_KEY"
  },
  {
  "fields": [
  "product_name_en",
  "labels",
  "brand_owner",
  "data_sources",
  "nutrition_data_prepared_per",
  "serving_size",
  "ingredients_text_en",
  "nutrients.folates_unit",
  "nutrients.folates_value",
  "nutrients.phosphorus_value",
  "nutrients.salt_unit",
  "nutrients.salt_value",
  "nutrients.vitamin-b2_value"
  ],
  "id": "database-usda",
  "images": [],
  "import_t": 1587590982,
  "manufacturer": null,
  "name": "database-usda",
  "url": null
  }
  ],
  "sources_fields": {
  "org-database-usda": {
  "available_date": "2018-03-10T00:00:00Z",
  "fdc_category": "Plant Based Milk",
  "fdc_data_source": "LI",
  "fdc_id": "445881",
  "modified_date": "2018-03-10T00:00:00Z",
  "publication_date": "2019-04-01T00:00:00Z"
  }
  },
  "states": "en:to-be-completed, en:nutrition-facts-completed, en:ingredients-completed, en:expiration-date-to-be-completed, en:packaging-code-to-be-completed, en:characteristics-to-be-completed, en:origins-to-be-completed, en:categories-completed, en:brands-completed, en:packaging-completed, en:quantity-completed, en:product-name-completed, en:photos-to-be-validated, en:packaging-photo-to-be-selected, en:nutrition-photo-to-be-selected, en:ingredients-photo-selected, en:front-photo-selected, en:photos-uploaded",
  "states_hierarchy": [
  "en:to-be-completed",
  "en:nutrition-facts-completed",
  "en:ingredients-completed",
  "en:expiration-date-to-be-completed",
  "en:packaging-code-to-be-completed",
  "en:characteristics-to-be-completed",
  "en:origins-to-be-completed",
  "en:categories-completed",
  "en:brands-completed",
  "en:packaging-completed",
  "en:quantity-completed",
  "en:product-name-completed",
  "en:photos-to-be-validated",
  "en:packaging-photo-to-be-selected",
  "en:nutrition-photo-to-be-selected",
  "en:ingredients-photo-selected",
  "en:front-photo-selected",
  "en:photos-uploaded"
  ],
  "states_tags": [
  "en:to-be-completed",
  "en:nutrition-facts-completed",
  "en:ingredients-completed",
  "en:expiration-date-to-be-completed",
  "en:packaging-code-to-be-completed",
  "en:characteristics-to-be-completed",
  "en:origins-to-be-completed",
  "en:categories-completed",
  "en:brands-completed",
  "en:packaging-completed",
  "en:quantity-completed",
  "en:product-name-completed",
  "en:photos-to-be-validated",
  "en:packaging-photo-to-be-selected",
  "en:nutrition-photo-to-be-selected",
  "en:ingredients-photo-selected",
  "en:front-photo-selected",
  "en:photos-uploaded"
  ],
  "stores": "",
  "stores_tags": [],
  "teams": "swipe-studio,chocolatine,la-robe-est-bleue",
  "teams_tags": [
  "swipe-studio",
  "chocolatine",
  "la-robe-est-bleue"
  ],
  "traces": "",
  "traces_from_ingredients": "",
  "traces_from_user": "(en) ",
  "traces_hierarchy": [],
  "traces_lc": "en",
  "traces_tags": [],
  "unique_scans_n": 21,
  "unknown_ingredients_n": 1,
  "unknown_nutrients_tags": [],
  "update_key": "20240209",
  "vitamins_prev_tags": [
  "en:ergocalciferol",
  "en:riboflavin",
  "en:vitamin-b12"
  ],
  "vitamins_tags": [
  "en:retinyl-palmitate",
  "en:ergocalciferol",
  "en:riboflavin",
  "en:vitamin-b12"
  ],
  "weighers_tags": []
  },
  "status": 1,
  "status_verbose": "product found"
}
''';
