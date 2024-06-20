//frontend\sway\lib\models\order.dart
import 'package:sway/models/cart_item.dart';

class Order {
  final List<OrderItem> items; // Assuming this represents detailed order items
  final DateTime estimatedDeliveryDate;
  final String orderNumber;
  final String status;
  final String id;
  final double totalCost;
  final List<CartItem> cartItems; // Assuming this is a list of cart items

  Order({
    required this.items,
    required this.estimatedDeliveryDate,
    required this.orderNumber,
    required this.status,
    required this.id,
    required this.totalCost,
    required this.cartItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Assuming 'items' here is a list of detailed OrderItem objects
    List<OrderItem> items = (json['items'] as List)
        .map((itemJson) => OrderItem.fromJson(itemJson))
        .toList();

    return Order(
      items: items,
      estimatedDeliveryDate: DateTime.parse(json['estimatedDeliveryDate']),
      orderNumber: json['orderNumber'],
      status: json['status'],
      id: json['id'],
      totalCost: json['totalCost'].toDouble(),
      cartItems: (json['cartItems'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  final String imageUrl;
  final String name;
  final int quantity;

  OrderItem({
    required this.imageUrl,
    required this.name,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      imageUrl: json['imageUrl'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}
