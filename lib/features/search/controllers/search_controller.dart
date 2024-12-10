import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart'; // Import FavoritesController

class SearchController extends GetxController {
  // Use http.Client to allow dependency injection for testing
  late http.Client httpClient;

  SearchController() {
    httpClient = http.Client(); // Default HTTP client
  }

  final images = <Map<String, dynamic>>[].obs; // Images fetched from API
  final isLoading = false.obs; // Loading state
  final errorMessage = ''.obs; // Error message for API

  final FavoritesController favoritesController =
      Get.find(); // Access FavoritesController

  final String _apiKey = '47540445-ebd11e2ed518d171dd8ff3208';
  int _currentPage = 1; // Track current page
  final int _perPage = 20; // Number of items per page

  // Fetch images from Pixabay API
  Future<void> fetchImages(String query, {bool isPagination = false}) async {
    if (!isPagination) {
      _currentPage = 1; // Reset to the first page on new search
      images.clear();
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final url = Uri.parse(
        'https://pixabay.com/api/?key=$_apiKey&q=${Uri.encodeComponent(query)}&image_type=photo&per_page=$_perPage&page=$_currentPage',
      );

      final response =
          await httpClient.get(url); // Use the injected HTTP client

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['hits'] != null) {
          if (isPagination) {
            images.addAll(List<Map<String, dynamic>>.from(data['hits']));
          } else {
            images.assignAll(List<Map<String, dynamic>>.from(data['hits']));
          }
          _currentPage++; // Increment the page number for the next fetch
        } else {
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

  void toggleFavorite(Map<String, dynamic> image) {
    favoritesController.toggleFavorite(image);
  }

  bool isFavorited(Map<String, dynamic> image) {
    return favoritesController.isFavorited(image);
  }
}
