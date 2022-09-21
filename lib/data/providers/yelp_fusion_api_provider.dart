import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class YelpFusionApiProvider {
  static const String _yelpFusionApiKey =
      "Bearer IcjcftI_MF2Sm3zEz4wgo14s_fTjQSBMDeQLUZRzZX5NyxgU67nqmd8DTrnJrAc3HRWHZIhQE5mXmx3uwPS8V3CUaDieR9rQiahil6Yjk3_CjatDuLL4qPqrfrHyYnYx";
  final Map<String, String> _header = {
    'Authorization': _yelpFusionApiKey,
  };

  final _baseUrl = "https://api.yelp.com/v3";

  Future<http.Response> getLocalRestaurants(Position position) async {
    final response = await http.get(
      Uri.parse(
          "$_baseUrl/businesses/search?limit=50&distance=50000&latitude=${position.latitude}&longitude=${position.longitude}&term=vegan, vegetarian&categories=restaurants"),
      headers: _header,
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }
}
