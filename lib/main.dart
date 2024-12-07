import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'features/favorites/controllers/favorites_controller.dart'; // Import FavoritesController

void main() {
  // Register the FavoritesController
  Get.put(FavoritesController());

  runApp(MyApp());
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
