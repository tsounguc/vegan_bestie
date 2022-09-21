import 'package:http/http.dart' as http;

class WorldWideRestaurantsApiProvider {
  static const String _worldWideApiKey = "b5b7d57d38msh8b94e527f90f1b2p10927djsn2180e8402918";
  final _baseUrl = "https://worldwide-restaurants.p.rapidapi.com/search";

  final Map<String, String> _headers = {
    "content-type": "application/x-www-form-urlencoded",
    "X-RapidAPI-Key": _worldWideApiKey,
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
