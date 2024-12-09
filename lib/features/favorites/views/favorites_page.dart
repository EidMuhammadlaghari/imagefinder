import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesController controller = Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(
            child: Text('No favorites yet!'),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Adjusted for taller cards
          ),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final image = controller.favorites[index];
            return FavoriteImageTile(image: image, controller: controller);
          },
        );
      }),
    );
  }
}

class FavoriteImageTile extends StatelessWidget {
  final Map<String, dynamic> image;
  final FavoritesController controller;

  FavoriteImageTile({required this.image, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Add rounded corners
      ),
      elevation: 4.0, // Add shadow for a smoother UI
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(8.0), // Clip the image to match card corners
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                image['webformatURL'],
                width: double.infinity,
                fit: BoxFit.cover, // Ensure smooth UI for images
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Owner: ${image['user']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Size: ${(image['imageSize'] / 1024).toStringAsFixed(2)} KB',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Remove Favorite',
                    content: Text(
                        'Do you want to remove this image from favorites?'),
                    confirm: ElevatedButton(
                      onPressed: () {
                        controller.toggleFavorite(image);
                        Get.back(); // Close dialog
                        Get.snackbar(
                          'Favorites Updated',
                          'Image removed from favorites',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                        );
                      },
                      child: Text('Yes'),
                    ),
                    cancel: OutlinedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                      },
                      child: Text('No'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
