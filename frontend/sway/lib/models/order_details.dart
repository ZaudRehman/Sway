//frontend\sway\lib\models\order_details.dart
import 'package:sway/models/cart_item.dart';

class OrderDetails {
  final double totalCost;
  final List<CartItem> cartItems;

  OrderDetails({
    required this.totalCost,
    required this.cartItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalCost': totalCost,
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }
}
