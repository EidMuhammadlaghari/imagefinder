import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesController controller = Get.put(FavoritesController());

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
            childAspectRatio: 0.7,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  image['url'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      // Show confirmation dialog
                      Get.defaultDialog(
                        title: 'Remove Favorite',
                        content: Text(
                            'Do you want to remove this image from favorites?'),
                        confirm: ElevatedButton(
                          onPressed: () {
                            controller.toggleFavorite(image);
                            Get.back(); // Close dialog
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
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Owner: ${image['owner']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Size: ${(image['size'] / 1024).toStringAsFixed(2)} MB',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
