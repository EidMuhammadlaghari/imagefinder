import 'package:get/get.dart';
import 'package:imagefinder/features/favorites/views/favorites_page.dart';
import 'package:imagefinder/features/search/views/search_page.dart';

final routes = [
  GetPage(name: '/', page: () => SearchPage()),
  GetPage(name: '/favorites', page: () => FavoritesPage()),
];
