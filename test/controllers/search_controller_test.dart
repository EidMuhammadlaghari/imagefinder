import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:imagefinder/features/search/controllers/search_controller.dart';
import 'package:imagefinder/features/favorites/controllers/favorites_controller.dart';
import '../mocks/mock_http_client.mocks.dart';

void main() {
  late MockClient mockClient;
  late SearchController searchController;

  setUp(() {
    mockClient = MockClient();
    Get.put(FavoritesController());
    searchController = SearchController();

    // Replace the http.Client in the controller with the mock
    searchController.httpClient = mockClient;
  });

  group('SearchController Tests', () {
    test('fetchImages populates images on success', () async {
      const String query = 'nature';
      final mockResponse = {
        'hits': [
          {
            'id': 1,
            'webformatURL': 'https://example.com/image1.jpg',
            'user': 'test_user',
            'imageSize': 1024
          },
        ],
      };

      // Mock HTTP response
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(json.encode(mockResponse), 200));

      await searchController.fetchImages(query);

      expect(searchController.images.isNotEmpty, isTrue);
      expect(searchController.images.first['id'], 1);
    });

    test('fetchImages handles empty results', () async {
      const String query = 'nature';
      final mockResponse = {'hits': []};

      // Mock HTTP response
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(json.encode(mockResponse), 200));

      await searchController.fetchImages(query);

      expect(searchController.images.isEmpty, isTrue);
    });

    test('fetchImages sets errorMessage on failure', () async {
      const String query = 'nature';

      // Mock HTTP response with an error
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('Error', 500));

      await searchController.fetchImages(query);

      expect(searchController.errorMessage.isNotEmpty, isTrue);
      expect(searchController.errorMessage.value, 'Error: 500');
    });
  });
}
