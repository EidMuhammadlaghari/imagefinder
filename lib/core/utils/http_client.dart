import 'package:http/http.dart' as http;

class HttpClient {
  static Future<http.Response> get(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
