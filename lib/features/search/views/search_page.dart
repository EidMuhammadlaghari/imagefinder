import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as custom;

class SearchPage extends StatelessWidget {
  final custom.SearchController controller = Get.put(custom.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Images'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.toNamed('/favorites'); // Navigate to the Favorites screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Simulate search by fetching static images
                    // Replace this with API logic later
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  final image = controller.images[index];
                  return ImageTile(image: image, controller: controller);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  final Map<String, dynamic> image;
  final custom.SearchController controller;

  ImageTile({required this.image, required this.controller});

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
                    onTap: () => controller.toggleFavorite(image),
                    child: Obx(() {
                      return Icon(
                        controller.isFavorited(image)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isFavorited(image)
                            ? Colors.red
                            : Colors.grey,
                      );
                    }),
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
