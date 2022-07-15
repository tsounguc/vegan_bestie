import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/data/models/product_info_model.dart';
import 'package:sheveegan/data/repositoryLayer/repository.dart';

part 'product_fetch_state.dart';

class ProductFetchCubit extends Cubit<ProductFetchState> {
  final Repository repository;

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

  ProductFetchCubit({
    required this.repository,
    // required this.barcodeScannerCubit,
  }) : super(ProductFetchInitial());

  // {
  //   print("before listener: Listening");
  //   barcodeScannerSubscription = barcodeScannerCubit.stream.listen((barcodeScannerState){
  //     if (barcodeScannerState is BarcodeFoundState) {
  //       print("listener: Listening");
  //       fetchProduct(barcodeScannerState.barcode);
  //     }
  //   });
  // }

  Future<void> fetchProduct(String barcode) async {
    try {
      emit(ProductLoadingState());
      final productInfo = await repository.fetchProduct(barcode);
      if (productInfo!.status == 0) {
        emit(ProductNotFoundState(message: productInfo.statusVerbose!));
      } else if (productInfo.status == 1) {
        print("Product Name: ${productInfo.product?.productName}");
        veganCheck(productInfo);
        emit(ProductFoundState(product: productInfo, nonVeganIngredientsInProduct: nonVeganIngredientsInProduct, isVegan: isVegan));
      }
    } on Error catch (e) {
      emit(ProductFetchErrorState(error: "$e \n${e.stackTrace} "));
      throw Exception(e);
    } catch (e) {
      emit(ProductFetchErrorState(error: "$e"));
      debugPrint('Error: $e');
    }
  }

  void veganCheck(ProductInfoModel productInfo) {
    isVegan = true;
    nonVeganIngredientsInProduct = "";
    if(productInfo.product?.labels == null || productInfo.product!.labels!.isEmpty){
      productInfo.product!.ingredients?.forEach((ingredient) {
        debugPrint("is ${ingredient.text} vegan: ${ingredient.vegan}" );
        if(ingredient.vegan == null || ingredient.vegan == "maybe"){
          nonVeganIngredients.forEach((nonVeganIngredient){
            if(ingredient.text!.toLowerCase() == nonVeganIngredient.toLowerCase()){
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
              isVegan = false;
            }

          });
        }
        if(ingredient.vegan == "no"){
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
          isVegan = false;
        }

      });
    } else if(!(productInfo.product!.labels!.toLowerCase().contains('vegan') || productInfo.product!.labels!.toLowerCase().contains('contains no animal ingredients'))){
      productInfo.product?.ingredients?.forEach((ingredient) {
        debugPrint("is ${ingredient.text} vegan: ${ingredient.vegan}" );
        if(ingredient.vegan == null || ingredient.vegan == "maybe"){
          nonVeganIngredients.forEach((nonVeganIngredient){

            if(ingredient.text!.toLowerCase() == nonVeganIngredient.toLowerCase()){
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
              isVegan = false;
            }
          });
        }
        if(ingredient.vegan == "no"){
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
          isVegan = false;
        }
      });
    }

    debugPrint("Non Vegan ingredients: " + nonVeganIngredientsInProduct);
  }
}
