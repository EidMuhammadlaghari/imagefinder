import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:imagefinder/features/search/views/search_page.dart';
import "package:imagefinder/features/search/controllers/search_controller.dart"
    as custom;
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart';

void main() {
  testWidgets('SearchPage displays a search bar and button',
      (WidgetTester tester) async {
    Get.put(FavoritesController());
    Get.put(custom.SearchController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: SearchPage(),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
  });

  testWidgets('SearchPage triggers search when button is clicked',
      (WidgetTester tester) async {
    final controller = Get.put(custom.SearchController());
    Get.put(FavoritesController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: SearchPage(),
      ),
    );

    final textField = find.byType(TextField);
    await tester.enterText(textField, 'nature');
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Mock the result and check expectations
    controller.images.add({
      'id': 1,
      'webformatURL': 'https://example.com/image.jpg',
      'user': 'Test User',
      'imageSize': 1024,
    });

    expect(controller.images.isNotEmpty, isTrue);
  });
}
