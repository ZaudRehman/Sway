// lib/models/recommendation.dart

class Recommendation {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  Recommendation({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
