import 'package:get/get.dart';
import '../features/search/views/search_page.dart';
import '../features/favorites/views/favorites_page.dart'; // Import FavoritesPage

final routes = [
  GetPage(name: '/', page: () => SearchPage()),
  GetPage(name: '/favorites', page: () => FavoritesPage()),
];
