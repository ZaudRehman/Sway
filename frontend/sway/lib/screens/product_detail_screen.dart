//frontend\sway\lib\screens\product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:sway/models/product.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product
      product; // Assume Product class is defined with necessary fields

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageGallery(),
            _buildProductInformation(),
            _buildSizeChart(),
            _buildColorOptions(),
            _buildReviewsSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    // Implement image gallery with zoom capability
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(
            product.imageUrls[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildProductInformation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Price: \$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeChart() {
    // Implement size chart section
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Add your size chart details here
          Text('S: 28-30\nM: 32-34\nL: 36-38\nXL: 40-42'),
        ],
      ),
    );
  }

  Widget _buildColorOptions() {
    // Implement color options section
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Color Options',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Add your color options here, could be a ListView of Color Chips
          Row(
            children: [
              _buildColorOption(color: Colors.red),
              _buildColorOption(color: Colors.blue),
              _buildColorOption(color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption({required Color color}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildReviewsSection() {
    // Implement reviews section with filterable reviews
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews & Ratings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Add reviews list or rating stars here
          Text('4.5/5 based on 100 reviews'),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    // Implement Add to Cart and Buy Now buttons
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle Add to Cart action
            },
            child: const Text('Add to Cart'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle Buy Now action
            },
            child: const Text('Buy Now'),
          ),
        ],
      ),
    );
  }
}
