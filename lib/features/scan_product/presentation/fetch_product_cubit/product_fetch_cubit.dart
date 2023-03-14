import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/product_info_entity.dart';
import '../../domain/usescases/fetch_product_usecase.dart';

part 'product_fetch_state.dart';

class ProductFetchCubit extends Cubit<ProductFetchState> {
  final FetchProductUseCase _fetchProductUseCase = serviceLocator<FetchProductUseCase>();

  // final BarcodeScannerCubit barcodeScannerCubit;

  // late StreamSubscription barcodeScannerSubscription;

  bool? isVegan = true;
  String nonVeganIngredientsInProduct = "";
  List<String> nonVeganIngredients = [
    "acidophilus Milk",
    "anchovies",
    "bee pollen",
    "bee venom",
    "beef",
    "beeswax",
    "butter",
    "butter extract",
    "butter fat",
    "butter solids",
    "buttermilk",
    "buttermilk blend",
    "buttermilk solids",
    "boar bristles",
    "bone",
    "bone char",
    "bone meal",
    "calamari",
    "carmine",
    "casein",
    "castoreum",
    "cheese",
    "chicken",
    "cochineal",
    "collagen",
    "collagen peptides",
    "crab",
    "cream",
    "dairy butter",
    "duck",
    "edible bone phosphate",
    "eggs",
    "fish",
    "fish sauce",
    "gelatin",
    "goose",
    "honey",
    "horse",
    "isinglass",
    "l-cysteine",
    "lamb",
    "lactose",
    "lactose-free milk",
    "lobster",
    "malted milk",
    "milk",
    "milk derivative",
    "milk protein",
    "milk powder",
    "milk skimmed",
    "milk skimmed powder",
    "milk skimmed powder 8",
    "milk solids",
    "milk solids blend",
    "mussels",
    "natural butter",

    // "omega-3 fatty acids",
    "organ meat",
    "pork",
    "propolis",
    "quail",
    "royal jelly",
    "scallops",
    "shellac",
    "shrimp",
    "skim milk",
    "skim milk powder",
    "skim milk powder 8",
    "skimmed milk",
    "skimmed milk powder",
    "skimmed milk powder 8",
    "sour milk",
    "squid",
    "turkey",
    "veal",
    "vitamin d3",
    "whey",
    "whipped butter",
    "whole egg",
    "whole egg solids",
    "whole eggs",
    "whole eggs solid",
    "wild meat",
    "yogurt",
  ];

  ProductFetchCubit() : super(ProductFetchInitial());

  Future<void> fetchProduct(String barcode) async {
    emit(ProductLoadingState());
    final Either<FetchProductFailure, ProductInfoEntity> fetchProductResult =
        await _fetchProductUseCase.fetchProduct(barcode);
    fetchProductResult.fold(
      (fetchFailure) => emit(ProductFetchErrorState(error: fetchFailure.message)),
      (productInfo) {
        if (productInfo == null) {
          emit(ProductNotFoundState(message: "${productInfo.productName} was not found"));
        } else {
          print("Product Name: ${productInfo.productName}");
          veganCheck(productInfo);
          emit(
            ProductFoundState(
              product: productInfo,
              nonVeganIngredientsInProduct: nonVeganIngredientsInProduct,
              isVegan: isVegan,
            ),
          );
        }
      },
    );
  }

  void veganCheck(ProductInfoEntity productInfo) {
    isVegan = true;
    nonVeganIngredientsInProduct = "";
    if (productInfo.labels == null || productInfo.labels!.isEmpty) {
      productInfo.ingredients?.forEach((ingredient) {
        debugPrint("is ${ingredient.text} vegan: ${ingredient.vegan}");
        if (ingredient.vegan == null || ingredient.vegan == "maybe") {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text!.toLowerCase() == nonVeganIngredient.toLowerCase()) {
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
              isVegan = false;
            }
          });
        }
        if (ingredient.vegan == "no") {
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
          isVegan = false;
        }
      });
    } else if (!(productInfo.labels!.toLowerCase().contains('vegan') ||
        productInfo.labels!.toLowerCase().contains('contains no animal ingredients'))) {
      productInfo.ingredients?.forEach((ingredient) {
        debugPrint("is ${ingredient.text} vegan: ${ingredient.vegan}");
        if (ingredient.vegan == null || ingredient.vegan == "maybe") {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text!.toLowerCase() == nonVeganIngredient.toLowerCase()) {
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
              isVegan = false;
            }
          });
        }
        if (ingredient.vegan == "no") {
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
          isVegan = false;
        }
      });
    }

    debugPrint("Non Vegan ingredients: " + nonVeganIngredientsInProduct);
  }
}
