//frontend\sway\lib\models\product.dart
class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final List<String> sizes; // Assuming sizes are represented as strings
  final List<String> colors; // Assuming colors are represented as strings
  List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.sizes,
    required this.colors,
    required this.imageUrls,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      sizes: List<String>.from(json['sizes']),
      colors: List<String>.from(json['colors']),
      imageUrls: List<String>.from(json['imageUrls']), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'sizes': sizes,
      'colors': colors,
    };
  }
}

