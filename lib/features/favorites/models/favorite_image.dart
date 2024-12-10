class FavoriteImage {
  final int id;
  final String imageUrl;
  final String owner;
  final int size;

  FavoriteImage({
    required this.id,
    required this.imageUrl,
    required this.owner,
    required this.size,
  });

  factory FavoriteImage.fromJson(Map<String, dynamic> json) {
    return FavoriteImage(
      id: json['id'],
      imageUrl: json['webformatURL'],
      owner: json['user'],
      size: json['imageSize'],
    );
  }
}
