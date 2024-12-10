import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart';

void main() {
  group('FavoritesController Tests', () {
    late FavoritesController controller;

    setUp(() {
      controller = FavoritesController();
    });

    test('Adds a favorite image', () {
      final image = {'id': 1, 'user': 'test', 'imageSize': 1024};
      controller.toggleFavorite(image);

      expect(controller.favorites.contains(image), isTrue);
    });

    test('Removes a favorite image', () {
      final image = {'id': 1, 'user': 'test', 'imageSize': 1024};
      controller.toggleFavorite(image);
      controller.toggleFavorite(image);

      expect(controller.favorites.contains(image), isFalse);
    });

    test('Checks if an image is favorited', () {
      final image = {'id': 1, 'user': 'test', 'imageSize': 1024};
      controller.toggleFavorite(image);

      expect(controller.isFavorited(image), isTrue);
    });
  });
}
