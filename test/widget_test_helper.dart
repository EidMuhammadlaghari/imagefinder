import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart';

void setupWidgetTest() {
  // Ensure dependencies are initialized
  if (!Get.isRegistered<FavoritesController>()) {
    Get.put(FavoritesController());
  }
  if (!Get.isRegistered<SearchController>()) {
    Get.put(SearchController());
  }
}

Widget wrapWithMaterialApp(Widget child) {
  return GetMaterialApp(
    home: child,
  );
}
