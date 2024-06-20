//frontend\sway\lib\models\order_response.dart
import 'package:sway/models/order.dart';

class OrderResponse {
  final bool isSuccess;
  final Order order;

  OrderResponse({required this.isSuccess, required this.order});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      isSuccess: json['isSuccess'],
      order: Order.fromJson(json['order']),
    );
  }
}
