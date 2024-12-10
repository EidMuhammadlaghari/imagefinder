import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart';
import 'config/routes.dart';
// import 'features/favorites/controllers/favorites_controller.dart'; // Import FavoritesController
import 'package:imagefinder/features/search/controllers/search_controller.dart'
    as custom; // Import SearchController (needed for dependency injection during tests)

void main() {
  // Ensure all bindings and dependencies are ready for tests or production
  setupDependencies();

  runApp(MyApp());
}

void setupDependencies() {
  // Dependency Injection: Ensure controllers are registered only once
  if (!Get.isRegistered<FavoritesController>()) {
    Get.put(FavoritesController());
  }
  if (!Get.isRegistered<custom.SearchController>()) {
    Get.put(custom.SearchController());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImageFinder Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: routes,
    );
  }
}
