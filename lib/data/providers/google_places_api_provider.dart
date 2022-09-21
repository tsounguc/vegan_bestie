import 'package:http/http.dart' as http;

class GooglePlacesApiProvider {
  static const String _key = "AIzaSyDuY9PTMORog1oIv36qdojLvypoddmmvRY";
  // final _baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyDuY9PTMORog1oIv36qdojLvypoddmmvRY&keyword=restaurant&location=42.331429,-83.045753&radius=1500";
  final _baseUrl = "https://maps.googleapis.com";

  Future<http.Response> getRestaurantsNearMe() {
    try {
      // return http.get(Uri.parse(
      //     '$_baseUrl/maps/api/place/nearbysearch/json6?key=${_key}&type=restaurant&location=42.331429,-83.045753&radius=1500'));
      // return http.get(Uri.parse(
      //     "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyDuY9PTMORog1oIv36qdojLvypoddmmvRY&type=restaurant&location=42.306274,-83.244563&radius=100000"));
      return http.get(Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyDuY9PTMORog1oIv36qdojLvypoddmmvRY&type=restaurant&location=42.306274,-83.244563&rankby=distance"));
    } catch (e) {
      throw Exception(e);
    }
  }
}
