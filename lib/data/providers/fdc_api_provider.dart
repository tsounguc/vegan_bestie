import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show Client;

class FDCApiProvider {
  final _apiKey = dotenv.env['FDC_API_KEY'];
  Client client = Client();
  final _baseUrl = "https://api.nal.usda.gov/fdc";

  fetchProduct() async {
    final response = await client.get(Uri.parse("$_baseUrl/v1/foods/search?api_key=$_apiKey&query=almond milk"));
    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}
