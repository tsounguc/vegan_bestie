import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/product_info_model.dart';
import '../../data/models/search_model.dart';
import '../../data/repositoryLayer/repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Repository repository;
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
  bool? isVegan = true;
  SearchModel? _results;
  TextEditingController searchTextController = TextEditingController();

  SearchBloc({required this.repository}) : super(InitialSearchState()) {

    on<SearchQueryChangedEvent>((event, emit){
      emit(SearchQueryChangedState(textControllerText: event.searchQuery));
    });

    on<SearchQueryClearedEvent>((event, emit) {
      emit(InitialSearchState());
      // searchTextController.clear();
    });

    on<SearchQuerySubmittedEvent>((event, emit) async {
      try {
        emit(SearchingState());
        _results = await repository.searchQuery(event.query);
        if (_results?.count == 0 || _results?.count == null) {
          emit(SearchQueryNotFoundState(message: event.query));
        } else if (_results?.count != null && _results!.count! > 0) {
          emit(SearchFoundState(searchResults: _results));
        }
      } on Error catch (e) {
        emit(SearchErrorState(error: "$e \n${e.stackTrace} "));
        throw Exception(e);
      } catch (e) {
        emit(SearchErrorState(error: "$e"));
        debugPrint('Error: $e');
      }
    });


    on<SearchProductPressedEvent>((event, emit) {
      veganCheck(event.selectedProduct);
      emit(SearchProductDetailState(
          selectedProduct: event.selectedProduct,
          nonVeganIngredientsInProduct: nonVeganIngredientsInProduct,
          isVegan: isVegan));
    });

    on<SearchDetailBackButtonPressedEvent>((event, emit) {
      emit(SearchFoundState(searchResults: _results));
    });

    on<SearchButtonPressedEvent>((event, emit){
      emit(InitialSearchState());
    });
  }

  void veganCheck(Product? productInfo) {
    isVegan = true;
    nonVeganIngredientsInProduct = "";
    if (productInfo?.labels == null || productInfo!.labels!.isEmpty) {
      productInfo!.ingredients?.forEach((ingredient) {
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
