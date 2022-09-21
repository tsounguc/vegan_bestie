import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class YelpFusionApiProvider {
  final Map<String, String> _header = {
    'Authorization': "Bearer ${dotenv.env['YELP_FUSION_API_KEY']}",
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
