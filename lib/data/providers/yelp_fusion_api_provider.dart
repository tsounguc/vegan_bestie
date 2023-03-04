import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class YelpFusionApiProvider {
  var _apiKey = dotenv.env['YELP_FUSION_API_KEY']!;
  Map<String, String>? _header;

  final _baseUrl = "https://api.yelp.com/v3";

  Future<http.Response> getLocalRestaurants(Position position) async {
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
          "$_baseUrl/businesses/search?limit=50&distance=50000&latitude=${position.latitude}&longitude=${position.longitude}&term=vegan, vegetarian&categories=restaurants&device_platform=$platform"),
      headers: _header,
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
}
