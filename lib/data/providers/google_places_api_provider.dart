import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiProvider {
  final _apiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];
  final _baseUrl = "https://maps.googleapis.com";

  Future<http.Response> getRestaurantsNearMe() {
    try {
      return http.get(Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${_apiKey}&type=restaurant&location=42.306274,-83.244563&rankby=distance"));
    } catch (e) {
      throw Exception(e);
    }
  }
}
