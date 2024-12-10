import 'dart:convert';
import '../../../core/constants/api_keys.dart';
import '../../../core/utils/http_client.dart';

class SearchService {
  static Future<List<Map<String, dynamic>>> searchImages(String query) async {
    final url =
        'https://pixabay.com/api/?key=${ApiKeys.pixabayApiKey}&q=$query&image_type=photo';
    final response = await HttpClient.get(url);
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['hits']);
  }
}
