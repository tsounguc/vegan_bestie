import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantsApiServiceContract {
  Future getRestaurantsNearMe(Position position);
}

class GooglePlacesRestaurantsApiServiceImpl implements RestaurantsApiServiceContract {
  final _apiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];
  final _baseUrl = "https://maps.googleapis.com";
  @override
  Future<http.Response> getRestaurantsNearMe(Position position) async {
    try {
      return http.get(Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${_apiKey}&type=restaurant&latitude=${position.latitude}&longitude${position.longitude}&rankby=distance"));
    } catch (e) {
      throw Exception(e);
    }
  }
}

class YelpFusionRestaurantsApiServiceImpl implements RestaurantsApiServiceContract {
  var _apiKey = dotenv.env['YELP_FUSION_API_KEY']!;
  Map<String, String>? _header;

  final _baseUrl = "https://api.yelp.com/v3";

  @override
  Future<Map<String, dynamic>> getRestaurantsNearMe(Position position) async {
    _header = {
      'Authorization': "Bearer " + _apiKey,
    };
    String platform = Platform.isAndroid
        ? "android"
        : Platform.isIOS
            ? "ios"
            : "";
    final response = await http.get(
      Uri.parse(
          "$_baseUrl/businesses/search?limit=50&distance=50000&latitude=${position.latitude}&longitude=${position.longitude}&term=vegan,vegetarian&categories=restaurants&sort_by=best_match&device_platform=$platform"),
      headers: _header,
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Status code: ${response.statusCode}");
    }
  }
}

class WorldWideRestaurantsApiServiceImp implements RestaurantsApiServiceContract {
  final _baseUrl = "https://worldwide-restaurants.p.rapidapi.com/search";

  final Map<String, String> _headers = {
    "content-type": "application/x-www-form-urlencoded",
    "X-RapidAPI-Key": dotenv.env['WORLD_WIDE_API_KEY']!,
    "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
  };
// "42130" dearborn
//   "42139" detroit
  final body = "language=en_US&limit=100&location_id=42130&currency=USD";

  @override
  Future<http.Response> getRestaurantsNearMe(Position position) async {
    final response = await http.post(
      Uri.parse("$_baseUrl?$body"),
      headers: _headers,
      body: body,
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
}
