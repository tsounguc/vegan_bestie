import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WorldWideRestaurantsApiProvider {
  final _baseUrl = "https://worldwide-restaurants.p.rapidapi.com/search";

  final Map<String, String> _headers = {
    "content-type": "application/x-www-form-urlencoded",
    "X-RapidAPI-Key": dotenv.env['WORLD_WIDE_API_KEY']!,
    "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
  };
// "42130" dearborn
//   "42139" detroit
  final body = "language=en_US&limit=100&location_id=42130&currency=USD";

  Future<http.Response> searchRestaurants(String query) async {
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
