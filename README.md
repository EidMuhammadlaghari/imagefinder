# ImageFinder Pro

A Flutter-based mobile application that allows users to search for images and save their favorite ones. It integrates with the Pixabay API to fetch images based on user queries. Users can view and manage their favorite images easily within the app.

## Features

- **Image Search**: Search for images using keywords and view them in a grid.
- **Favorites**: Add and remove images from a favorites list.
- **Infinite Scroll**: Load more images as the user scrolls down.
- **Responsive UI**: Optimized for both mobile phones and tablets.

## Tech Stack

- **Flutter**: Framework for building cross-platform applications.
- **GetX**: State management and navigation solution.
- **HTTP**: For making API requests.
- **Pixabay API**: Provides images based on search queries.

## Installation

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Clone the Repository

```bash
git clone https://github.com/your-username/imagefinder-pro.git
```

### Install Dependencies

Navigate to the project folder and run:

```bash
flutter pub get
```

### Run the App

To run the app on your emulator or connected device:

```bash
flutter run
```

## Usage

1. **Search for Images**: Use the search bar to input a keyword and press the "Search" button to fetch images.
2. **View and Manage Favorites**: Tap the heart icon on an image to add or remove it from your favorites.
3. **Navigate to Favorites**: Tap on the "Favorites" icon in the top right corner to view your saved images.

## Testing

The project includes unit and widget tests to ensure functionality. To run tests, use the following command:

```bash
flutter test
```

## Project Structure

```text
lib/
├── config/                  # Configuration files like routes
├── features/
│   ├── favorites/           # Logic and views for favorites feature
│   └── search/              # Logic and views for search feature
├── main.dart                # Entry point of the application
test/
├── mocks/                   # Mocks for testing HTTP requests
├── search_controller_test.dart # Tests for SearchController
└── favorites_controller_test.dart # Tests for FavoritesController
```

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Pixabay API](https://pixabay.com/api/docs/) for providing the image data.
- [GetX](https://pub.dev/packages/get) for state management and routing.
- [Flutter](https://flutter.dev/) for being an amazing framework.
