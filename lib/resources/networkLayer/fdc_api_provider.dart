import 'package:http/http.dart' show Client;

class FDCApiProvider {
  Client client = Client();
  final _apiKey = "gfIuN9hEFmeu0nvgVFUBChXF9Mq54Hiy794BUORr";
  final _baseUrl = "https://api.nal.usda.gov/fdc";

  fetchProduct() async {
    final response = await client.get(Uri.parse("$_baseUrl/v1/foods/search?api_key=$_apiKey&query=almond milk"));
    if(response.statusCode == 200){
      print(response.body);
    }
  }
}
