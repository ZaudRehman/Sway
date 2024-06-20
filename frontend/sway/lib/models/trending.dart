// lib/models/trending.dart

class Trending {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  Trending({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Trending.fromJson(Map<String, dynamic> json) {
    return Trending(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
