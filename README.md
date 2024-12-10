Sure! Here's the full `README.md` for your GitHub project:

```markdown
# Image Finder App

A Flutter app that allows users to search for images and mark them as favorites. The app uses the **GetX** package for state management and dependency injection, and the **mockito** package for mocking HTTP requests in tests.

## Features
- **Search for Images**: Users can search for images by entering a query in a search bar.
- **Favorites**: Users can mark images as favorites and view them on a separate page.
- **Responsive UI**: The app is built to be responsive and looks great on both Android and iOS devices.
- **Testing**: Includes unit tests and widget tests to ensure the correctness of functionality.

## Screenshots
![Search Page](screenshots/search_page.png)
![Favorites Page](screenshots/favorites_page.png)

## Installation

### Prerequisites

Before running the project, ensure you have the following installed:
- **Flutter**: The latest stable version of Flutter.
- **Android Studio** (for Android development) or **Xcode** (for iOS development).
- **Dart**: Dart is required as Flutter uses Dart as its programming language.

### Setup

1. Clone this repository:

    ```bash
    git clone https://github.com/yourusername/imagefinder.git
    ```

2. Navigate into the project directory:

    ```bash
    cd imagefinder
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app on an emulator or a physical device:

    ```bash
    flutter run
    ```

## Architecture

This app follows a clean architecture pattern using **GetX** for state management and dependency injection. The app has the following main components:

### 1. **Controllers**
   - **FavoritesController**: Manages the state for the favorite images, including adding/removing images to/from the favorites list.
   - **SearchController**: Handles the logic for fetching images based on a search query and managing the results.

### 2. **Views**
   - **SearchPage**: The screen where users can enter a search query to find images.
   - **FavoritesPage**: Displays the list of images that have been marked as favorites by the user.

### 3. **Models**
   - The app uses simple `Map<String, dynamic>` objects to represent image data, including the image ID, URL, and other metadata.

## Testing

The app includes unit tests and widget tests to ensure the correctness of various components.

### Running Tests

To run the unit tests, use the following command:

```bash
flutter test
```

This will execute all the tests, including the unit tests for the controllers and widget tests for the UI components.

### Example Unit Tests

- **FavoritesController** tests: Ensures that the controller adds/removes images correctly from the favorites list.
- **SearchController** tests: Verifies the image search functionality and error handling.

### Example Widget Tests

- **FavoritesPage** tests: Ensures that the favorites page displays correctly and shows a message when no favorites are added.
- **SearchPage** tests: Verifies that the search page displays a search bar and triggers the search when the button is clicked.

### Test Environment

For the tests, we use **mockito** for mocking HTTP responses in the `SearchController` tests. Widget tests are performed using the `flutter_test` package.

### Example Test Code

#### Unit Test for FavoritesController

```dart
test('Adds a favorite image', () {
  final image = {'id': 1, 'user': 'test', 'imageSize': 1024};
  controller.toggleFavorite(image);
  expect(controller.favorites.contains(image), isTrue);
});
```

#### Widget Test for FavoritesPage

```dart
testWidgets('FavoritesPage displays favorites in a grid', (WidgetTester tester) async {
  final controller = Get.find<FavoritesController>();
  controller.toggleFavorite({
    'id': 1,
    'webformatURL': 'https://example.com/image.jpg',
    'user': 'Test User',
    'imageSize': 1024,
  });

  await tester.pumpWidget(GetMaterialApp(home: FavoritesPage()));

  expect(find.byType(GridView), findsOneWidget);
  expect(find.text('Test User'), findsOneWidget);
});
```

## Contributing

We welcome contributions to this project! If you'd like to contribute, please fork the repository, make your changes, and submit a pull request.

### Guidelines:
- Write tests for new features or bug fixes.
- Follow the existing code style.
- Ensure that your changes do not break existing functionality.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- [GetX](https://pub.dev/packages/get) for state management and dependency injection.
- [Mockito](https://pub.dev/packages/mockito) for mocking HTTP responses in tests.
- [Flutter](https://flutter.dev) for providing an excellent framework for building cross-platform mobile apps.
```
