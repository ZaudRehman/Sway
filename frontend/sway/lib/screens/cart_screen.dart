//frontend\sway\lib\screens\cart_screen.dart
import 'package:flutter/material.dart';
import 'package:sway/models/cart_item.dart';
import 'package:sway/models/order.dart';
import 'package:sway/services/api_service.dart';
import 'package:sway/models/order_details.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];
  double _totalCost = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }


  Future<void> _loadCartItems() async {
    _cartItems = await ApiService.getCartItems();
    _calculateTotalCost();
  }

  void _calculateTotalCost() {
    _totalCost =
        _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  Future<void> _fetchCartItems() async {
    List<CartItem> items = await ApiService.getCartItems();
    setState(() {
      _cartItems = items;
      _totalCost = items.fold(0, (sum, item) => sum + item.price * item.quantity);
    });
  }

  Future<void> _applyDiscount(String couponCode) async {
    try {
      final response = await ApiService.applyDiscount(couponCode, _cartItems, _totalCost);
      if (response.isValid) {
        setState(() {
          _totalCost = response.newTotalCost;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _placeOrder() async {
    try {
      final response = await ApiService.placeOrder(OrderDetails(totalCost: _totalCost, cartItems: _cartItems));
      if (response.isSuccess) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderConfirmationScreen(order: response.order as Order)));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: _cartItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return ListTile(
                  leading: Image.network(item.imageUrl),
                  title: Text(item.name),
                  subtitle: Text(
                      'Price: \$${item.price}, Quantity: ${item.quantity}'),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$$_totalCost'),
              ElevatedButton(
                onPressed: _placeOrder,
                child: const Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

