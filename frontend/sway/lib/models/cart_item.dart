//frontend\sway\lib\models\cart_item.dart
class CartItem {
  String id;
  String name;
  String imageUrl;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}

