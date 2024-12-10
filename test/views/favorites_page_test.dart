// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:imagefinder/features/favorites/views/favorites_page.dart';
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart';

void main() {
  setUp(() {
    if (!Get.isRegistered<FavoritesController>()) {
      Get.put(FavoritesController());
    }
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('FavoritesPage shows message if no favorites are added',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: FavoritesPage(),
      ),
    );

    expect(find.text('No favorites yet!'), findsOneWidget);
  });
}
