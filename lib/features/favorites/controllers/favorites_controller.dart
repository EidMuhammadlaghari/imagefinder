import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final favorites = <Map<String, dynamic>>[].obs;

  // Add or remove favorite
  void toggleFavorite(Map<String, dynamic> image) {
    if (favorites.contains(image)) {
      favorites.remove(image);
    } else {
      favorites.add(image);
    }
  }

  // Check if an image is favorited
  bool isFavorited(Map<String, dynamic> image) {
    return favorites.contains(image);
  }
}
