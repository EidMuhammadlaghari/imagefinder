class SearchImage {
  final int id;
  final String imageUrl;
  final String owner;
  final int size;

  SearchImage({
    required this.id,
    required this.imageUrl,
    required this.owner,
    required this.size,
  });

  factory SearchImage.fromJson(Map<String, dynamic> json) {
    return SearchImage(
      id: json['id'],
      imageUrl: json['webformatURL'],
      owner: json['user'],
      size: json['imageSize'],
    );
  }
}
