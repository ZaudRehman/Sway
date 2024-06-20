//frontend\sway\lib\services\cart_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sway/models/cart_item.dart';

class CartService {
  static const String baseUrl = 'http://127.0.0.1:5000/api/cart';

  static Future<List<CartItem>> fetchCartItems() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CartItem> cartItems =
          data.map((json) => CartItem.fromJson(json)).toList();
      return cartItems;
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}
