//frontend\sway\lib\screens\wishlist_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import ApiService
import 'package:sway/models/product.dart'; // Import Product model

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Product> _wishlist = []; // List to store wishlist products

  @override
  void initState() {
    super.initState();
    // Fetch wishlist items when screen initializes
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    try {
      List<Product> wishlist = await ApiService.fetchWishlist();
      setState(() {
        _wishlist = wishlist;
      });
    } catch (e) {
      print('Error fetching wishlist: $e');
      // Handle error, e.g., show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: _wishlist.isEmpty
          ? const Center(
              child: Text('Your wishlist is empty.'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _wishlist.length,
              itemBuilder: (context, index) {
                return _buildWishlistItem(_wishlist[index]);
              },
            ),
    );
  }

  Widget _buildWishlistItem(Product product) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(product.description),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _removeFromWishlist(product);
            },
            child: const Text(
              'Remove from Wishlist',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _removeFromWishlist(Product product) async {
    try {
      await ApiService.removeFromWishlist(product.id);
      setState(() {
        _wishlist.remove(product);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product removed from wishlist.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error removing from wishlist: $e');
      // Handle error, e.g., show error message to user
    }
  }
}
