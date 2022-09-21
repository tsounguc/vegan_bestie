import 'dart:convert';

import 'package:sheveegan/data/models/restaurant_model.dart';

RestaurantsResultsModel restaurantsResultsModelFromJson(String str) =>
    RestaurantsResultsModel.fromJson(json.decode(str));

class RestaurantsResultsModel {
  int? status;
  String? msg;
  Results? results;

  RestaurantsResultsModel({
    required this.status,
    required this.msg,
    required this.results,
  });
  factory RestaurantsResultsModel.fromJson(Map<String, dynamic>? json) => RestaurantsResultsModel(
        status: json?['status'],
        msg: json?['msg'],
        results: Results.fromJson(json?['results']),
      );
}

class Results {
  List<Restaurant>? data;
  // Paging? paging;
  // RestaurantAvailabilityOptions? restaurantAvailabilityOptions;
  // OpenHoursOptions? openHoursOptions;

  Results({required this.data});

  factory Results.fromJson(Map<String, dynamic>? json) => Results(
        data: List<Restaurant>.from(
          json?['data'].map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );
}
