//frontend\sway\lib\models\product_model.dart
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
    );
  }
}
