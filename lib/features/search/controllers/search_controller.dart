import 'package:get/get.dart';
import '/features/favorites/controllers/favorites_controller.dart';

class SearchController extends GetxController {
  final images = [
    {
      'url': 'https://via.placeholder.com/150',
      'owner': 'John Doe',
      'size': 120
    },
    {
      'url': 'https://via.placeholder.com/150',
      'owner': 'Jane Smith',
      'size': 240
    },
    {
      'url': 'https://via.placeholder.com/150',
      'owner': 'Mark Lee',
      'size': 340
    },
    {
      'url': 'https://via.placeholder.com/150',
      'owner': 'Alice Johnson',
      'size': 540
    },
  ].obs;

  // Reference to FavoritesController
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();

  void toggleFavorite(Map<String, dynamic> image) {
    favoritesController.toggleFavorite(image);
  }

  bool isFavorited(Map<String, dynamic> image) {
    return favoritesController.isFavorited(image);
  }
}
