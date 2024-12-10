import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagefinder/features/search/controllers/search_controller.dart'
    as custom;

class SearchPage extends StatelessWidget {
  final custom.SearchController controller = Get.put(custom.SearchController());
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Add listener for infinite scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Trigger pagination when the user scrolls to the bottom
        final query = searchController.text.trim();
        if (query.isNotEmpty && !controller.isLoading.value) {
          controller.fetchImages(query, isPagination: true);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Images'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.toNamed('/favorites');
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
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final query = searchController.text.trim();
                    if (query.isNotEmpty) {
                      controller.fetchImages(query); // Start fresh search
                    }
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.images.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }
              if (controller.images.isEmpty) {
                return Center(child: Text('No images found. Please search.'));
              }
              return GridView.builder(
                controller: _scrollController, // Use the scroll controller
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
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
              child: Stack(
                children: [
                  Image.network(
                    image['webformatURL'],
                    width: double.infinity,
                    fit: BoxFit.cover, // Ensure image fills its container
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
                    },
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        controller.toggleFavorite(image);
                        Get.snackbar(
                          'Favorites Updated',
                          controller.isFavorited(image)
                              ? 'Image added to favorites'
                              : 'Image removed from favorites',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                        );
                      },
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
                    'Owner: ${image['user']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // Truncate if text is too long
                  ),
                  Text(
                    'Size: ${(image['imageSize'] / 1024).toStringAsFixed(2)} KB',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
