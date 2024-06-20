// File: lib/services/product_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sway/models/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts(int pageKey, int pageSize) async {
    final response = await http.get(
      Uri.parse(
          'https://api.yourbackend.com/products?page=$pageKey&size=$pageSize'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
