import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.main.dart';
import '../../../../core/services/vegan_checker.dart';
import '../../domain/entities/search_product_entity.dart';
import '../../domain/usecases/search_product_usecase.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductUseCase _searchProductUseCase = serviceLocator<SearchProductUseCase>();
  VeganChecker veganChecker = VeganChecker();
  List<SearchProductEntity>? _products;
  TextEditingController searchTextController = TextEditingController();

  SearchBloc() : super(SearchInitialState()) {
    on<SearchQueryChangedEvent>((event, emit) {
      emit(SearchQueryChangedState(textControllerText: event.searchQuery));
    });

    on<SearchQueryClearedEvent>((event, emit) {
      emit(SearchInitialState());
    });

    on<SearchQuerySubmittedEvent>((event, emit) async {
      emit(SearchingState());
      final Either<SearchProductFailure, List<SearchProductEntity>> searchProductResults =
          await _searchProductUseCase.searchProduct(event.query);
      searchProductResults.fold(
          (searchProductFailure) => emit(SearchErrorState(error: searchProductFailure.message)), (searchProducts) {
        _products = searchProducts;
        if (searchProducts == null || searchProducts.isEmpty) {
          emit(SearchQueryNotFoundState(message: "No products found"));
        } else {
          emit(SearchFoundState(searchProducts: searchProducts));
        }
      });
    });

    on<SearchProductPressedEvent>((event, emit) {
      // bool isVegan = veganChecker.veganCheck(event.selectedProduct);
      emit(
        SearchProductDetailState(
          selectedProduct: event.selectedProduct,
          nonVeganIngredientsInProduct: veganChecker.nonVeganIngredientsInProduct,
          isVegan: false,
        ),
      );
    });

    on<SearchDetailBackButtonPressedEvent>((event, emit) {
      emit(SearchFoundState(searchProducts: _products!));
    });

    on<SearchButtonPressedEvent>((event, emit) {
      emit(SearchInitialState());
    });
  }
}
