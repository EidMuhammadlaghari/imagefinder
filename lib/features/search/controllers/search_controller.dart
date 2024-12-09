import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart'; // Import FavoritesController

class SearchController extends GetxController {
  final images = <Map<String, dynamic>>[].obs; // Images fetched from API
  final isLoading = false.obs; // Loading state
  final errorMessage = ''.obs; // Error message for API

  final FavoritesController favoritesController =
      Get.find(); // Access FavoritesController

  // API key for Pixabay
  final String _apiKey = '47540445-ebd11e2ed518d171dd8ff3208';

  // Fetch images from Pixabay API
  Future<void> fetchImages(String query) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final url = Uri.parse(
        'https://pixabay.com/api/?key=$_apiKey&q=${Uri.encodeComponent(query)}&image_type=photo&per_page=20',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['hits'] != null) {
          images.assignAll(List<Map<String, dynamic>>.from(data['hits']));
        } else {
          images.clear();
          errorMessage.value = 'No images found.';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  // Delegate toggleFavorite to FavoritesController
  void toggleFavorite(Map<String, dynamic> image) {
    favoritesController.toggleFavorite(image);
  }

  // Delegate isFavorited to FavoritesController
  bool isFavorited(Map<String, dynamic> image) {
    return favoritesController.isFavorited(image);
  }
}
